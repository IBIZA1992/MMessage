//
//  DJRegisterView.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJRegisterView.h"
#import "MMScreen.h"

@implementation DJRegisterView

- (void)Loadregister{
    
    _background1=[[UIImageView alloc] init];
    _background1.frame=CGRectMake(0, 0,390,845*SCREEN_HEIGHT/845);
    _background1.image=[UIImage imageNamed:@"background1"];
    [self addSubview:_background1];
    
    _circle1=[[UIImageView alloc] init];
    _circle1.frame=CGRectMake(86, -166*SCREEN_HEIGHT/845,400,400*SCREEN_HEIGHT/845);
    _circle1.image=[UIImage imageNamed:@"Logincircle1"];
    [self addSubview:_circle1];
    
    _circle2=[[UIImageView alloc] init];
    _circle2.frame=CGRectMake(-174, 136*SCREEN_HEIGHT/845,280,280*SCREEN_HEIGHT/845);
    _circle2.image=[UIImage imageNamed:@"Logincircle2"];
    [self addSubview:_circle2];
    
    _circle3=[[UIImageView alloc] init];
    _circle3.frame=CGRectMake(153, 297*SCREEN_HEIGHT/845,400,400*SCREEN_HEIGHT/845);
    _circle3.image=[UIImage imageNamed:@"Logincircle3"];
    [self addSubview:_circle3];
    
    _background2=[[UIImageView alloc] init];
    _background2.frame=CGRectMake(45, 182*SCREEN_HEIGHT/845,300,471*SCREEN_HEIGHT/845);
    _background2.image=[UIImage imageNamed:@"backgroundR"];
    [self addSubview:_background2];
    
    _icon1=[[UIImageView alloc] init];
    _icon1.frame=CGRectMake(146, 132*SCREEN_HEIGHT/845,100,100*SCREEN_HEIGHT/845);
    _icon1.image=[UIImage imageNamed:@"icon1"];
    [self addSubview:_icon1];
    
    _icon2=[[UIImageView alloc] init];
    _icon2.frame=CGRectMake(162, 148*SCREEN_HEIGHT/845,68,68*SCREEN_HEIGHT/845);
    _icon2.image=[UIImage imageNamed:@"icon2"];
    [self addSubview:_icon2];
    
    _icon3=[[UIImageView alloc] init];
    _icon3.frame=CGRectMake(95, 506*SCREEN_HEIGHT/845,16,16*SCREEN_HEIGHT/845);
    _icon3.image=[UIImage imageNamed:@"sureR"];
    [self addSubview:_icon3];
    
    _name=[[UITextField alloc] initWithFrame:CGRectMake(99, 265*SCREEN_HEIGHT/845, 200, 30*SCREEN_HEIGHT/845)];
    _name.backgroundColor=[UIColor whiteColor];
    _name.placeholder=@"用户名";
    _name.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_name];
    
    _account=[[UITextField alloc] initWithFrame:CGRectMake(99, 328*SCREEN_HEIGHT/845, 200, 30*SCREEN_HEIGHT/845)];
    _account.backgroundColor=[UIColor whiteColor];
    _account.placeholder=@"账号";
    _account.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_account];
    
    _password=[[UITextField alloc] initWithFrame:CGRectMake(99, 393*SCREEN_HEIGHT/845, 200, 30*SCREEN_HEIGHT/845)];
    _password.backgroundColor=[UIColor whiteColor];
    _password.placeholder=@"密码";
    _password.secureTextEntry = YES;
    _password.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_password];
    
    _sure=[[UITextField alloc] initWithFrame:CGRectMake(99, 456*SCREEN_HEIGHT/845, 200, 30*SCREEN_HEIGHT/845)];
    _sure.backgroundColor=[UIColor whiteColor];
    _sure.placeholder=@"确认密码";
    _sure.secureTextEntry = YES;
    _sure.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_sure];
    
    _text=[[UIImageView alloc] init];
    _text.frame=CGRectMake(117, 506*SCREEN_HEIGHT/845,178,39*SCREEN_HEIGHT/845);
    _text.image=[UIImage imageNamed:@"textR"];
    [self addSubview:_text];
    
    _btnregist = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnregist setFrame:CGRectMake(110, 585*SCREEN_HEIGHT/845,172,39*SCREEN_HEIGHT/845)];
    [_btnregist setBackgroundImage:[UIImage imageNamed:@"registerR"] forState:UIControlStateNormal];
    [self addSubview:_btnregist];
    
    _btnback = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnback setFrame:CGRectMake(19,60*SCREEN_HEIGHT/845,30,30*SCREEN_HEIGHT/845)];
    [_btnback setBackgroundImage:[UIImage imageNamed:@"backR"] forState:UIControlStateNormal];
    [self addSubview:_btnback];
}



@end
