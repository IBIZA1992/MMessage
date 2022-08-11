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
///单例对象
@property(nonatomic, strong)DJSingleton *single;
///聊天背景框
@property(nonatomic, strong)UIImageView *background;
///头像
@property(nonatomic, strong)UIImageView *profile_image_url;
///文本数据
@property(nonatomic, strong)UILabel *text;
///图片数据
@property(nonatomic, strong)UIImageView *picture;
///语音播放
@property(nonatomic, strong)UIButton *btnvoice;
///语音图标
@property(nonatomic, strong)UIImageView *videoimage;
///语音长度
@property(nonatomic, strong)UILabel *videolabel;
///语音数据内容，暴露到控制器的player中播放
@property(nonatomic, strong)JMSGVoiceContent *voicecontent;
///cell的高度
@property(nonatomic )CGFloat cellheight;
///群成员昵称
@property(nonatomic, strong)UILabel *groupusername;


///加载cell控件的数据和位置
- (void)LoadChatTableViewCell:(JMSGMessage *)message;

@end

NS_ASSUME_NONNULL_END
