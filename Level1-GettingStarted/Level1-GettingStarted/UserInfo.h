//
//  UserInfo.h
//  Level1-GettingStarted
//
//  Created by Eric Allam on 9/19/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (void)getUserInfo:(void (^)(NSDictionary *))completion;
@end
