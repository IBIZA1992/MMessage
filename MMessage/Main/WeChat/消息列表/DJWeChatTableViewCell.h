//
//  DJWeChatTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/4.
//

#import <UIKit/UIKit.h>
#import "DJListItem.h"
#import "JMessage/JMessage.h"
#import "SDWebImage.h"
#import "DJSingleton.h"
#import "MMScreen.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJWeChatTableViewCell : UITableViewCell

@property(nonatomic, strong)DJSingleton *single;

@property(nonatomic, strong)UIImageView *profile_image_url;//头像
@property(nonatomic, strong)UILabel *name;//名称
@property(nonatomic, strong)UILabel *text;//最后一条消息



- (void)Loadwechattableviewcell:(NSString *)username;

@end

NS_ASSUME_NONNULL_END
