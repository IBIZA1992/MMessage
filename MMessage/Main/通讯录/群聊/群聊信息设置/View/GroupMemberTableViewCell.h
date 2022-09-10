//
//  GroupMemberTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/9/1.
//

#import <UIKit/UIKit.h>
#import "JMessage/JMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupMemberTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *image;
@property(nonatomic, strong) UILabel *name;

- (void)loadGroupMemberCell:(JMSGUser *)User;

@end

NS_ASSUME_NONNULL_END
