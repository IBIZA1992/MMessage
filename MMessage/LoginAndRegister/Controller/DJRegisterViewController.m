//
//  DJRegisterViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJRegisterViewController.h"
#import "DJRegisterView.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
