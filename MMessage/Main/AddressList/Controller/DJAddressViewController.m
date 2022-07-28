//
//  DJAddressViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJAddressViewController.h"
#import "DJAddressView.h"

@interface DJAddressViewController ()
@property(nonatomic, strong)DJAddressView *addressView;

@end

@implementation DJAddressViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"通讯录";
        self.tabBarItem.image = [UIImage imageNamed:@"addressbook"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"addressbook.fill"];
        
        self.view.backgroundColor = WECHAT_BACKGROUND_GREY;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _addressView = [[DJAddressView alloc] init];
    _addressView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_addressView LoadAddressView];
    [self.view addSubview:_addressView];
    
}



@end
