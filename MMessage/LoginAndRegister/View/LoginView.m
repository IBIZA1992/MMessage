//
//  LoginView.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "LoginView.h"

@implementation LoginView

- (void)LoadLoaginView{
    
    _background1=[[UIImageView alloc] init];
    _background1.frame=CGRectMake(0, 0,390,845);
    _background1.image=[UIImage imageNamed:@"background1"];
    [self addSubview:_background1];
    
    _circle1=[[UIImageView alloc] init];
    _circle1.frame=CGRectMake(86, -166,400,400);
    _circle1.image=[UIImage imageNamed:@"Logincircle1"];
    [self addSubview:_circle1];
    
    _circle2=[[UIImageView alloc] init];
    _circle2.frame=CGRectMake(-174, 136,280,280);
    _circle2.image=[UIImage imageNamed:@"Logincircle2"];
    [self addSubview:_circle2];
    
    _circle3=[[UIImageView alloc] init];
    _circle3.frame=CGRectMake(153, 297,400,400);
    _circle3.image=[UIImage imageNamed:@"Logincircle3"];
    [self addSubview:_circle3];
    
    _title=[[UIImageView alloc] init];
    _title.frame=CGRectMake(73, 28,280,207);
    _title.image=[UIImage imageNamed:@"titlelogin"];
    [self addSubview:_title];
    
    _background2=[[UIImageView alloc] init];
    _background2.frame=CGRectMake(20, 313,353,582);
    _background2.image=[UIImage imageNamed:@"background2"];
    [self addSubview:_background2];
    
    _account=[[UIImageView alloc] init];
    _account.frame=CGRectMake(49, 377,189,29);
    _account.image=[UIImage imageNamed:@"account"];
    [self addSubview:_account];
    
    _password=[[UIImageView alloc] init];
    _password.frame=CGRectMake(49,430,64,29);
    _password.image=[UIImage imageNamed:@"password"];
    [self addSubview:_password];
    
    _textaccount=[[UITextField alloc] initWithFrame:CGRectMake(118, 376, 200, 30)];
    _textaccount.backgroundColor=[UIColor whiteColor];
    _textaccount.placeholder=@"邮箱｜手机号";
    _textaccount.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_textaccount];
    
    _textpassword=[[UITextField alloc] initWithFrame:CGRectMake(118, 428, 212, 30)];
    _textpassword.backgroundColor=[UIColor whiteColor];
    _textpassword.placeholder=@"请输入密码";
    _textpassword.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_textpassword];
    
    _line1=[[UIImageView alloc] init];
    _line1.frame=CGRectMake(118, 406,213,1);
    _line1.image=[UIImage imageNamed:@"line1"];
    [self addSubview:_line1];
    
    _line2=[[UIImageView alloc] init];
    _line2.frame=CGRectMake(118, 458,213,1);
    _line2.image=[UIImage imageNamed:@"line1"];
    [self addSubview:_line2];
    
    _line3=[[UIImageView alloc] init];
    _line3.frame=CGRectMake(142,782,1,23);
    _line3.image=[UIImage imageNamed:@"line2"];
    [self addSubview:_line3];
    
    _line4=[[UIImageView alloc] init];
    _line4.frame=CGRectMake(253,782 ,1,23);
    _line4.image=[UIImage imageNamed:@"line2"];
    [self addSubview:_line4];
    
    _btnlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnlogin setFrame:CGRectMake(91, 503,210,44)];
    [_btnlogin setBackgroundImage:[UIImage imageNamed:@"btnlogin"] forState:UIControlStateNormal];
    [self addSubview:_btnlogin];
    
    _btnZhifubao= [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnZhifubao setFrame:CGRectMake(49, 784,70,20)];
    [_btnZhifubao setBackgroundImage:[UIImage imageNamed:@"btnZhifubao"] forState:UIControlStateNormal];
    [self addSubview:_btnZhifubao];
    
    _btnforget = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnforget setFrame:CGRectMake(169, 784,56,20)];
    [_btnforget setBackgroundImage:[UIImage imageNamed:@"btnforget"] forState:UIControlStateNormal];
    [self addSubview:_btnforget];
    
    _btnregister = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnregister setFrame:CGRectMake(276, 784,70,20)];
    [_btnregister setBackgroundImage:[UIImage imageNamed:@"btnregister"] forState:UIControlStateNormal];
    [self addSubview:_btnregister];
    

}

@end
