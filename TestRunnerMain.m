//
//  TestRunnerMain.m
//  UIKit Unit Test
//
//  Created by Colin Barrett on 2/21/10.
//  Copyright 2010 Springs & Struts. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <objc/runtime.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"TestRunnerDelegate");
    [pool release];
    return retVal;
}

BOOL class_isDescendedFromClass_TestRunner(Class child, Class ancestor)
{
    Class c = child;
    while (c = class_getSuperclass(c)) {
        if (c == ancestor) {
            return YES;
        }
    }
    return NO;
}

@interface TestRunnerDelegate : NSObject <UIApplicationDelegate> { }
@end

@implementation TestRunnerDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // This enables the default observer, SenTestLog, to watch all test running notifications and emit the logging statements Xcode's looking for.
    [SenTestObserver resumeObservation];
    SenTestSuite *allTests = [[SenTestSuite alloc] initWithName:@"All Tests"];
    
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    NSParameterAssert(numClasses > 0);
    classes = malloc(sizeof(Class) * numClasses);
    objc_getClassList(classes, numClasses);
    
    for (int i = 0; i < numClasses; i++) {
        Class testCaseClass = classes[i];
        if (class_isDescendedFromClass_TestRunner(testCaseClass, objc_getClass("SenTestCase"))) {
            NSString *className = NSStringFromClass(testCaseClass);
            // This class comes with SenTesting and we don't want to run all zero of its tests.
            if ([className isEqualToString:@"SenInterfaceTestCase"]) {
                continue;
            }
            
            SenTestSuite *suite = [SenTestSuite testSuiteForTestCaseClass:testCaseClass];
            [allTests addTest:suite];
        }
    }
    
    free(classes);
    
    SenTestRun *run = [allTests run];
    int exitStatus = [run hasSucceeded] ? 0 : 1;
    
    // Cribbed from GTMIPhoneUnitTestDelegate
    if (!getenv("TEST_RUNNER_DISABLE_TERMINATION")) {
        // Alternative to exit(status); so it cleanly terminates the UIApplication
        // and classes that depend on this signal to exit cleanly.
        if ([application respondsToSelector:@selector(_terminateWithStatus:)]) {
            [application performSelector:@selector(_terminateWithStatus:)
                              withObject:(id)exitStatus];
        } else {
            NSLog(@"Didn't use -[UIApplication _terminateWithStatus:] SPI. Remove it?");
            exit(exitStatus);
        }
    }    
}

@end
