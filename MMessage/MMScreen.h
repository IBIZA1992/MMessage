//
//  MMScreen.h
//  MMessage
//
//  Created by JiangNan on 2022/7/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

// 顶部高度
#define STATUSBARHEIGHT statusBarHeight()  // 还要注意statusBar下面的navigationBar的高度:44
#define NAVIGATIONBARHEIGHT (44)
#define STATUS_NAVIGATION_BAR_HEIGHT (STATUSBARHEIGHT + NAVIGATIONBARHEIGHT)  // 上面的整体高度

// 底部高度
#define SAFEDISTANCEBOTTOM safeDistanceBottom()
#define TABBARHEIGHT (49)
#define SAFEDISTANCE_TABBAR_HEIGHT (SAFEDISTANCEBOTTOM + TABBARHEIGHT)  // 下面的整体高度

#define UI(x) UIAdapter(x)
#define UIRect(x, y, width, height) UIRectAdapter(x, y, width, height)

/// 根据iPhone 13/iPhone 13 Pro/iPhone 12/iPhone 12 Pro设置
/// @param x 在iPhone 13/iPhone 13 Pro/iPhone 12/iPhone 12 Pro机型上布局的数值
static inline NSInteger UIAdapter (float x) {
    CGFloat scale = 390 / SCREEN_WIDTH;  // iPhone 13/iPhone 13 Pro/iPhone 12/iPhone 12 Pro 屏幕宽度
    return (NSInteger)x / scale;
}

static inline CGRect UIRectAdapter(x, y, width, height) {
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}

static inline NSInteger statusBarHeight() {
    NSSet *set = [[UIApplication sharedApplication] connectedScenes];
    UIWindowScene *windowScene = [set anyObject];
    UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
    return statusBarManager.statusBarFrame.size.height;
}

// 底部安全区高度
static inline NSInteger safeDistanceBottom() {
    NSSet *set = [[UIApplication sharedApplication] connectedScenes];
    UIWindowScene *windowScene = [set anyObject];
    UIWindow *window = windowScene.windows.firstObject;
    return window.safeAreaInsets.bottom;
}

/// 分辨率及状态栏适配，使用UI根据iPhone 13/iPhone 13 Pro/iPhone 12/iPhone 12 Pro设置
@interface MMScreen : NSObject

@end

NS_ASSUME_NONNULL_END
