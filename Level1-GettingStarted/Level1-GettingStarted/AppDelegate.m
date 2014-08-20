#import "AppDelegate.h"
#import "UserViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UserViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end