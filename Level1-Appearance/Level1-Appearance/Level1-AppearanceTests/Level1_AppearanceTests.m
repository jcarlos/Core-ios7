#import <XCTest/XCTest.h>
#import "CSRecordingTestCase.h"
#import "CSPropertyDefinition.h"
#import "AppDelegate.h"
#import "CSPhotoListVC.h"
#import "CSPhotoDetailVC.h"
#import "CSTakePhotoVC.h"
#import "CSAboutVC.h"
#import "CSWebVC.h"
#import "Photo.h"

@interface Level1_AppearanceTests : CSRecordingTestCase {
    AppDelegate *_appDel;
    CSAboutVC *_aboutVC;
    UINavigationController *_aboutVCNav;
    CSWebVC *_webVC;
}

@end

@implementation Level1_AppearanceTests

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

- (void)testTintColor
{
    BOOL colorsMatch = CGColorEqualToColor(_appDel.window.tintColor.CGColor, [UIColor colorWithRed:0.9 green:0.8 blue:0.5 alpha:1.0].CGColor);
    XCTAssert(colorsMatch, @"Did not set tintColor to 0.9, 0.8, 0.5, 1.0");
}

- (void)testTintColorOverride
{
    UINavigationController *photoNav = (UINavigationController *)[[(UITabBarController *)_appDel.window.rootViewController viewControllers] objectAtIndex:0];
    CSPhotoListVC *photoListVC = photoNav.viewControllers[0];
    [photoListVC.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    CSPhotoDetailVC *photoDetailVC = [[CSPhotoDetailVC alloc] init];
    Photo *photo = photoListVC.dataSource[2];
    photoDetailVC.photo = photo;
    [photoNav pushViewController:photoDetailVC animated:NO];
    CSPhotoDetailVC *p2 = (CSPhotoDetailVC *)photoNav.topViewController;
    BOOL colorsMatch = CGColorEqualToColor(p2.view.tintColor.CGColor, [UIColor redColor].CGColor);
    XCTAssert(colorsMatch, @"Did not override the tintColor in CSPhotoDetailVC's viewDidLoad method and set it to [UIColor redColor]");
}

- (void)testTabBarStyle
{
    UITabBarController *tabBarController = (UITabBarController *)_appDel.window.rootViewController;
    XCTAssert(tabBarController.tabBar.barStyle == UIBarStyleBlack, @"Did not set the UITabBarController's tab bar barStyle to UIBarStyleBlack");
}

- (void)testNavBarStyle
{
    __block BOOL photoListBarStyleIsBlack = NO;
    __block BOOL aboutBarStyleIsBlack = NO;
    [[(UITabBarController *)_appDel.window.rootViewController viewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)obj topViewController] isKindOfClass:[CSPhotoListVC class]]) {
            if([[(UINavigationController *)obj navigationBar] barStyle] == UIBarStyleBlack) {
                photoListBarStyleIsBlack = YES;
            }
        } else if([obj isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)obj topViewController] isKindOfClass:[CSAboutVC class]]) {
            if([[(UINavigationController *)obj navigationBar] barStyle] == UIBarStyleBlack) {
                aboutBarStyleIsBlack = YES;
            }
        }
    }];
    XCTAssert(photoListBarStyleIsBlack, @"Did not set barStyle to black for the UINavigationBar that contains CSPhotoListVC");
    XCTAssert(aboutBarStyleIsBlack, @"Did not set barStyle to black for the UINavigationBar that contains CSAboutVC");
}

- (void)testProgrammaticallyAccessAssetCatalog
{
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"Assets.car"
                      ofType:nil];

    NSData *data = [NSData dataWithContentsOfFile:path];
        
    // 75320 without images, over 800000 with images
    XCTAssert(data.length > 800000, @"Did not add all images to the Images.xcassets Asset Catalog");
    XCTAssert(data.length < 850000, @"It looks like you added too many images to the Images.xcassets Asset Catalog - make sure you're only adding one Image Set for each of the images in the PhotoNotes app");
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
