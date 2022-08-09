//
//  DJChatTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import <UIKit/UIKit.h>
#import "DJListItem.h"
#import "JMessage/JMessage.h"
#import "SDWebImage.h"
#import "DJSingleton.h"
#import "MMScreen.h"
#import "AVFoundation/AVFoundation.h"


NS_ASSUME_NONNULL_BEGIN

@interface DJChatTableViewCell : UITableViewCell
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)UIImageView *background;
@property(nonatomic, strong)UIImageView *profile_image_url;//头像
@property(nonatomic, strong)UILabel *text;
@property(nonatomic, strong)UIImageView *picture;
@property(nonatomic, strong)UIButton *btnvoice;
@property(nonatomic, strong)UIImageView *videoimage;
@property(nonatomic, strong)UILabel *videolabel;
@property(nonatomic, strong)JMSGVoiceContent *voicecontent;

@property(nonatomic )CGFloat cellheight;

- (void)LoadChatTableViewCell:(JMSGMessage *)message;

@end

NS_ASSUME_NONNULL_END
