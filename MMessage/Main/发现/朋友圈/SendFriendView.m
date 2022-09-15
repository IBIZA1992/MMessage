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
    _image1.frame = CGRectMake(10, 150, 100, 100);
    _image1.image = [UIImage imageNamed:@"addImage"];
    [self addSubview:_image1];
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button1 setFrame:CGRectMake(10, 150, 100, 100)];
    _button1.tag = 1;
    [self addSubview:_button1];

    _image2 = [[UIImageView alloc] init];
    _image2.frame = CGRectMake(120, 150, 100, 100);
    _image2.image = [UIImage imageNamed:@"addImage"];
    [self addSubview:_image2];
    _image2.alpha = 0;
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button2 setFrame:CGRectMake(120, 150, 100, 100)];
    [self addSubview:_button2];
    _button2.enabled = NO;
    _button2.tag = 2;

    
    _image3 = [[UIImageView alloc] init];
    _image3.frame = CGRectMake(230, 150, 100, 100);
    _image3.image = [UIImage imageNamed:@"addImage"];
    [self addSubview:_image3];
    _image3.alpha = 0;
    _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button3 setFrame:CGRectMake(230, 150, 100, 100)];
    [self addSubview:_button3];
    _button3.tag = 3;
    _button3.enabled = NO;

    
    _image4 = [[UIImageView alloc] init];
    _image4.frame = CGRectMake(10, 260, 100, 100);
    _image4.image = [UIImage imageNamed:@"addImage"];
    [self addSubview:_image4];
    _image4.alpha = 0;
    _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button4 setFrame:CGRectMake(10, 260, 100, 100)];
    [self addSubview:_button4];
    _button4.tag = 4;
    _button4.enabled = NO;


    _image5 = [[UIImageView alloc] init];
    _image5.frame = CGRectMake(120, 260, 100, 100);
    _image5.image = [UIImage imageNamed:@"addImage"];
    [self addSubview:_image5];
    _image5.alpha = 0;
    _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button5 setFrame:CGRectMake(120, 260, 100, 100)];
    [self addSubview:_button5];
    _button5.enabled = NO;
    _button5.tag = 5;

    
    _image6 = [[UIImageView alloc] init];
    _image6.frame = CGRectMake(230, 260, 100, 100);
    _image6.image = [UIImage imageNamed:@"addImage"];
    [self addSubview:_image6];
    _image6.alpha = 0;
    _button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button6 setFrame:CGRectMake(230, 260, 100, 100)];
    [self addSubview:_button6];
    _button6.enabled = NO;
    _button6.tag = 6;

    
    
}



@end
