//
//  DJChatTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import "DJChatTableViewCell.h"

@implementation DJChatTableViewCell


///加载cell的数据和位置
- (void)LoadChatTableViewCell:(JMSGMessage *)message {
    _single = [DJSingleton sharedManager];
    [self SetData:message];
    if(_single.messageType == 1){
        [self SetSingleFrame:message];
    }
    if(_single.messageType == 2){
        [self SetGroupFrame:message];
    }
    
    /**播放语音*/
    [_btnvoice addTarget:self action:@selector(playvoice) forControlEvents:UIControlEventTouchUpInside];
}

///播放语音通知，传回控制器
- (void)playvoice {
    NSDictionary *dic = [NSDictionary dictionaryWithObject:_voicecontent forKey:@"voice"];
    NSNotification *note = [NSNotification notificationWithName:@"playvoice" object:self userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:note];
}


///设置数据
- (void)SetData:(JMSGMessage *)message {
    _single = [DJSingleton sharedManager];
    //设置头像
    if([[NSUserDefaults standardUserDefaults] objectForKey:message.fromUser.username]){/**如果本地有图片*/
        NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:message.fromUser.username];
        _profile_image_url.image = [UIImage imageWithData:imageData];
    }
    else{/**如果本地没有图片，网络获取并存入本地*/
        if(message.fromUser.avatar){/**如果用户有头像*/
            NSArray *array=[[NSArray alloc] initWithObjects:message.fromUser.username,nil]; /**获得对方账号的userdata存入array中*/
            [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) { /**通过对方的userdata获取对方的信息*/
                JMSGUser *user = resultObject[0]; /**返回对象即为对方的user*/
                [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) { /**从网络请求头像数据*/
                    self.profile_image_url.image = [UIImage imageWithData:data]; /**更新UI数据*/
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{/**在子线程中将头像数据存入本地磁盘*/
                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:message.fromUser.username];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    });
                }];
            }];
        }
    }
 
    //设置群成员的昵称
    _groupusername.text = message.fromUser.username;

    //聊天文本数据
    JMSGAbstractContent *content = message.content;
    if(message.contentType== kJMSGContentTypeText) {    /**如果该信息为文字信息*/
        JMSGTextContent *textcontent = (JMSGTextContent *)content;
        _text.text = textcontent.text;
    }
    

    //聊天语音数据
    JMSGAbstractContent *contentvoice = message.content;
    if(message.contentType == kJMSGContentTypeVoice) {    /**如果该信息为语音信息*/
        _voicecontent = (JMSGVoiceContent *)contentvoice;
        
        [_voicecontent voiceData:^(NSData *data, NSString *objectId, NSError *error) {
            if(message.fromName != nil){/**如果为对方所发送的消息*/
                [self->_btnvoice setImage:[UIImage imageNamed:@"leftchat"] forState:UIControlStateNormal];
                self->_videoimage.image = [UIImage imageNamed:@"video2"];
                /**设置语音时长*/
                NSError *error1 = nil;
                AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:data error:&error1];
                NSString *timeString = [NSString stringWithFormat:@"%i", (int)player.duration];
                self->_videolabel.text = [timeString stringByAppendingString:@"\""];
            }
            else{/**如果是自己所发送的信息*/
                self->_btnvoice.frame = CGRectMake(230, 15, 80, 40);
                [self->_btnvoice setImage:[UIImage imageNamed:@"rightchat"] forState:UIControlStateNormal];
                self->_videoimage.image = [UIImage imageNamed:@"video2"];
                self->_videoimage.frame = CGRectMake(290, 22, 10, 10);
                /**设置语音时长*/
                NSError *error1 = nil;
                AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:data error:&error1];
                NSString *timeString = [NSString stringWithFormat:@"%i", (int)player.duration];
                self->_videolabel.text = [timeString stringByAppendingString:@"\""];

            }
        }];
    }
  
    //聊天图片数据
    JMSGAbstractContent *contentimage = message.content;
    if(message.contentType == kJMSGContentTypeImage){/**如果该信息为图片类型*/
       JMSGImageContent *imagecontent = (JMSGImageContent *)contentimage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:[message.timestamp stringValue]]){/**本地已经储存*/
            _picture.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:[message.timestamp stringValue]]];
        }
        else{/**本地为储存*/
            [imagecontent thumbImageData:^(NSData *data, NSString *objectId, NSError *error) {
                self.picture.image = [UIImage imageWithData:data];
                /**子线程中将图片存入本地*/
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[message.timestamp stringValue]];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                });
            }];
        }
    }
}



///设置单人聊天Frame
- (void)SetSingleFrame:(JMSGMessage *)message {
    
    //设置头像
    if(message.fromName != nil) {
        [_profile_image_url setFrame:CGRectMake(10, 10, 50, 50)];
    }
    else{
        [_profile_image_url setFrame:CGRectMake(SCREEN_WIDTH-60, 10, 50, 50)];
    }

    
    
    //message为文字类型
    if(message.contentType == kJMSGContentTypeText){
        /**对方所发送消息*/
        if(message.fromName != nil) {
            _text.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
            _text.numberOfLines = 0;/**多行显示文字*/
            _text.font=[UIFont systemFontOfSize:16.0];
            _text.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize size = [_text sizeThatFits:CGSizeMake(280, MAXFLOAT)];/**假设有多行，自适应高度*/
            if(size.height < 20){/**如果只有一行，高度不变自适应宽度*/
                CGSize size = [_text sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
                [_text setFrame:CGRectMake(80, 20, size.width, 20)];
            }
            else{ /**如果有多行，直接返回高度*/
                [_text setFrame:CGRectMake(80, 20, 280, size.height)];
            }
            _background.frame = CGRectMake(_text.frame.origin.x-10, _text.frame.origin.y-10, _text.frame.size.width+20, _text.frame.size.height+20);
            _background.image = [UIImage imageNamed:@"leftchat"];
        }
        
        /**自己所发送消息*/
        if(message.fromName == nil){
            _text.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
            _text.numberOfLines = 0;
            _text.font=[UIFont systemFontOfSize:16.0];
            _text.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize size = [_text sizeThatFits:CGSizeMake(280, MAXFLOAT)];/**根据文字的长度返回一个最佳高度*/
            if(size.height < 20){/**假如只有一行自适应宽度*/
                CGSize size = [_text sizeThatFits:CGSizeMake(MAXFLOAT, 20)];/**根据文字的长度返回一个最佳宽度*/
                [_text setFrame:CGRectMake(310-size.width, 20, size.width, 20)];
            }
            else{
                [_text setFrame:CGRectMake(30, 20, 280, size.height)];
            }
            _background.frame = CGRectMake(_text.frame.origin.x-10, _text.frame.origin.y-10, _text.frame.size.width+20, _text.frame.size.height+20);
            _background.image = [UIImage imageNamed:@"rightchat"];
        }
        /**返回cell高度*/
        if(_text.frame.size.height > 30){
            _cellheight = _text.frame.size.height+40;
        }
        else{
            _cellheight = 70;
        }
    }
    
  
   //如果message为图片信息
    if(message.contentType == kJMSGContentTypeImage) {
        if(message.fromName == nil){/**如果为我自己所发送的消息*/
            self->_picture.frame = CGRectMake(110, 0, 200, 200);
        }
        else{
            self->_picture.frame = CGRectMake(80, 0, 200, 200);
        }
        /**返回cell的高度*/
        _cellheight = 200;
    }
    
    //如果message为语音类型
    if(message.contentType == kJMSGContentTypeVoice) {
        if(message.fromName == nil){/**如果为我自己所发送的消息*/
            _btnvoice.frame = CGRectMake(230, 15, 80, 40);
            _videoimage.frame = CGRectMake(290, 22, 10, 10);
            [_videolabel setFrame:CGRectMake(180, 22, 100, 20)];
            _videolabel.textAlignment = NSTextAlignmentRight; /**设置字体的显示位置居右*/
        }
        else{
            _btnvoice.frame = CGRectMake(80, 15, 80, 40);
            _videoimage.frame = CGRectMake(90, 22, 10, 10);
            [_videolabel setFrame:CGRectMake(110, 22, 100, 20)];
            _videolabel.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
        }
        /**返回cell的高度*/
        _cellheight = 70;
    }
}





///设置群聊Frame
- (void)SetGroupFrame:(JMSGMessage *)message{
    
    //设置头像
    if(message.fromName != nil) {
        [_profile_image_url setFrame:CGRectMake(10, 10, 50, 50)];
    }
    else{
        [_profile_image_url setFrame:CGRectMake(SCREEN_WIDTH-60, 10, 50, 50)];
    }

    //设置昵称
    if(message.fromName == nil){
        _groupusername.textAlignment = NSTextAlignmentRight; /**设置字体的显示位置居右*/
        _groupusername.font=[UIFont systemFontOfSize:11.0];
        _groupusername.lineBreakMode = NSLineBreakByWordWrapping;
        [_groupusername setFrame:CGRectMake(260, 5, 50, 10)];
    }
    else{
        _groupusername.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
        _groupusername.font=[UIFont systemFontOfSize:11.0];
        _groupusername.lineBreakMode = NSLineBreakByWordWrapping;
        [_groupusername setFrame:CGRectMake(80, 5, 50, 10)];
    }
    
    
    //message为文字类型
    if(message.contentType == kJMSGContentTypeText){
        /**对方所发送消息*/
        if(message.fromName != nil) {
            _text.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
            _text.numberOfLines = 0;/**多行显示文字*/
            _text.font=[UIFont systemFontOfSize:16.0];
            _text.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize size = [_text sizeThatFits:CGSizeMake(280, MAXFLOAT)];/**假设有多行，自适应高度*/
            if(size.height < 20){/**如果只有一行，高度不变自适应宽度*/
                CGSize size = [_text sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
                [_text setFrame:CGRectMake(80, 30, size.width, 20)];
            }
            else{ /**如果有多行，直接返回高度*/
                [_text setFrame:CGRectMake(80, 30, 280, size.height)];
            }
            _background.frame = CGRectMake(_text.frame.origin.x-10, _text.frame.origin.y-10, _text.frame.size.width+20, _text.frame.size.height+20);
            _background.image = [UIImage imageNamed:@"leftchat"];
        }
        
        /**自己所发送消息*/
        if(message.fromName == nil){
            _text.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
            _text.numberOfLines = 0;
            _text.font=[UIFont systemFontOfSize:16.0];
            _text.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize size = [_text sizeThatFits:CGSizeMake(280, MAXFLOAT)];/**根据文字的长度返回一个最佳高度*/
            if(size.height < 20){/**假如只有一行自适应宽度*/
                CGSize size = [_text sizeThatFits:CGSizeMake(MAXFLOAT, 20)];/**根据文字的长度返回一个最佳宽度*/
                [_text setFrame:CGRectMake(310-size.width, 30, size.width, 20)];
            }
            else{
                [_text setFrame:CGRectMake(30, 30, 280, size.height)];
            }
            _background.frame = CGRectMake(_text.frame.origin.x-10, _text.frame.origin.y-10, _text.frame.size.width+20, _text.frame.size.height+20);
            _background.image = [UIImage imageNamed:@"rightchat"];
        }
        /**返回cell高度*/
        if(_text.frame.size.height > 30){
            _cellheight = _text.frame.size.height+40;
        }
        else{
            _cellheight = 70;
        }
    }
    
  
   //如果message为图片信息
    if(message.contentType == kJMSGContentTypeImage){
        if(message.fromName == nil){/**如果为我自己所发送的消息*/
            self->_picture.frame = CGRectMake(110, 15, 200, 200);
        }
        else{
            self->_picture.frame = CGRectMake(80, 15, 200, 200);
        }
        /**返回cell的高度*/
        _cellheight = 215;
    }
    
    //如果message为语音类型
    if(message.contentType == kJMSGContentTypeVoice){
        if(message.fromName == nil){/**如果为我自己所发送的消息*/
            _btnvoice.frame = CGRectMake(230, 25, 80, 40);
            _videoimage.frame = CGRectMake(290, 32, 10, 10);
            [_videolabel setFrame:CGRectMake(180, 32, 100, 20)];
            _videolabel.textAlignment = NSTextAlignmentRight; /**设置字体的显示位置居右*/
        }
        else{
            _btnvoice.frame = CGRectMake(80, 25, 80, 40);
            _videoimage.frame = CGRectMake(90, 32, 10, 10);
            [_videolabel setFrame:CGRectMake(110, 32, 100, 20)];
            _videolabel.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
        }
        /**返回cell的高度*/
        _cellheight = 70;
    }
    
}


///重写初始化方法 创造控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        //用户头像
        [self.contentView addSubview:({
            _profile_image_url=[[UIImageView alloc] initWithFrame:CGRectZero];
            _profile_image_url.contentMode=UIViewContentModeScaleAspectFit;
            _profile_image_url;
        })];
        //聊天框
        [self.contentView addSubview:({
            _background = [[UIImageView alloc] init];
            _background;
        })];
        //text
        [self.contentView addSubview:({
            _text = [[UILabel alloc] init];
            _text;
        })];
        //发图片
        [self.contentView addSubview:({
            _picture = [[UIImageView alloc] initWithFrame:CGRectZero];
            _picture.contentMode=UIViewContentModeScaleAspectFit;
            _picture;
        })];
        //语音
        [self.contentView addSubview:({
            _btnvoice = [UIButton buttonWithType:UIButtonTypeCustom];
            _btnvoice;
        })];
        //语音图标
        [self.contentView addSubview:({
            _videoimage = [[UIImageView alloc] init];
            _videoimage;
        })];
        //语音时间
        [self.contentView addSubview:({
            _videolabel = [[UILabel alloc] init];
            _videolabel;
        })];
        //群成员昵称
        [self.contentView addSubview:({
            _groupusername = [[UILabel alloc] init];
            _groupusername;
        })];
    }
    return self;
}


@end
