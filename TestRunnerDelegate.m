//
//  TestRunnerDelegate.m
//  UIKit Unit Test
//
//  Created by Colin Barrett on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestRunnerDelegate.h"
#import <SenTestingKit/SenTestingKit.h>
#import <objc/runtime.h>

Class class_isDescendedFromClass_TestRunner(Class child, Class ancestor)
{
    Class c = child;
    do {
        if (c == ancestor) {
            return YES;
        }
    } while (c = class_getSuperclass(c));
    return NO;
}

@implementation TestRunnerDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    /*
     XXX Current line of thinking brain dump:
     √ Walk the class hierarchy and look for tests that are subclasses of SenTestCase.
     - Run each test (look at GTM)
     - Once all the tests are run exit with the right status code.
     We don't need to do any logging because of SenTestObserver (I think).
     */
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    NSParameterAssert(numClasses > 0);
    classes = malloc(sizeof(Class) * numClasses);
    objc_getClassList(classes, numClasses);
    
    for (int i = 0; i < numClasses; i++) {
        Class c = classes[i];
        if (class_isDescendedFromClass_TestRunner(c, objc_getClass("SenTestCase"))) {
            NSString *className = NSStringFromClass(c);
            if ([className isEqualToString:@"SenInterfaceTestCase"]) {
                continue;
            }
            NSLog(@"%@", className);
        }
    }
    
    free(classes);
    
    int exitStatus = 0;
        
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
