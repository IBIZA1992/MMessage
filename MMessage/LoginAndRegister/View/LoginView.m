//
//  LoginView.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "LoginView.h"
#import "MMScreen.h"

@implementation LoginView

- (void)LoadLoaginView{
    
    _background1=[[UIImageView alloc] init];
    _background1.frame=CGRectMake(0, 0,390*SCREEN_WIDTH/390,845*SCREEN_HEIGHT/845);
    _background1.image=[UIImage imageNamed:@"background1"];
    [self addSubview:_background1];
    
    _circle1=[[UIImageView alloc] init];
    _circle1.frame=CGRectMake(86*SCREEN_WIDTH/390, -166*SCREEN_HEIGHT/845,400*SCREEN_WIDTH/390,400*SCREEN_HEIGHT/845);
    _circle1.image=[UIImage imageNamed:@"Logincircle1"];
    [self addSubview:_circle1];
    
    _circle2=[[UIImageView alloc] init];
    _circle2.frame=CGRectMake(-174*SCREEN_WIDTH/390, 136*SCREEN_HEIGHT/845,280*SCREEN_WIDTH/390,280*SCREEN_HEIGHT/845);
    _circle2.image=[UIImage imageNamed:@"Logincircle2"];
    [self addSubview:_circle2];
    
    _circle3=[[UIImageView alloc] init];
    _circle3.frame=CGRectMake(153*SCREEN_WIDTH/390, 297*SCREEN_HEIGHT/845,400*SCREEN_WIDTH/390,400*SCREEN_HEIGHT/845);
    _circle3.image=[UIImage imageNamed:@"Logincircle3"];
    [self addSubview:_circle3];
    
    _title=[[UIImageView alloc] init];
    _title.frame=CGRectMake(73*SCREEN_WIDTH/390, 28*SCREEN_HEIGHT/845,280*SCREEN_WIDTH/390,207*SCREEN_HEIGHT/845);
    _title.image=[UIImage imageNamed:@"titlelogin"];
    [self addSubview:_title];
    
    _background2=[[UIImageView alloc] init];
    _background2.frame=CGRectMake(20*SCREEN_WIDTH/390, 313*SCREEN_HEIGHT/845,353*SCREEN_WIDTH/390,582*SCREEN_HEIGHT/845);
    _background2.image=[UIImage imageNamed:@"background2"];
    [self addSubview:_background2];
    
    _account=[[UIImageView alloc] init];
    _account.frame=CGRectMake(49*SCREEN_WIDTH/390, 377*SCREEN_HEIGHT/845,189*SCREEN_WIDTH/390,29*SCREEN_HEIGHT/845);
    _account.image=[UIImage imageNamed:@"account"];
    [self addSubview:_account];
    
    _password=[[UIImageView alloc] init];
    _password.frame=CGRectMake(49*SCREEN_WIDTH/390,430*SCREEN_HEIGHT/845,64*SCREEN_WIDTH/390,29*SCREEN_HEIGHT/845);
    _password.image=[UIImage imageNamed:@"password"];
    [self addSubview:_password];
    
    _textaccount=[[UITextField alloc] initWithFrame:CGRectMake(118*SCREEN_WIDTH/390, 376*SCREEN_HEIGHT/845, 200*SCREEN_WIDTH/390, 30*SCREEN_HEIGHT/845)];
    _textaccount.backgroundColor=[UIColor whiteColor];
    _textaccount.placeholder=@"账号";
    _textaccount.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_textaccount];
    
    _textpassword=[[UITextField alloc] initWithFrame:CGRectMake(118*SCREEN_WIDTH/390, 428*SCREEN_HEIGHT/845, 212*SCREEN_WIDTH/390, 30*SCREEN_HEIGHT/845)];
    _textpassword.backgroundColor=[UIColor whiteColor];
    _textpassword.placeholder=@"请输入密码";
    _textpassword.secureTextEntry = YES;
    _textpassword.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_textpassword];
    
    _line1=[[UIImageView alloc] init];
    _line1.frame=CGRectMake(118*SCREEN_WIDTH/390, 406*SCREEN_HEIGHT/845,213*SCREEN_WIDTH/390,1*SCREEN_HEIGHT/845);
    _line1.image=[UIImage imageNamed:@"line1"];
    [self addSubview:_line1];
    
    _line2=[[UIImageView alloc] init];
    _line2.frame=CGRectMake(118*SCREEN_WIDTH/390, 458*SCREEN_HEIGHT/845,213*SCREEN_WIDTH/390,1*SCREEN_HEIGHT/845);
    _line2.image=[UIImage imageNamed:@"line1"];
    [self addSubview:_line2];
    
    _line3=[[UIImageView alloc] init];
    _line3.frame=CGRectMake(142*SCREEN_WIDTH/390,782*SCREEN_HEIGHT/845,1*SCREEN_WIDTH/390,23*SCREEN_HEIGHT/845);
    _line3.image=[UIImage imageNamed:@"line2"];
    [self addSubview:_line3];
    
    _line4=[[UIImageView alloc] init];
    _line4.frame=CGRectMake(253*SCREEN_WIDTH/390,782*SCREEN_HEIGHT/845 ,1*SCREEN_WIDTH/390,23*SCREEN_HEIGHT/845);
    _line4.image=[UIImage imageNamed:@"line2"];
    [self addSubview:_line4];
    
    _btnlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnlogin setFrame:CGRectMake(91*SCREEN_WIDTH/390, 503*SCREEN_HEIGHT/845,210*SCREEN_WIDTH/390,44*SCREEN_HEIGHT/845)];
    [_btnlogin setBackgroundImage:[UIImage imageNamed:@"btnlogin"] forState:UIControlStateNormal];
    [self addSubview:_btnlogin];
    
    _btnZhifubao= [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnZhifubao setFrame:CGRectMake(49*SCREEN_WIDTH/390, 784*SCREEN_HEIGHT/845,70*SCREEN_WIDTH/390,20*SCREEN_HEIGHT/845)];
    [_btnZhifubao setBackgroundImage:[UIImage imageNamed:@"btnZhifubao"] forState:UIControlStateNormal];
    [self addSubview:_btnZhifubao];
    
    _btnforget = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnforget setFrame:CGRectMake(169*SCREEN_WIDTH/390, 784*SCREEN_HEIGHT/845,56*SCREEN_WIDTH/390,20*SCREEN_HEIGHT/845)];
    [_btnforget setBackgroundImage:[UIImage imageNamed:@"btnforget"] forState:UIControlStateNormal];
    [self addSubview:_btnforget];
    
    _btnregister = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnregister setFrame:CGRectMake(276*SCREEN_WIDTH/390, 784*SCREEN_HEIGHT/845,70*SCREEN_WIDTH/390,20*SCREEN_HEIGHT/845)];
    [_btnregister setBackgroundImage:[UIImage imageNamed:@"btnregister"] forState:UIControlStateNormal];
    [self addSubview:_btnregister];
    

}

@end
