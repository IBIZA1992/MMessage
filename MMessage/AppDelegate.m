//
//  AppDelegate.m
//  MMessage
//
//  Created by JiangNan on 2022/7/26.
//

#import "AppDelegate.h"
#import <JMessage/JMessage.h>

@interface AppDelegate ()<JMessageDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Required - 启动 JMessage SDK
//    [JMessage setupJMessage:launchOptions appKey:@"a22033c28155ecb6e5dab352" channel:nil apsForProduction:NO category:nil];
    [JMessage setupJMessage:launchOptions appKey:@"a22033c28155ecb6e5dab352" channel:nil apsForProduction:NO category:nil messageRoaming:NO];
    
    [JMessage addDelegate:self withConversation:nil];
    
//    [JMSGUser loginWithUsername:@"IBIZA" password:@"123456" completionHandler:^(id resultObject, NSError *error) {
//        NSLog(@"");
//    }];

    
    return YES;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
