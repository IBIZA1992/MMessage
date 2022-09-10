//
//  MMMineTableViewCell.h
//  MMessage
//
//  Created by JiangNan on 2022/8/1.
//

#import <UIKit/UIKit.h>
#import "MMMineTableViewInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMMineTableViewCell : UITableViewCell

/// 用cell信息布局
/// @param infoItem 信息
- (void)layoutWithInfoItem:(MMMineTableViewInfoItem *)infoItem;

/// 复用回收重定义cell
/// @param infoItem 信息
- (void)reLayoutWithInfoItem:(MMMineTableViewInfoItem *)infoItem;

@end

NS_ASSUME_NONNULL_END
