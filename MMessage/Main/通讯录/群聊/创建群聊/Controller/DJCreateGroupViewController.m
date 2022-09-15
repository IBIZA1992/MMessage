//
//  DJCreateGroupViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import "DJCreateGroupViewController.h"
#import "DJCreateGroupBarView.h"
#import "DJUserData.h"
#import "DJCreateGroupTableViewCell.h"
#import "JMessage/JMessage.h"

@interface DJCreateGroupViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) DJCreateGroupBarView *barView;
@property(nonatomic, strong) UITableView *tableview;
@property(nonatomic, strong) DJUserData *FriendListData;
@property(nonatomic, strong) NSMutableArray *FriendArray;
@property(nonatomic, strong) DJCreateGroupTableViewCell *cell;
@property(nonatomic, strong) NSMutableArray *groupUserArray;


@end

@implementation DJCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;
    /**控制器View*/
    _tableview = [[UITableView alloc] init];
    [_tableview setFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-55-STATUS_NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:_tableview];
    
    /**底部栏View*/
    _barView = [[DJCreateGroupBarView alloc] init];
    [_barView setFrame:CGRectMake(0, SCREEN_HEIGHT-55, SCREEN_WIDTH, 55)];
    [_barView LoadGroupBarView];
    [self.view addSubview:_barView];

    /**设置导航栏标题颜色*/
    self.navigationItem.title = @"创建群聊";
    self.navigationController.navigationBar.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;
    
    /**代理*/
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    /**通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add:) name:@"add" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancel:) name:@"cancel" object:nil];
    
    [_barView.btncreate addTarget:self action:@selector(creatgroup) forControlEvents:UIControlEventTouchUpInside];

}

- (void)creatgroup {
    JMSGGroupInfo *groupinfo = [[JMSGGroupInfo alloc] init];
    JMSGUser *uesr = [JMSGUser myInfo];
    groupinfo.name = [uesr.username stringByAppendingString:@"的群组"];
    groupinfo.groupType = kJMSGGroupTypePublic;
   
    [JMSGGroup createGroupWithGroupInfo:groupinfo memberArray:_groupUserArray completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"");
    }];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)add:(NSNotification *)info {
    NSString *username = [info.userInfo objectForKey:@"username"];
    [_groupUserArray addObject:username];
    NSString *string = [[@"(" stringByAppendingString:[NSString stringWithFormat: @"%lu", (unsigned long)_groupUserArray.count]] stringByAppendingString:@")"];
    _barView.label.text = string;
    if(_groupUserArray.count == 0) {
        [_barView.btncreate setEnabled:NO];
        [_barView.btncreate setTitle:@"创建" forState:UIControlStateDisabled];

    }
    else{
        [_barView.btncreate setEnabled:YES];
        [_barView.btncreate setTitle:@"创建" forState:UIControlStateNormal];
    }
}

- (void)cancel:(NSNotification *)info {
    NSString *username = [info.userInfo objectForKey:@"username"];
    [_groupUserArray removeObject:username];
    NSString *string = [[@"(" stringByAppendingString:[NSString stringWithFormat: @"%lu", (unsigned long)_groupUserArray.count]] stringByAppendingString:@")"];
    _barView.label.text = string;
    if(_groupUserArray.count == 0) {
        [_barView.btncreate setEnabled:NO];
        [_barView.btncreate setTitle:@"创建" forState:UIControlStateDisabled];

    }
    else{
        [_barView.btncreate setEnabled:YES];
        [_barView.btncreate setTitle:@"创建" forState:UIControlStateNormal];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self SetFriendListData];
    _groupUserArray = @[].mutableCopy;
}



/// 加载好友列表数据
- (void)SetFriendListData {
    __weak typeof(self) weakSelf = self;
    _FriendListData = [[DJUserData alloc] init];
    [self.FriendListData LoadFriendData:^(NSArray<DJListItem *> * _Nonnull dataArray) {
        __strong typeof(weakSelf) strongSelf = weakSelf; //防止Block循环引用
        strongSelf.self.FriendArray = (NSMutableArray *)dataArray;
        [strongSelf.tableview reloadData];
    }];
    
}


//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _FriendArray.count;
}

//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

//tabelview内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [[DJCreateGroupTableViewCell alloc] init];
    DJListItem *item = [[DJListItem alloc] init];
    item = _FriendArray[indexPath.row];
    [_cell LoadCreateGroupTableViewCellWithItem:item];
    return _cell;
    
}







@end
