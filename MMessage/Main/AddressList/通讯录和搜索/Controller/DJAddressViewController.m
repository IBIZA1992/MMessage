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

@interface DJAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic, strong)DJAddressView *addressView;
@property(nonatomic, strong)DJAddFriendViewController *addfriendVC;
@property(nonatomic, strong)DJSearchViewController *searchVC;
@property(nonatomic, strong)DJBasicTableViewCell *cell;

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
    
    /**搜索*/
    [_addressView.btnsearch addTarget:self action:@selector(search)  forControlEvents:UIControlEventTouchUpInside];
    /**添加好友*/
    [_addressView.navView.btnright addTarget:self action:@selector(addfriend)  forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)addfriend{
    _addfriendVC = [[DJAddFriendViewController alloc] init];
    [self.navigationController pushViewController:_addfriendVC animated:YES];
}

- (void)search{
//    _searchVC = [[DJSearchViewController alloc] init];
//    [self.navigationController pushViewController:_searchVC animated:YES];
    
    JMSGUser *user = [JMSGUser myInfo];

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
        return 5;
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
    if(indexPath.section != 0){
        DJListItem *item = [[DJListItem alloc] init];
        [_cell LoadBasicTableViewCellWithItem:item];
        return _cell;
    
    }
    
    
    
    return nil;
    
    
}



@end
