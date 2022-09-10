//
//  DJCreateGroupTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"
#import "DJListItem.h"
#import "DJSingleton.h"
NS_ASSUME_NONNULL_BEGIN

@interface DJCreateGroupTableViewCell : UITableViewCell

@property(nonatomic,strong,readwrite) UIImageView *profile_image_url;//用户头像
@property(nonatomic,strong,readwrite) UILabel *user_name;//用户昵称
@property(nonatomic, strong, readwrite) UISwitch *Switch;//选择好友
@property(nonatomic,strong) DJSingleton *single;
@property(nonatomic, strong) DJListItem *item;




- (void)LoadCreateGroupTableViewCellWithItem:(DJListItem *)item;

@end

NS_ASSUME_NONNULL_END
