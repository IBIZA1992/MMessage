//
//  DJChatTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import <UIKit/UIKit.h>
#import "DJListItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJChatTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *profile_image_url;//对方头像
@property(nonatomic, strong)UIImageView *My_profile_image_url;//我的头像
@property(nonatomic, strong)UILabel *text;


- (void)LoadChatTableViewCell:(DJListItem *)item;

@end

NS_ASSUME_NONNULL_END
