//
//  UIKit_Unit_TestAppDelegate.m
//  UIKit Unit Test
//
//  Created by Colin Barrett on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "UIKit_Unit_TestAppDelegate.h"

@implementation UIKit_Unit_TestAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
