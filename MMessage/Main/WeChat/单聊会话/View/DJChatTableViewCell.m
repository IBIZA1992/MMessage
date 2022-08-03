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
    
    /**头像数据*/
  //  [_profile_image_url sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    _profile_image_url.image = [UIImage imageNamed:@"head"];
    /**内容*/
    
    JMSGAbstractContent *content = message.content;
    if(message.contentType== kJMSGContentTypeText){
        JMSGTextContent *textcontent = (JMSGTextContent *)content;
        _text.text = textcontent.text;
    }
    
    
    NSLog(@"");
    
}

- (void)SetFrame:(JMSGMessage *)message{
    [_profile_image_url setFrame:CGRectMake(10, 10, 50, 50)];
    [_text setFrame:CGRectMake(80, 20, 200, 50)];
}







@end
