//
//  DJLoginViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJLoginViewController.h"
#import "LoginView.h"
#import "DJRegisterViewController.h"
#import "JMessage/JMessage.h"
#import "MMScreen.h"

/**
 登陆控制器
 */
@interface DJLoginViewController ()
@property(nonatomic, strong)LoginView *loginview;
@property(nonatomic, strong)DJRegisterViewController *registerVC;
@end

@implementation DJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _loginview=[[LoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_loginview LoadLoaginView];
    [self.view addSubview:_loginview];
    [_loginview.btnlogin addTarget:self action:@selector(login)forControlEvents:UIControlEventTouchUpInside];
    [_loginview.btnregister addTarget:self action:@selector(registers)forControlEvents:UIControlEventTouchUpInside];
}

///进入注册控制器
- (void)registers{
    _registerVC = [[DJRegisterViewController alloc] init];
    [self.navigationController pushViewController:_registerVC animated:YES];
}

/// 点击登录
- (void)login{
    NSString *account=self.loginview.textaccount.text;
    NSString *password=self.loginview.textpassword.text;
    
    [JMSGUser loginWithUsername:account password:password completionHandler:^(id resultObject, NSError *error) {
        /**
         登陆失败原因：网络延迟 / 密码错误 / 账号错误 （后续判断）
         */
        if(error){
            NSLog(@"");
            UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"提示" message:@"登陆失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *tishi=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert1 addAction:tishi];
            [self presentViewController:alert1 animated:YES completion:nil];
        }
        /**
         登陆成功
         */
        if(!error){
            /**登陆成功，在这里切换进入聊天窗口*/
            /*******************
             ********************
             ********************
             ********************/
            [JMSGUser myInfo];
            NSLog(@"");
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"login" object:nil];

        }
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}








@end
