//
//  TestRunnerDelegate.m
//  UIKit Unit Test
//
//  Created by Colin Barrett on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestRunnerDelegate.h"
#import <SenTestingKit/SenTestingKit.h>

@implementation TestRunnerDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    return;
    
    NSLog(@"Arguments: %@", [[NSProcessInfo processInfo] arguments]);
    NSString *testBundlePath = [[[NSProcessInfo processInfo] arguments] lastObject];
    if (testBundlePath) {
        [[NSUserDefaults standardUserDefaults] setObject:testBundlePath forKey:SenTestedUnitPath];
        [[NSUserDefaults standardUserDefaults] setObject:SenTestScopeAll forKey:SenTestScopeKey];
    }
    
    int exitStatus = SenSelfTestMain();
    
    // XXX does this even get called? SenSelfTestMain whyyyy
    
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
