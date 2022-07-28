//
//  MMWeChatViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/7/28.
//

#import "MMColor.h"
#import "MMWeChatViewController.h"

@interface MMWeChatViewController ()

@end

@implementation MMWeChatViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"微信";
        self.tabBarItem.image = [UIImage imageNamed:@"message"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"message.fill"];
        
        self.view.backgroundColor = WECHAT_BACKGROUND_GREY;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
