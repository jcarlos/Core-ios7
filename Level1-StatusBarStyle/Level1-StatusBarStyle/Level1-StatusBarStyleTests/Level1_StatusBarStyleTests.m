#import <XCTest/XCTest.h>
#import "CSRecordingTestCase.h"
#import "CSPropertyDefinition.h"
#import "CSTakePhotoVC.h"
#import "CSAboutVC.h"

@interface Level1_StatusBarTests : CSRecordingTestCase

@end

@implementation Level1_StatusBarTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testTakePhotoPrefersStatusBarHidden
{
    CSTakePhotoVC *takePhotoVC = [[CSTakePhotoVC alloc] init];
    XCTAssert(takePhotoVC.prefersStatusBarHidden, @"Did not return YES in CSTakePhotoVC's prefersStatusBarHidden method");
}

- (void)testSetAboutPreferredStatusBarStyleToLightContent
{
    CSAboutVC *aboutVC = [[CSAboutVC alloc] init];
    XCTAssert(aboutVC.preferredStatusBarStyle == UIStatusBarStyleLightContent, @"Did not set CSAboutVC's preferredStatusBarStyle method to UIStatusBarStyleLightContent");
}

@end
