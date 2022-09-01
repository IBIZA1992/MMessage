//
//  MMTabBarController.m
//  MMessage
//
//  Created by JiangNan on 2022/7/28.
//

#import "MMColor.h"
#import "MMTabBarController.h"
#import "MMWeChatViewController.h"
#import "DJAddressViewController.h"
#import "MMDiscoverViewController.h"
#import "MMMineViewController.h"
#import "DJSingleton.h"


@interface MMTabBarController ()

@end

@implementation MMTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        _single = [DJSingleton sharedManager];
        JMSGUser *user = [JMSGUser myInfo];
        NSArray *array=[[NSArray alloc] initWithObjects:user.username,nil];

        dispatch_queue_global_t downloadQueue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
            [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
                JMSGUser *user = resultObject[0];
                [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                        UIImage *image = [UIImage imageWithData:data];
                        NSString *path_document = NSHomeDirectory();
                        NSString *imagepath = [path_document stringByAppendingString:user.username];
                        [self->_single.imagePathArray addObject:imagepath];
                    dispatch_async(downloadQueue, ^{
                        [UIImagePNGRepresentation(image) writeToFile:imagepath atomically:YES];
                    });
                }];
            }];

        
        
        
        
        // 设置tabbar
        UITabBarAppearance * tabbarAppearance = [UITabBarAppearance new];
        tabbarAppearance.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;
        tabbarAppearance.backgroundEffect = nil;
        self.tabBar.scrollEdgeAppearance = tabbarAppearance;
        self.tabBar.standardAppearance = tabbarAppearance;
        self.tabBar.tintColor = WECHAT_GREEN;
        
        // 设置四个页面
        MMWeChatViewController *weChatViewController = [[MMWeChatViewController alloc] init];
        DJAddressViewController *addressListViewController = [[DJAddressViewController alloc] init];
        MMDiscoverViewController *discoverViewController = [[MMDiscoverViewController alloc] init];
        MMMineViewController *mineViewController = [[MMMineViewController alloc] init];
        [self setViewControllers:@[weChatViewController, addressListViewController, discoverViewController, mineViewController]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
