//
//  DJLoginViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJLoginViewController.h"
#import "LoginView.h"

@interface DJLoginViewController ()
@property(nonatomic, strong)LoginView *loginview;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
