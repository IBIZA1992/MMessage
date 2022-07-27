//
//  DJRegisterViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJRegisterViewController.h"
#import "DJRegisterView.h"
#import "JMessage/JMessage.h"
#import "MMScreen.h"

/**
 注册控制器
 */
@interface DJRegisterViewController ()
@property(nonatomic, strong) DJRegisterView *registerview;
@end

@implementation DJRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _registerview=[[DJRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_registerview Loadregister];
    [self.view addSubview:_registerview];
    [_registerview.btnregist addTarget:self action:@selector(regist)forControlEvents:UIControlEventTouchUpInside];
    [_registerview.btnback addTarget:self action:@selector(back)forControlEvents:UIControlEventTouchUpInside];
}

///注册
- (void)regist{
    [JMSGUser registerWithUsername:self.registerview.account.text password:self.registerview.password.text completionHandler:^(id resultObject, NSError *error) {
        /**注册成功*/
        if(error==nil){
            UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *tishi=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert1 addAction:tishi];
            [self presentViewController:alert1 animated:YES completion:nil];
        }
        /**注册失败*/
        /**
         失败原因：账号已被注册 / 网络不好 （后续判断补充）
         */
        if(error){
            UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"提示" message:@"该账号已被注册" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *tishi=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert1 addAction:tishi];
            [self presentViewController:alert1 animated:YES completion:nil];
        }
    }];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
