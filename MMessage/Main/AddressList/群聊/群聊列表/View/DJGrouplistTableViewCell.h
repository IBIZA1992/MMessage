//
//  DJGrouplistTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import <UIKit/UIKit.h>
#import "DJSingleton.h"
#import "JMessage/JMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJGrouplistTableViewCell : UITableViewCell

@property(nonatomic,strong,readwrite)UIImageView *profile_image_url;//群头像
@property(nonatomic,strong,readwrite)UILabel *group_name;//群昵称
@property(nonatomic,strong)DJSingleton *single;



- (void)LoadGroupListTableViewCellWithItem:(NSNumber *)groupID;


@end

NS_ASSUME_NONNULL_END
