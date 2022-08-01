//
//  MMChangeDetailViewController.h
//  MMessage
//
//  Created by JiangNan on 2022/8/1.
//

#import <UIKit/UIKit.h>
#import "MMMineTableViewInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMChangeDetailViewController : UIViewController

/// 初始化载入数据
/// @param infoItem 数据
- (instancetype)initWithInfoItem:(MMMineTableViewInfoItem *)infoItem;

@end

NS_ASSUME_NONNULL_END
