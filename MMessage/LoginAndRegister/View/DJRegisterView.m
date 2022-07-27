//
//  DJRegisterView.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJRegisterView.h"

@implementation DJRegisterView

- (void)Loadregister{
    
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
    
    _background2=[[UIImageView alloc] init];
    _background2.frame=CGRectMake(45, 182,300,471);
    _background2.image=[UIImage imageNamed:@"backgroundR"];
    [self addSubview:_background2];
    
    _icon1=[[UIImageView alloc] init];
    _icon1.frame=CGRectMake(146, 132,100,100);
    _icon1.image=[UIImage imageNamed:@"icon1"];
    [self addSubview:_icon1];
    
    _icon2=[[UIImageView alloc] init];
    _icon2.frame=CGRectMake(162, 148,68,68);
    _icon2.image=[UIImage imageNamed:@"icon2"];
    [self addSubview:_icon2];
    
    _icon3=[[UIImageView alloc] init];
    _icon3.frame=CGRectMake(95, 506,16,16);
    _icon3.image=[UIImage imageNamed:@"sureR"];
    [self addSubview:_icon3];
    
    _name=[[UITextField alloc] initWithFrame:CGRectMake(99, 265, 200, 30)];
    _name.backgroundColor=[UIColor whiteColor];
    _name.placeholder=@"用户名";
    _name.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_name];
    
    _account=[[UITextField alloc] initWithFrame:CGRectMake(99, 328, 200, 30)];
    _account.backgroundColor=[UIColor whiteColor];
    _account.placeholder=@"邮箱｜手机号";
    _account.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_account];
    
    _password=[[UITextField alloc] initWithFrame:CGRectMake(99, 393, 200, 30)];
    _password.backgroundColor=[UIColor whiteColor];
    _password.placeholder=@"密码";
    _password.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_password];
    
    _sure=[[UITextField alloc] initWithFrame:CGRectMake(99, 456, 200, 30)];
    _sure.backgroundColor=[UIColor whiteColor];
    _sure.placeholder=@"确认密码";
    _sure.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_sure];
    
    _text=[[UIImageView alloc] init];
    _text.frame=CGRectMake(117, 506,178,39);
    _text.image=[UIImage imageNamed:@"textR"];
    [self addSubview:_text];
    
    _btnregist = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnregist setFrame:CGRectMake(110, 585,172,39)];
    [_btnregist setBackgroundImage:[UIImage imageNamed:@"registerR"] forState:UIControlStateNormal];
    [self addSubview:_btnregist];
    
    _btnback = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnback setFrame:CGRectMake(19,60,30,30)];
    [_btnback setBackgroundImage:[UIImage imageNamed:@"水培返回"] forState:UIControlStateNormal];
    [self addSubview:_btnback];
}



@end
