//
//  DJNewFriendViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/1.
//

#import "DJNewFriendViewController.h"
#import "DJNewFriendView.h"
#import "MMScreen.h"
#import "JMessage/JMessage.h"
#import "DJSingleton.h"
#import "DJBasicTableViewCell.h"
#import "DJUserDataViewController.h"
#import "DJListItem.h"


@interface DJNewFriendViewController ()<UITableViewDelegate,UITableViewDataSource,JMessageDelegate>
@property(nonatomic, strong)DJNewFriendView *newfriendView;
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)DJBasicTableViewCell *cell;
@property(nonatomic, strong)DJUserDataViewController *userdataVC;
@property(nonatomic, strong)NSMutableArray *array;
@property(nonatomic, strong)DJListItem *list;

@end

@implementation DJNewFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _newfriendView = [[DJNewFriendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_newfriendView LoadNewFriendView];
    [self.view addSubview:_newfriendView];
    
    [JMessage addDelegate:self withConversation:nil];

    _newfriendView.tableview.delegate = self;
    _newfriendView.tableview.dataSource = self;
    
    
    
    
    
    

}

//监听好友事件
- (void)onReceiveFriendNotificationEvent:(JMSGFriendNotificationEvent *)event{
    NSString *str1 = [event getReason];
    JMSGUser *user = [event getFromUser];
    NSString *str3 = [event getFromUsername];
    _single = [DJSingleton sharedManager];
    //[_single.addrequestArray addObject:user];
    [_list LoadUserDataModel:user];
    [_single.addrequestArray insertObject:_list atIndex:0];
   // _single.addrequestArray = _array.mutableCopy;

    NSLog(@"");
}


//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _single = [DJSingleton sharedManager];
    return _single.addrequestArray.count;
}

//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (_cell == nil) {
        _cell = [[DJBasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    DJListItem *item = [[DJListItem alloc] init];
    item = _single.addrequestArray[indexPath.row];
    NSLog(@"");
    [_cell LoadBasicTableViewCellWithItem:item];
    return _cell;
    
}

//点击进入tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   

        _single = [DJSingleton sharedManager];
        _single.userdata = _single.addrequestArray[indexPath.row];
        _userdataVC = [[DJUserDataViewController alloc] init];
        [self.navigationController pushViewController:_userdataVC animated:YES];
    
}



@end
