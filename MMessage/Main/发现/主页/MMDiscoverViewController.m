//
//  MMDiscoverViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/7/28.
//

#import "MMColor.h"
#import "MMDiscoverViewController.h"
#import "FriendCircleViewController.h"
#import "MMScreen.h"

@interface MMDiscoverViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation MMDiscoverViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"发现";
        self.tabBarItem.image = [UIImage imageNamed:@"discover"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"discover.fill"];
        
        self.view.backgroundColor = WECHAT_BACKGROUND_GREY;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init]; 
    [_tableView setFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAVIGATION_BAR_HEIGHT - SAFEDISTANCE_TABBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}


///设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}



///设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


///设置内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"朋友圈";
    return cell;
}


///进入cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        FriendCircleViewController *friendCircleVC = [[FriendCircleViewController alloc] init];
        [self.navigationController pushViewController:friendCircleVC animated:YES];
    }
  
}






@end
