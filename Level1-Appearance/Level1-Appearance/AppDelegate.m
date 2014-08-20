#import "AppDelegate.h"

#import "Photo.h"
#import "Photos.h"

#import "CSPhotoListVC.h"
#import "CSPhotoDetailVC.h"
#import "CSTakePhotoVC.h"
#import "CSAboutVC.h"

#define kWipeEverythingOnNextLoad 0

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if(kWipeEverythingOnNextLoad) {
        Photos *photos = nil;
        [Photos savePhotosToArchive:photos];
    }
    
    if([Photos getPhotosFromArchive] == nil) {
        [self setupInitialImageData];
    } else {
        NSLog(@"initial images already loaded");
    }
    
    // We removed all of the appearance-proxy settings so you can set them below with the new tintColor property
    
//    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.10 green:0.31 blue:0.5 alpha:1.0]];
//    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.10 green:0.31 blue:0.5 alpha:1.0]];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]} forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]} forState:UIControlStateSelected];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]}];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    CSPhotoListVC *photoListVC = [[CSPhotoListVC alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoListVC];
    
    CSTakePhotoVC *takePhotoVC = [[CSTakePhotoVC alloc] init];
    
    CSAboutVC *aboutVC = [[CSAboutVC alloc] init];
    
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    
    tabBarController.viewControllers = @[navController, takePhotoVC, aboutNav];
    
    self.window.rootViewController = tabBarController;

    // TODO: set the window tintColor to 0.9, 0.8, 0.5, 1.0
    
    self.window.tintColor = [UIColor colorWithRed:0.9 green:0.8 blue:0.5 alpha:1.0];
    
    // TODO: set the nav bar barStyles to black
    navController.navigationBar.barStyle = UIBarStyleBlack;

    // TODO: set the tab bar barStyle to black
    tabBarController.tabBar.barStyle = UIBarStyleBlack;
    aboutNav.navigationBar.barStyle = UIBarStyleBlack;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupInitialImageData
{
    NSArray *photosFromPlist;
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"initialData" ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:plist]) {
        photosFromPlist = [[NSArray alloc] initWithContentsOfFile:plist];
        
        NSMutableArray *photosArray = [[NSMutableArray alloc] initWithCapacity:photosFromPlist.count];
        [photosFromPlist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Photo *photo = [[Photo alloc] init];
            photo.photoId = [photosFromPlist[idx][@"id"] integerValue];
            photo.name = photosFromPlist[idx][@"name"];
            photo.filename = photosFromPlist[idx][@"filename"];
            photo.notes = photosFromPlist[idx][@"notes"];
            
            [photosArray addObject:photo];
        }];
        
        Photos *photos = [[Photos alloc] init];
        photos.allPhotos = [[NSArray alloc] initWithArray:photosArray];
        [Photos savePhotosToArchive:photos];
    } else {
        NSLog(@"file doesn't exist");
    }
}

@end
