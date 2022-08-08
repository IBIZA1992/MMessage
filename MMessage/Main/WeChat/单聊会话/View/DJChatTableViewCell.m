//
//  DJChatTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import "DJChatTableViewCell.h"

@implementation DJChatTableViewCell


//重写初始化方法 创造控件
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
            _text=[[UILabel alloc] init];
            _text;
        })];
        //发图片
        [self.contentView addSubview:({
            _picture=[[UIImageView alloc] initWithFrame:CGRectZero];
            _picture.contentMode=UIViewContentModeScaleAspectFit;
            _picture;
        })];
    }
    return self;
}

- (void)LoadChatTableViewCell:(JMSGMessage *)message{
    [self SetData:message];
    [self SetFrame:message];
}


- (void)SetData:(JMSGMessage *)message{
    _single = [DJSingleton sharedManager];
    
    if(message.fromName == nil){/**如果为我自己所发送的消息*/
        JMSGUser *user = [JMSGUser myInfo];
        if(_single.imagePath1 != nil){/**如果本地有存储头像*/
            UIImage *image = [UIImage imageWithContentsOfFile:_single.imagePath1];
            _profile_image_url.image = image;/**直接本地获取数据*/
        }
        if(_single.imagePath1 == nil){/**如果本地没有存储头像*/
            if(user.avatar){/**如果该账号有设置头像*/
                NSArray *array=[[NSArray alloc] initWithObjects:user.username,nil];
                [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
                    JMSGUser *user = resultObject[0];
                    [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                        self->_profile_image_url.image = [UIImage imageWithData:data];
                        NSString *path_document = NSHomeDirectory();
                        self->_single.imagePath1 = [path_document stringByAppendingString:@"/Documents/pic1.png"];
                        [UIImagePNGRepresentation(self->_profile_image_url.image) writeToFile:self->_single.imagePath1 atomically:YES];
                        /**从网络请求头像数据，设置该头像，并且存储到本地中*/
                    }];
                }];
            }
            else{/**如果该账号没有头像，则设置默认占位图*/
                _profile_image_url.image = [UIImage imageNamed:@"head"];
            }
        }
    }
    else{/**如果为对方所发送的消息*/
        if(_single.imagePath2 != nil){/**如果本地有存储头像，直接本地获取设置*/
            UIImage *image = [UIImage imageWithContentsOfFile:_single.imagePath2];
            _profile_image_url.image = image;
        }
        if(_single.imagePath2 == nil){/**如果本地没有头像数据*/
            if(_single.userdata.avater){/**如果该账号有设置头像*/
                NSArray *array=[[NSArray alloc] initWithObjects:_single.userdata.username,nil];
                [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
                    JMSGUser *user = resultObject[0];
                    [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                        self->_profile_image_url.image = [UIImage imageWithData:data];
                        NSString *path_document = NSHomeDirectory();
                        self->_single.imagePath2 = [path_document stringByAppendingString:@"/Documents/pic2.png"];
                        [UIImagePNGRepresentation(self->_profile_image_url.image) writeToFile:self->_single.imagePath2 atomically:YES];
                        /**从网络获取设置头像，并且存储到本地*/
                    }];
                }];
            }
            else{/**如果该账号没有头像，设置占位图*/
                _profile_image_url.image = [UIImage imageNamed:@"head"];
            }
        }
    }

    /**内容*/
    JMSGAbstractContent *content = message.content;
    if(message.contentType== kJMSGContentTypeText){
        JMSGTextContent *textcontent = (JMSGTextContent *)content;
        _text.text = textcontent.text;
    }
    
    /**图片*/
    JMSGAbstractContent *contentimage = message.content;
    if(message.contentType == kJMSGContentTypeImage){
        JMSGImageContent *imagecontent = (JMSGImageContent *)contentimage;
        NSLog(@"");
//        if([UIImage imageWithContentsOfFile:imagecontent.originMediaLocalPath]){
//            _picture.image = [UIImage imageWithContentsOfFile:imagecontent.originMediaLocalPath];
//        }
        _picture.image = [UIImage imageWithContentsOfFile:[message.timestamp stringValue]];
        if(_picture.image == nil){
            [imagecontent thumbImageData:^(NSData *data, NSString *objectId, NSError *error) {
                self->_picture.image = [UIImage imageWithData:data];
                NSString *path_document = NSHomeDirectory();
                self->_single.imagePath2 = [path_document stringByAppendingString:[message.timestamp stringValue]];
                [UIImagePNGRepresentation(self->_picture.image) writeToFile:self->_single.imagePath2 atomically:YES];
                if(message.fromName == nil){/**如果为我自己所发送的消息*/
                    self->_picture.frame = CGRectMake(110, 0, 200, 200);
                }
                else{
                    self->_picture.frame = CGRectMake(80, 0, 200, 200);
                }
            }];
        }
    }
}

- (void)SetFrame:(JMSGMessage *)message{
    if(message.fromName != nil){/**对方所发送消息*/
        [_profile_image_url setFrame:CGRectMake(10, 10, 50, 50)];
        _text.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
        _text.numberOfLines = 0;/**多行显示文字*/
        _text.font=[UIFont systemFontOfSize:11.0];
        _text.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [_text sizeThatFits:CGSizeMake(280, MAXFLOAT)];/**根据文字的长度返回一个最佳宽度和高度*/
        if(size.height < 14){
            CGSize size = [_text sizeThatFits:CGSizeMake(MAXFLOAT, 13.33333333)];
            [_text setFrame:CGRectMake(80, 20, size.width, 13.33333)];
        }
        else{
            [_text setFrame:CGRectMake(80, 20, 280, size.height)];
        }
        if(message.contentType== kJMSGContentTypeText){
            _background.frame = CGRectMake(_text.frame.origin.x-10, _text.frame.origin.y-10, _text.frame.size.width+20, _text.frame.size.height+20);
            _background.image = [UIImage imageNamed:@"leftchat"];
        }


    }
    
    if(message.fromName == nil){/**自己所发送消息*/
        [_profile_image_url setFrame:CGRectMake(SCREEN_WIDTH-60, 10, 50, 50)];
        _text.textAlignment = NSTextAlignmentLeft; /**设置字体的显示位置居左*/
        _text.numberOfLines = 0;
        _text.font=[UIFont systemFontOfSize:11.0];
        _text.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [_text sizeThatFits:CGSizeMake(280, MAXFLOAT)];/**根据文字的长度返回一个最佳高度*/
        if(size.height < 14){
            CGSize size = [_text sizeThatFits:CGSizeMake(MAXFLOAT, 13.333333333333)];/**根据文字的长度返回一个最佳宽度*/
            [_text setFrame:CGRectMake(310-size.width, 20, size.width, 13.33333333)];
        }
        else{
            [_text setFrame:CGRectMake(30, 20, 280, size.height)];
        }
        if(message.contentType== kJMSGContentTypeText){
            _background.frame = CGRectMake(_text.frame.origin.x-10, _text.frame.origin.y-10, _text.frame.size.width+20, _text.frame.size.height+20);
            _background.image = [UIImage imageNamed:@"rightchat"];
        }
    }


   
    if(message.contentType == kJMSGContentTypeImage){
        _cellheight = 200;
    }
    else{
        if(_text.frame.size.height > 30){
            _cellheight = _text.frame.size.height+40;
        }
        else
            _cellheight = 70;
    }
    
    
    
    
}







@end
