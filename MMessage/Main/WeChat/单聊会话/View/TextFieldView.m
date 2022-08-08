//
//  TextFieldView.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/4.
//

#import "TextFieldView.h"

@implementation TextFieldView

- (void)LoadTextFieldView{
    
    self.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;
    _textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, 300, 30)];
    _textfield.borderStyle = UITextBorderStyleBezel;
    _textfield.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_textfield];
    
    _btnsend = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnsend setFrame:CGRectMake(SCREEN_WIDTH-40, 10, 20, 20)];
    [_btnsend setBackgroundImage:[UIImage imageNamed:@"picture"] forState:UIControlStateNormal];
    [self addSubview:_btnsend];
    
    
    
}






@end
