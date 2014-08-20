#import <XCTest/XCTest.h>
#import "CSRecordingTestCase.h"
#import "CSPropertyDefinition.h"
#import "AppDelegate.h"
#import "CSTakePhotoVC.h"
#import "CSAboutVC.h"
#import "CSWebVC.h"

@interface Level1_BarsTests : CSRecordingTestCase {
    AppDelegate *_appDel;
    CSAboutVC *_aboutVC;
    UINavigationController *_aboutVCNav;
    CSWebVC *_webVC;
}

@end

@implementation Level1_BarsTests

- (void)setUp
{
    [super setUp];
    
    _appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [(UITabBarController *)_appDel.window.rootViewController setSelectedIndex:2];
    
    _aboutVCNav = (UINavigationController *)[[(UITabBarController *)_appDel.window.rootViewController viewControllers] objectAtIndex:2];
    _aboutVC = (CSAboutVC *)_aboutVCNav.topViewController;
}

- (void)tearDown
{
    [super tearDown];
    [(UITabBarController *)_appDel.window.rootViewController setSelectedIndex:0];
    [_aboutVCNav setViewControllers:@[_aboutVC] animated:NO];
    _appDel = nil;
    _aboutVC = nil;
    _aboutVCNav = nil;
    _webVC = nil;
}


- (void)testUpdatedFrameForContentSubviews
{
    CSPropertyDefinition *property = [self contentSubviewProperty];
    [_aboutVCNav.view layoutIfNeeded];
    
    if(property) {
        UIScrollView *contentSubviewProperty = [_aboutVC valueForKey:@"contentSubview"];
        XCTAssert(contentSubviewProperty.frame.origin.y == 0, @"Did not remove self.topLayoutGuide.length from contentSubview's frame.origin.y calculation");
        XCTAssert(contentSubviewProperty.frame.size.height == _aboutVC.view.frame.size.height, @"Did not remove self.topLayoutGuide.length from contentSubview's frame.origin.size.height");
    } else {
        XCTFail(@"You need to update contentSubview to be a UIScrollView before attempting this challenge");
    }
}

- (void)testSetContentSize
{
    CSPropertyDefinition *property = [self contentSubviewProperty];
    [_aboutVCNav.view layoutIfNeeded];
    if(property) {
        UIScrollView *contentSubviewProperty = [_aboutVC valueForKey:@"contentSubview"];
        XCTAssert(contentSubviewProperty.contentSize.width == _aboutVC.view.frame.size.width, @"Did not set the width of the contentSubview's contentSize property to the width of self.view.frame");
        XCTAssert(contentSubviewProperty.contentSize.height == CGRectGetMaxY(_aboutVC.csInfoTextView.frame) + 25, @"Did not set the width of the contentSubview's contentSize property to the width of self.view.frame");
    } else {
        XCTFail(@"You need to update contentSubview to be a UIScrollView before attempting this challenge");
    }
}


- (void)testWebVCContentInsets
{
    [_aboutVC logoTapped:nil];
    _webVC = (CSWebVC *)_aboutVCNav.topViewController;
    [_aboutVCNav setViewControllers:@[_webVC] animated:NO];
    [_aboutVCNav.view layoutIfNeeded];
    [_webVC.view layoutIfNeeded];
    
    CSPropertyDefinition *property = [self webviewProperty];

    if(property) {
        UIWebView *webviewProperty = [_webVC valueForKey:@"webView"];
        XCTAssert(webviewProperty.scrollView.contentInset.top == 64, @"Did not set contentInset to have a top inset of 64 pts");
        XCTAssert(webviewProperty.scrollView.contentInset.bottom == 49, @"Did not set contentInset to have a bottom inset of 49 pts");
    } else {
        XCTFail(@"Something went wrong - when you started this challenge there was a UIWebView named self.webView.  We suggest re-downloading this project if that UIWebView is gone.");
    }
}

- (void)testWebVCContentOffset
{
    [_aboutVC logoTapped:nil];
    _webVC = (CSWebVC *)_aboutVCNav.topViewController;
    [_aboutVCNav setViewControllers:@[_webVC] animated:NO];
    [_aboutVCNav.view layoutIfNeeded];
    [_webVC.view layoutIfNeeded];
    
    CSPropertyDefinition *property = [self webviewProperty];
    
    if(property) {
        UIWebView *webviewProperty = [_webVC valueForKey:@"webView"];
        XCTAssert(webviewProperty.scrollView.contentOffset.y == -64, @"Did not set contentOffset to have a y offset of -64 pts");
    } else {
        XCTFail(@"Something went wrong - when you started this challenge there was a UIWebView named self.webView.  We suggest re-downloading this project if that UIWebView is gone.");
    }
}


- (CSPropertyDefinition *)contentSubviewProperty
{
    CSPropertyDefinition *property;
    
    property = [CSPropertyDefinition firstPropertyWithType:@"UIScrollView" forClass:[CSAboutVC class]];
    
    return property;
}


- (CSPropertyDefinition *)webviewProperty
{
    CSPropertyDefinition *property;
    
    property = [CSPropertyDefinition firstPropertyWithType:@"UIWebView" forClass:[CSWebVC class]];
    
    return property;
}

@end
