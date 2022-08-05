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
        //用户昵称
        [self.contentView addSubview:({
            _text=[[UILabel alloc] init];
            _text;
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
    
//    /**头像*/
//    if(.avater){
//        NSArray *array=[[NSArray alloc] initWithObjects:item.username,nil];
//        [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
//            JMSGUser *user = resultObject[0];
//            [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
//                self->_profile_image_url.image = [UIImage imageWithData:data];
//            }];
//        }];
//    }
//    else
//        _profile_image_url.image = [UIImage imageNamed:@"head"];
    /**头像数据*/
  //  [_profile_image_url sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    
    if(message.fromName == nil){
        JMSGUser *user = [JMSGUser myInfo];
        if(_single.imagePath1 != nil){
            UIImage *image = [UIImage imageWithContentsOfFile:_single.imagePath1];
            _profile_image_url.image = image;
        }
        if(_single.imagePath1 == nil){
            if(user.avatar){
                NSArray *array=[[NSArray alloc] initWithObjects:user.username,nil];
                [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
                    JMSGUser *user = resultObject[0];
                    [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                        self->_profile_image_url.image = [UIImage imageWithData:data];
                        NSString *path_document = NSHomeDirectory();
                        self->_single.imagePath1 = [path_document stringByAppendingString:@"/Documents/pic1.png"];
                        [UIImagePNGRepresentation(self->_profile_image_url.image) writeToFile:self->_single.imagePath1 atomically:YES];
                        NSLog(@"");
                    }];
                }];
            }
            else{
                _profile_image_url.image = [UIImage imageNamed:@"head"];
            }
        }
    }
    else{
        if(_single.imagePath2 != nil){
            UIImage *image = [UIImage imageWithContentsOfFile:_single.imagePath2];
            _profile_image_url.image = image;
        }
        if(_single.imagePath2 == nil){
            if(_single.userdata.avater){
                NSArray *array=[[NSArray alloc] initWithObjects:_single.userdata.username,nil];
                [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
                    JMSGUser *user = resultObject[0];
                    [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                        self->_profile_image_url.image = [UIImage imageWithData:data];
                        NSString *path_document = NSHomeDirectory();
                        self->_single.imagePath2 = [path_document stringByAppendingString:@"/Documents/pic2.png"];
                        [UIImagePNGRepresentation(self->_profile_image_url.image) writeToFile:self->_single.imagePath2 atomically:YES];
                    }];
                }];
            }
            else{
                _profile_image_url.image = [UIImage imageNamed:@"head"];
            }
        }
    }
    
//    else{
//        if(_single.userdata.avater){
//            NSArray *array=[[NSArray alloc] initWithObjects:_single.userdata.username,nil];
//            [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
//                JMSGUser *user = resultObject[0];
//                [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
//                self->_profile_image_url.image = [UIImage imageWithData:data];
//                }];
//            }];
//        }
//        else
//            _profile_image_url.image = [UIImage imageNamed:@"head"];
//    }
    
    
    
    
    
    
    
    
    
    /**内容*/
    JMSGAbstractContent *content = message.content;
    if(message.contentType== kJMSGContentTypeText){
        JMSGTextContent *textcontent = (JMSGTextContent *)content;
        _text.text = textcontent.text;
    }

    
}

- (void)SetFrame:(JMSGMessage *)message{
    if(message.fromName != nil){
        [_profile_image_url setFrame:CGRectMake(10, 10, 50, 50)];
        _text.textAlignment = NSTextAlignmentLeft; // 设置字体的显示位置居左
        _text.numberOfLines = 0;
        _text.font=[UIFont systemFontOfSize:11.0];
        _text.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [_text sizeThatFits:CGSizeMake(300, MAXFLOAT)];//根据文字的长度返回一个最佳宽度和高度
        [_text setFrame:CGRectMake(70, 20, 300, size.height)];
    }
    
    if(message.fromName == nil){
        [_profile_image_url setFrame:CGRectMake(SCREEN_WIDTH-60, 10, 50, 50)];
        _text.textAlignment = NSTextAlignmentRight; // 设置字体的显示位置居右
        _text.numberOfLines = 0;
        _text.font=[UIFont systemFontOfSize:11.0];
        _text.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [_text sizeThatFits:CGSizeMake(300, MAXFLOAT)];//根据文字的长度返回一个最佳宽度和高度
        [_text setFrame:CGRectMake(20, 20, 300, size.height)];
    }
    
    
    
    
}







@end
