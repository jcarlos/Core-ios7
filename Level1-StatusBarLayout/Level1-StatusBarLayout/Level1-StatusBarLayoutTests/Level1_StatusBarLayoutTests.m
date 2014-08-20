#import <XCTest/XCTest.h>
#import "CSRecordingTestCase.h"
#import "CSPropertyDefinition.h"
#import "AppDelegate.h"
#import "CSTakePhotoVC.h"
#import "CSAboutVC.h"

@interface Level1_StatusBarLayoutTests : CSRecordingTestCase {
    AppDelegate *_appDel;
    CSAboutVC *_aboutVC;
}

@end

@implementation Level1_StatusBarLayoutTests

- (void)setUp
{
    [super setUp];
    
    _appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [(UITabBarController *)_appDel.window.rootViewController setSelectedIndex:2];
    _aboutVC = [[(UITabBarController *)_appDel.window.rootViewController viewControllers] objectAtIndex:2];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testContentSubviewPropertyExists
{
    CSPropertyDefinition *property = [self contentSubviewProperty];
    
    XCTAssert(property, @"Did not define a contentSubview property on CSAboutVC that is a UIView");
    XCTAssert([property.name isEqualToString:@"contentSubview"], @"Did not name your content subview property contentSubview");
}

- (void)testContentSubviewContainsSubviews
{
    CSPropertyDefinition *property = [self contentSubviewProperty];
    
    if(property) {
        UIView *contentSubviewProperty = [_aboutVC valueForKey:@"contentSubview"];
        XCTAssert(contentSubviewProperty.subviews.count == 4, @"Did not add the headerLabel, authorLabel, csLogoImageView, and descriptionTextView as subviews of contentSubview");
    } else {
        XCTFail(@"You won't be able to attempt this challenge until you create the contentSubview property");
    }
}

- (void)testContentSubviewFrameYEqualsTopLayoutGuideLength
{
    CSPropertyDefinition *property = [self contentSubviewProperty];
    
    if(property) {
        UIView *contentSubviewProperty = [_aboutVC valueForKey:@"contentSubview"];
        [_aboutVC.view layoutIfNeeded];
        
        XCTAssert(contentSubviewProperty.frame.origin.y == 20, @"Did not set the frame.origin.y of the contentSubview equal to the topLayoutGuide.length");
        XCTAssert(contentSubviewProperty.frame.size.height == _aboutVC.view.frame.size.height - _aboutVC.topLayoutGuide.length, @"Did not set the frame.size.height of the contentSubview to the size of the view.frame.size.height minus the self.topLayoutGuide.length");
    } else {
        XCTFail(@"You won't be able to attempt this challenge until you create the contentSubview property");
    }
}

- (CSPropertyDefinition *)contentSubviewProperty
{
    CSPropertyDefinition *property;
    
    property = [CSPropertyDefinition firstPropertyWithType:@"UIView" forClass:[CSAboutVC class]];
    
    return property;
}

@end
