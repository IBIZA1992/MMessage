//
//  MMTabBarController.h
//  MMessage
//
//  Created by JiangNan on 2022/7/28.
//

#import <UIKit/UIKit.h>
#import "DJSingleton.h"
#import "JMessage/JMessage.h"
NS_ASSUME_NONNULL_BEGIN

@interface MMTabBarController : UITabBarController
@property(nonatomic, strong)DJSingleton *single;

@end

NS_ASSUME_NONNULL_END
