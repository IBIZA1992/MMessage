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
#import "DJAddressNavigationView.h"

@interface DJAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic, strong)DJAddressView *addressView;
@property(nonatomic, strong)DJAddFriendViewController *addfriendVC;
@property(nonatomic, strong)DJSearchViewController *searchVC;
@property(nonatomic, strong)DJAddressNavigationView *navView;


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
    [_navView LoadNavigationView];
  
    /**代理*/
    _addressView.BasicTableView.delegate = self;
    _addressView.BasicTableView.dataSource = self;
    _addressView.BasicTableView.tableHeaderView = _addressView.btnsearch;
    
    /**搜索*/
    [_addressView.btnsearch addTarget:self action:@selector(search)  forControlEvents:UIControlEventTouchUpInside];
    /**添加好友*/
    [_navView.btnAddFriend addTarget:self action:@selector(addfriend)  forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addfriend{
    _addfriendVC = [[DJAddFriendViewController alloc] init];
    [self.navigationController pushViewController:_addfriendVC animated:YES];
}

- (void)search{
    _searchVC = [[DJSearchViewController alloc] init];
    [self.navigationController pushViewController:_searchVC animated:YES];
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
    
    
    
    
    return 50;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
  
        cell.textLabel.text=@"夏天的风";
        cell.detailTextLabel.text=@"火羊瞌睡了";
        cell.imageView.image=[UIImage imageNamed:@"1"];
    return cell;
}



@end
