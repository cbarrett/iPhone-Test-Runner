//
//  UILabelTest.m
//  UIKit Unit Test
//
//  Created by Colin Barrett on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

@interface UILabelTest : SenTestCase
{

}

@end


@implementation UILabelTest

- (void)testUILabel
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
    STAssertNotNil(l, @"UILabel failed to initialize");
    [l release];
}

@end
