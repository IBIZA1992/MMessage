//
//  DJRegisterViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJRegisterViewController.h"
#import "DJRegisterView.h"
#import "JMessage/JMessage.h"

@interface DJRegisterViewController ()
@property(nonatomic, strong) DJRegisterView *registerview;
@end

@implementation DJRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _registerview=[[DJRegisterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_registerview Loadregister];
    [self.view addSubview:_registerview];
    [_registerview.btnregist addTarget:self action:@selector(regist)forControlEvents:UIControlEventTouchUpInside];
    [_registerview.btnback addTarget:self action:@selector(back)forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)regist{
    
//    UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您注册成功" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *tishi=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
////        Singleton *single=[[Singleton alloc] init];
////        single.account=self.registview.account.text;
////        single.password=self.registview.password.text;
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//
//    [alert1 addAction:tishi];
//    [self presentViewController:alert1 animated:YES completion:nil];
    
    
    [JMSGUser registerWithUsername:self.registerview.account.text password:self.registerview.password.text completionHandler:^(id resultObject, NSError *error) {
        if(error==nil){
            UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *tishi=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert1 addAction:tishi];
            [self presentViewController:alert1 animated:YES completion:nil];
        }
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
