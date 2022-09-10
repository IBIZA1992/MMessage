//
//  DJWeChatTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/4.
//

#import "DJWeChatTableViewCell.h"

@implementation DJWeChatTableViewCell

//重写初始化方法 创造控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        //用户头像
        [self.contentView addSubview:({
            _profile_image_url = [[UIImageView alloc] initWithFrame:CGRectZero];
            _profile_image_url.contentMode=UIViewContentModeScaleAspectFit;
            _profile_image_url;
        })];
        //昵称
        [self.contentView addSubview:({
            _name = [[UILabel alloc] init];
            _name;
        })];
        //内容
        [self.contentView addSubview:({
            _text = [[UILabel alloc] init];
            _text;
        })];
    }
    return self;
}

- (void)Loadwechattableviewcell:(NSString *)username {
    [self SetData:username];
    [self SetFrame:username];
}


- (void)SetData:(NSString *)username {
    
    _single = [DJSingleton sharedManager];
    NSArray *array = [[NSArray alloc] initWithObjects:username,nil];
    [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
        //头像
        JMSGUser *user = resultObject[0];
        [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
        self->_profile_image_url.image = [UIImage imageWithData:data];
        }];
    
        
        //昵称
        self->_name.text = user.username;
        //内容
        [[JMSGConversation singleConversationWithUsername:self->_single.userdata.username] allMessages:^(id resultObject, NSError *error) {
            self->_single.messageArray = @[].mutableCopy;
            self->_single.messageArray = (NSMutableArray *)resultObject;
            JMSGMessage *message =  self->_single.messageArray[0];
            JMSGAbstractContent *content = message.content;
            if(message.contentType == kJMSGContentTypeText){
                JMSGTextContent *textcontent = (JMSGTextContent *)content;
                self->_text.text = textcontent.text;
            }
        }];
    }];
    
    
    
}


- (void)SetFrame:(NSString *)username {
    [_profile_image_url setFrame:CGRectMake(10, 10, 50, 50)];
    _text.textAlignment = NSTextAlignmentLeft;
    _text.numberOfLines = 0;
    _text.font=[UIFont systemFontOfSize:11.0];
    _text.lineBreakMode = NSLineBreakByWordWrapping;
    [_text setFrame:CGRectMake(70, 45, 300, 20)];
    
    _name.textAlignment = NSTextAlignmentLeft;
    _name.numberOfLines = 0;
    _name.font=[UIFont systemFontOfSize:14.0];
    _name.lineBreakMode = NSLineBreakByWordWrapping;
    [_name setFrame:CGRectMake(70, 5, 300, 40)];

    
}




@end
