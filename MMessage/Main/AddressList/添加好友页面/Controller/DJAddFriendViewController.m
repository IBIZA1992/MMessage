//
//  DJAddFriendViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJAddFriendViewController.h"
#import "DJAddFriendView.h"

@interface DJAddFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic, strong)DJAddFriendView *addView;

@end

@implementation DJAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _addView = [[DJAddFriendView alloc] init];
    _addView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_addView LoadAddFriendView];
    [self.view addSubview:_addView];
    
//    /**代理*/
//    _addView.tableView.delegate = self;
//    _addView.tableView.dataSource = self;
//    _addView.tableView.tableHeaderView = _addView.btnsearch;
    
    /**搜索*/
    [_addView.btnsearch addTarget:self action:@selector(search)  forControlEvents:UIControlEventTouchUpInside];
    /**添加好友*/
    [_addView.navView.btnright addTarget:self action:@selector(back)  forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)search{
    
}

- (void)back{
    
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}



@end
