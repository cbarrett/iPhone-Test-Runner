//
//  TestRunnerMain.m
//  UIKit Unit Test
//
//  Created by Colin Barrett on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"TestRunnerDelegate");
    [pool release];
    return retVal;
}