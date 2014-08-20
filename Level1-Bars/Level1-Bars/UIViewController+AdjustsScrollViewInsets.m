//
//  UIViewController+AdjustsScrollViewInsets.m
//  Level1-Bars
//
//  Created by Jon Friskics on 9/18/13.
//  Copyright (c) 2013 Jon Friskics. All rights reserved.
//

#import "UIViewController+AdjustsScrollViewInsets.h"
#import "CSSwizzler.h"
#import "CSWebVC.h"

@implementation UIViewController (AdjustsScrollViewInsets)

+ (void) load
{
    [CSSwizzler swizzleClass:[UIViewController class]
               replaceMethod:@selector(automaticallyAdjustsScrollViewInsets)
                  withMethod:@selector(custom_automaticallyAdjustsScrollViewInsets)];
    
}

- (BOOL)custom_automaticallyAdjustsScrollViewInsets
{
    [self custom_automaticallyAdjustsScrollViewInsets];
    if([self isKindOfClass:[CSWebVC class]]) {
        return NO;
    }
    else return YES;
}

@end
