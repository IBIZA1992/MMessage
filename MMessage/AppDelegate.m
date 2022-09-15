//
//  AppDelegate.m
//  MMessage
//
//  Created by JiangNan on 2022/7/26.
//

#import "AppDelegate.h"
#import <JMessage/JMessage.h>
#import "MMScreen.h"
#import "SVProgressHUD/SVProgressHUD.h"

@interface AppDelegate ()<JMessageDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    [JMessage setupJMessage:launchOptions appKey:@"a22033c28155ecb6e5dab352" channel:nil apsForProduction:NO category:nil messageRoaming:NO];
    
    [JMessage addDelegate:self withConversation:nil];
    
    // 初始化弹窗
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];  // 设置弹窗背景不响应用户点击
    [SVProgressHUD setMinimumSize:CGSizeMake(SCREEN_WIDTH * 2 / 5, SCREEN_WIDTH * 2 / 5)];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:UI(17)]];
    [SVProgressHUD setRingRadius:UI(21)];
    [SVProgressHUD setRingThickness:UI(4)];
    [SVProgressHUD setImageViewSize:CGSizeMake(UI(40), UI(40))];
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册token
    [JMessage registerDeviceToken:deviceToken];
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
