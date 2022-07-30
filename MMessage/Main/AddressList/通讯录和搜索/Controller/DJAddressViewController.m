//
//  DJAddressViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJAddressViewController.h"
#import "DJAddressView.h"
#import "DJAddFriendViewController.h"
#import "DJSearchViewController.h"
#import "JMessage/JMessage.h"
#import "DJBasicTableViewCell.h"
#import "DJUserData.h"
#import "JMessage/JMessage.h"

@interface DJAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,JMessageDelegate>
@property(nonatomic, strong)DJAddressView *addressView;
@property(nonatomic, strong)DJAddFriendViewController *addfriendVC;
@property(nonatomic, strong)DJSearchViewController *searchVC;
@property(nonatomic, strong)DJBasicTableViewCell *cell;
@property(nonatomic, strong)DJUserData *FriendListData;
@property(nonatomic, strong)NSMutableArray *FriendArray;
@property(nonatomic, strong)JMSGFriendNotificationEvent *FriendEvent;


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
  
    /**代理*/
    _addressView.BasicTableView.delegate = self;
    _addressView.BasicTableView.dataSource = self;
    _addressView.BasicTableView.tableHeaderView = _addressView.btnsearch;
    [JMessage addDelegate:self withConversation:nil];
    _FriendEvent = [[JMSGFriendNotificationEvent alloc] init];

    
    /**搜索*/
    [_addressView.btnsearch addTarget:self action:@selector(search)  forControlEvents:UIControlEventTouchUpInside];
    /**添加好友*/
    [_addressView.navView.btnright addTarget:self action:@selector(addfriend)  forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //加载数据
    [self SetFriendListData];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)addfriend{
    _addfriendVC = [[DJAddFriendViewController alloc] init];
    [self.navigationController pushViewController:_addfriendVC animated:YES];
        
}


/// 加载好友列表数据
- (void)SetFriendListData{
    __weak typeof(self) weakSelf = self;
    _FriendListData = [[DJUserData alloc] init];
    [self.FriendListData LoadFriendData:^(NSArray<DJListItem *> * _Nonnull dataArray) {
        __strong typeof(weakSelf) strongSelf = weakSelf; //防止Block循环引用
        strongSelf.self.FriendArray = (NSMutableArray *)dataArray;
        NSLog(@"");
        [strongSelf.addressView.BasicTableView reloadData];
        
    }];
    
}


//监听好友事件
- (void)onReceiveFriendNotificationEvent:(JMSGFriendNotificationEvent *)event{
    [_FriendEvent getReason];
    [_FriendEvent getFromUser];
    [_FriendEvent getFromUsername];
    NSLog(@"");
}




- (void)search{
//    _searchVC = [[DJSearchViewController alloc] init];
//    [self.navigationController pushViewController:_searchVC animated:YES];
    
    __unused JMSGUser *user = [JMSGUser myInfo];

    [JMSGFriendManager sendInvitationRequestWithUsername:@"11111" appKey:@"a22033c28155ecb6e5dab352" reason:@"123" completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"");
    }];
    
    [JMSGFriendManager acceptInvitationWithUsername:@"12138" appKey:nil completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"");
    }];
    
    [JMSGFriendManager getFriendList:^(id resultObject, NSError *error) {
        NSLog(@"");
    }];
}


//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }
    if(section == 1){
        return 2;
    }
    else
        return _FriendArray.count;
}

//设置组头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return @"星标朋友";
    }
    if(section == 2){
        return @"我的好友";
    }
    else
        return nil;
}

//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (_cell == nil) {
        _cell = [[DJBasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            DJListItem *item = [[DJListItem alloc] init];
            item.username = @"新的朋友";
            NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"newfriend"], 0.6f);
            NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            item.imageStr = encodedImageStr;
            [_cell LoadBasicTableViewCellWithItem:item];
            return _cell;
        }
        
        if(indexPath.row == 1){
            DJListItem *item = [[DJListItem alloc] init];
            item.username = @"群聊";
            NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"group"], 0.6f);
            NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            item.imageStr = encodedImageStr;
            [_cell LoadBasicTableViewCellWithItem:item];
            return _cell;
        }
    }
    if(indexPath.section == 2){
        DJListItem *item = [[DJListItem alloc] init];
        item = _FriendArray[indexPath.row];
        NSLog(@"");
        [_cell LoadBasicTableViewCellWithItem:item];
        return _cell;
    
    }
    
    
    else{
        DJListItem *item = [[DJListItem alloc] init];
        [_cell LoadBasicTableViewCellWithItem:item];
        return _cell;
    }
    
    
    
    return nil;
    
    
}



@end
