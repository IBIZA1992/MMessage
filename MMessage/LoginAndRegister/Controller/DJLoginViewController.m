//
//  DJLoginViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJLoginViewController.h"
#import "LoginView.h"
#import "DJRegisterViewController.h"

@interface DJLoginViewController ()
@property(nonatomic, strong)LoginView *loginview;
@property(nonatomic, strong)DJRegisterViewController *registerVC;
@end

@implementation DJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _loginview=[[LoginView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_loginview LoadLoaginView];
    [self.view addSubview:_loginview];
    [_loginview.btnlogin addTarget:self action:@selector(login)forControlEvents:UIControlEventTouchUpInside];
    [_loginview.btnregister addTarget:self action:@selector(registers)forControlEvents:UIControlEventTouchUpInside];
}

- (void)registers{
    _registerVC = [[DJRegisterViewController alloc] init];
    [self.navigationController pushViewController:_registerVC animated:YES];
}


@end
