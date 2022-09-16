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

- (void)Loadwechattableviewcell:(id)type {
    [self SetData:type];
    [self SetFrame:type];
}


- (void)SetData:(id)type {

    NSArray *array = [[NSArray alloc] initWithObjects:type,nil];
    [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
        //为单聊消息
        if(!error){
            JMSGUser *user = resultObject[0];
            //头像
            if([[NSUserDefaults standardUserDefaults] objectForKey:user.avatar]) {/**如果本地有图片*/
                NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:user.avatar];
                self.profile_image_url.image = [UIImage imageWithData:imageData];
            }
            else {
                if(user.avatar){/**判断是否有头像*/
                    NSArray *array = [[NSArray alloc] initWithObjects:user.username,nil]; /**获得对方账号的userdata存入array中*/
                    [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) { /**通过对方的userdata获取对方的信息*/
                        JMSGUser *user = resultObject[0]; /**返回对象即为对方的user*/
                        [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) { /**从网络请求头像数据*/
                            self.profile_image_url.image = [UIImage imageWithData:data]; /**更新UI数据*/
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{/**在子线程中将头像数据存入本地磁盘*/
                                [[NSUserDefaults standardUserDefaults] setObject:data forKey:user.avatar];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            });
                        }];
                    }];
                }
                else{
                    self.profile_image_url.image = [UIImage imageNamed:@"head"];
                }
            }

            //昵称
            self->_name.text = user.username;
            //内容
            JMSGConversation *conversation = [JMSGConversation singleConversationWithUsername:user.username];
            JMSGMessage *message = [conversation latestMessage];
            if(message.contentType == kJMSGContentTypeText){
                JMSGAbstractContent *content = message.content;
                JMSGTextContent *textcontent = (JMSGTextContent *)content;
                self.text.text = textcontent.text;
            }
            if(message.contentType == kJMSGContentTypeImage){
                self.text.text = @"图片";
            }

            
        }
        //群聊消息
        else {
            [JMSGGroup groupInfoWithGroupId:type completionHandler:^(id resultObject, NSError *error) {
                JMSGGroup *group = resultObject;
                //头像
                [group thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                    self->_profile_image_url.image = [UIImage imageWithData:data];
                }];
                //昵称
                self->_name.text = group.name;
                //内容
                JMSGConversation *conversation = [JMSGConversation groupConversationWithGroupId:group.gid];
                JMSGMessage *message = [conversation latestMessage];
                if(message.contentType == kJMSGContentTypeText){
                    JMSGAbstractContent *content = message.content;
                    JMSGTextContent *textcontent = (JMSGTextContent *)content;
                    self.text.text = textcontent.text;
                }
                if(message.contentType == kJMSGContentTypeImage){
                    self.text.text = @"图片";
                }
                
            }];
        }
        
        
    }];
}


- (void)SetFrame:(id)type {
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
