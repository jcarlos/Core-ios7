//
//  CSRecordingTestCase.m
//  CoreiOS7ExampleProject
//
//  Created by Eric Allam on 8/29/13.
//  Copyright (c) 2013 Eric Allam. All rights reserved.
//

#import "CSRecordingTestCase.h"
#import "TestRecorder.h"

@implementation CSRecordingTestCase

- (void) performTest:(XCTestRun *) aRun;
{
    [super performTest:aRun];
    
    [TestRecorder recordTestRun:aRun];
}

@end
