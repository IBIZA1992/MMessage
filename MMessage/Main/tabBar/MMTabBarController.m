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

@interface MMTabBarController ()

@end

@implementation MMTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
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
