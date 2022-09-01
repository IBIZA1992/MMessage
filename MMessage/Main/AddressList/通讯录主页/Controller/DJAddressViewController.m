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
#import "DJNewFriendViewController.h"
#import "DJSingleton.h"
#import "DJUserDataViewController.h"
#import "DJGroupViewController.h"



@interface DJAddressViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate, JMessageDelegate>
@property(nonatomic, strong)DJAddressView *addressView; //通讯录主页View
@property(nonatomic, strong)DJBasicTableViewCell *cell; //自定义cell
@property(nonatomic, strong)DJUserData *FriendListData; //获取朋友信息
@property(nonatomic, strong)NSMutableArray *FriendArray; //朋友列表
//@property(nonatomic, strong)JMSGFriendNotificationEvent *FriendEvent;
@property(nonatomic, strong)DJSingleton *single; //单例类实例化


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
    //添加view
    _addressView = [[DJAddressView alloc] init];
    _addressView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_addressView LoadAddressView];
    [self.view addSubview:_addressView];
  
    //代理
    _addressView.BasicTableView.delegate = self;
    _addressView.BasicTableView.dataSource = self;
    [JMessage addDelegate:self withConversation:nil];
    
    //设置表头为搜索框
    _addressView.BasicTableView.tableHeaderView = _addressView.btnsearch;

    
    //搜索
    [_addressView.btnsearch addTarget:self action:@selector(search)  forControlEvents:UIControlEventTouchUpInside];
    //添加好友
    [_addressView.navView.btnright addTarget:self action:@selector(addfriend)  forControlEvents:UIControlEventTouchUpInside];
    
    
    
}



#pragma mark - View生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //加载数据
    [self SetFriendListData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES; //隐藏navigationBar，自定义bar
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO; //在其他控制器显示NavigationBar
    UINavigationBarAppearance * appearance = [[UINavigationBarAppearance alloc] init];
    appearance.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;
    self.navigationController.navigationBar.standardAppearance = appearance;
}



#pragma mark - Push进入控制器
///进入添加朋友控制器
- (void)addfriend{
    DJAddFriendViewController *addfriendVC = [[DJAddFriendViewController alloc] init];
    [self.navigationController pushViewController:addfriendVC animated:YES];
    [JMSGFriendManager sendInvitationRequestWithUsername:@"11111" appKey:nil reason:@"请求原因" completionHandler:^(id resultObject, NSError *error) {
    }];
}

///进入搜索控制器
- (void)search{
    DJSearchViewController *searchVC = [[DJSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}



#pragma mark - 加载网络数据
/// 加载好友列表数据
- (void)SetFriendListData{
    __weak typeof(self) weakSelf = self;
    _FriendListData = [[DJUserData alloc] init];
    [self.FriendListData LoadFriendData:^(NSArray<DJListItem *> * _Nonnull dataArray) {
        __strong typeof(weakSelf) strongSelf = weakSelf; //防止Block循环引用
        strongSelf.self.FriendArray = (NSMutableArray *)dataArray;
        [strongSelf.addressView.BasicTableView reloadData];
    }];
}




#pragma mark - TableView代理实现
///设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


///设置行数
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


///设置组头
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


///设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


///tabelview内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (_cell == nil) {
        _cell = [[DJBasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //第0组 （新的朋友、群聊）
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
    //第2组（朋友列表）
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


///点击进入tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            //进入新的朋友请求控制器
            DJNewFriendViewController *newfriendVC = [[DJNewFriendViewController alloc] init];
            [self.navigationController pushViewController:newfriendVC animated:YES];
        }
        if(indexPath.row == 1){
            //进入群组列表控制器
            DJGroupViewController *groupVC = [[DJGroupViewController alloc] init];
            [self.navigationController pushViewController:groupVC animated:YES];
        }
    }
    if(indexPath.section == 2){
        _single = [DJSingleton sharedManager];
        _single.userdata = _FriendArray[indexPath.row];
        //进入用户个人具体信息
        DJUserDataViewController *userdataVC = [[DJUserDataViewController alloc] init];
        [self.navigationController pushViewController:userdataVC animated:YES];
    }    
}






@end
