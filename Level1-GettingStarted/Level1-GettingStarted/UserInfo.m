
#import "UserInfo.h"

#define MACRO_NAME(f) #f
#define MACRO_VALUE(f)  MACRO_NAME(f)

@implementation UserInfo

+ (void)getUserInfo:(void (^)(NSDictionary *))completion;
{
    NSString *userToken = [NSString stringWithFormat:@"%s", MACRO_VALUE(USER_INFO_URL)];
    
    NSURL *userURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ios7-beta.codeschool.com/users/%@", userToken]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:userURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        completion(dict);
    }];
    
    [task resume];
}
@end
