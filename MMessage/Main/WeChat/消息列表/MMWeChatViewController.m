//
//  MMWeChatViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/7/28.
//

#import "MMColor.h"
#import "MMWeChatViewController.h"
#import "MMScreen.h"
#import "DJSingleton.h"
#import "DJWeChatTableViewCell.h"
#import "DJChatViewController.h"


@interface MMWeChatViewController ()<UITableViewDelegate, UITableViewDataSource, JMessageDelegate>
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)DJWeChatTableViewCell *cell;
@property(nonatomic, strong)DJChatViewController *chatVC;

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

    _tableview = [[UITableView alloc] init];
    [_tableview setFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAVIGATION_BAR_HEIGHT - SAFEDISTANCE_TABBAR_HEIGHT)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadchat)
                                                 name:@"chat"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _single = [DJSingleton sharedManager];

    NSLog(@"");
}


- (void)reloadchat{
    [_tableview reloadData];
}


//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _single = [DJSingleton sharedManager];
    return _single.messagelistArray.count;
    
}


//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


//设置内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _single = [DJSingleton sharedManager];
    static NSString *CellIdentifier = @"Cell";
    _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (_cell == nil) {
        _cell = [[DJWeChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    /**倒叙排列*/
    [_cell Loadwechattableviewcell:_single.messagelistArray[indexPath.row]];
    return _cell;
}


//进入会话
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _single = [DJSingleton sharedManager];
    /**获取列表的所有消息*/
    [[JMSGConversation singleConversationWithUsername:_single.messagelistArray[indexPath.row]] allMessages:^(id resultObject, NSError *error) {
        self->_single.messageArray = @[].mutableCopy;
        self->_single.messageArray = (NSMutableArray *)resultObject;
        NSArray *array=[[NSArray alloc] initWithObjects:self->_single.messagelistArray[indexPath.row],nil];
        [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
            self->_single.userdata = resultObject[0];
            /**设置聊天类型为单聊*/
            self.single.messageType = 1;
            self->_chatVC = [[DJChatViewController alloc] init];
            [self.navigationController pushViewController:self->_chatVC animated:YES];
        }];
    }];
}


@end
