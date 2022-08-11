//
//  DJBasicTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"
#import "DJListItem.h"
#import "DJSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJBasicTableViewCell : UITableViewCell

@property(nonatomic,strong,readwrite)UIImageView *profile_image_url;//用户头像
@property(nonatomic,strong,readwrite)UILabel *user_name;//用户昵称
@property(nonatomic,strong)DJSingleton *single;




- (void)LoadBasicTableViewCellWithItem:(DJListItem *)item;

@end

NS_ASSUME_NONNULL_END
