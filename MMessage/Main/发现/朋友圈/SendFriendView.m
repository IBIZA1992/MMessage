//
//  SendFriendView.m
//  MMessage
//
//  Created by 邓杰 on 2022/9/7.
//

#import "SendFriendView.h"

@implementation SendFriendView

- (void)loadSendFriendView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.text = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 500)];
    self.text.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;
    self.text.font = [UIFont systemFontOfSize:20];
    self.text.textAlignment = NSTextAlignmentLeft;
    self.text.showsHorizontalScrollIndicator=NO;
    self.text.showsVerticalScrollIndicator=NO;
    [self addSubview:_text];
    
    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 200, 30)];
    self.placeholder.font = [UIFont systemFontOfSize:20];
    self.placeholder.text = @"分享新鲜事...";
    self.placeholder.textColor = [UIColor grayColor];
    [self addSubview:_placeholder];
    
    _image1 = [[UIImageView alloc] init];
    _image1.frame = CGRectMake(10, 380, 100, 100);
    _image1.image = [UIImage imageNamed:@"addImage"];
    [self addSubview:_image1];
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button1 setFrame:CGRectMake(10, 380, 100, 100)];
    [self addSubview:_button1];

    
    
    
}



@end
