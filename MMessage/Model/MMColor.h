//
//  MMColor.h
//  MMessage
//
//  Created by JiangNan on 2022/7/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 微信标志性的绿色，采集自微信的tabBar
#define WECHAT_GREEN [UIColor colorWithRed:25.0/255 green:184.0/255 blue:78.0/255 alpha:1]

// 微信四个页面的背景颜色，采集自微信的页面的背景色
#define WECHAT_BACKGROUND_GREY [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1]

// 微信tabbar的背景颜色，采集自微信tabbar的背景色
#define WECHAT_TABBAR_BACKGROUND_GREY [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1]

/// 用于设置app的各种颜色
@interface MMColor : NSObject

@end

NS_ASSUME_NONNULL_END
