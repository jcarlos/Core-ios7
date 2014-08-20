//
//  UIView+Custom.m
//  Level1-Appearance
//
//  Created by Jon Friskics on 9/19/13.
//  Copyright (c) 2013 Jon Friskics. All rights reserved.
//

#import "UIView+Custom.h"
#import "CSSwizzler.h"

@implementation UIView (Custom)

+ (void)load
{
    [CSSwizzler swizzleClass:[UIView class] replaceClassMethod:@selector(appearance) withMethod:@selector(custom_appearance)];
}

- (instancetype)custom_appearance
{
    NSLog(@"testing");
    return [self custom_appearance];
}

@end
