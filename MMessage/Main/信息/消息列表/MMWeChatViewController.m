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
#import "JMessage/JMessage.h"


@interface MMWeChatViewController () <UITableViewDelegate, UITableViewDataSource, JMessageDelegate>
@property(nonatomic, strong) UITableView *tableview;
@property(nonatomic, strong) DJSingleton *single;
@property(nonatomic, strong) DJWeChatTableViewCell *cell;
@property(nonatomic, strong) DJChatViewController *chatVC;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadchat) name:@"chat"  object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [JMessage addDelegate:self withConversation:nil];

}

- (void)onSyncOfflineMessageConversation:(JMSGConversation *)conversation offlineMessages:(NSArray JMSG_GENERIC(__kindof JMSGMessage *)*)offlineMessages {
    _single = [DJSingleton sharedManager];
    if(conversation.conversationType == kJMSGConversationTypeSingle) {
        JMSGUser *user = conversation.target;
        if([self.single.messagelistArray containsObject:user.username]) {
            [self.single.messagelistArray removeObject:user.username];
            [self.single.messagelistArray addObject:user.username];
        }
        else {
            [self.single.messagelistArray addObject:user.username];
        }
    }
    if(conversation.conversationType == kJMSGConversationTypeGroup) {
        JMSGGroup *group = conversation.target;
        if([self.single.messagelistArray containsObject:group.gid]) {
            [self.single.messagelistArray removeObject:group.gid];
            [self.single.messagelistArray addObject:group.gid];
        }
        else {
            [self.single.messagelistArray addObject:group.gid];
        }
    }
  
    [self.tableview reloadData];
    
    
}




- (void)reloadchat {
    [_tableview reloadData];
}



#pragma mark - TableView代理

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _single = [DJSingleton sharedManager];
    return _single.messagelistArray.count;
    
}


//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


//设置内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _single = [DJSingleton sharedManager];
    NSArray *array = [[NSArray alloc] initWithObjects:self.single.messagelistArray[indexPath.row],nil];
    [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
        //为单聊消息
        if(!error){
            JMSGUser *uesr = resultObject[0];
            [[JMSGConversation singleConversationWithUsername:self.single.messagelistArray[indexPath.row]] allMessages:^(id resultObject, NSError *error) {
                self.single.messageArray = @[].mutableCopy;
                self.single.messageArray = (NSMutableArray *)resultObject;
                self.single.userdata = (DJListItem *)uesr;
                self.single.messageType = 1;
                self.chatVC = [[DJChatViewController alloc] init];
                [self.navigationController pushViewController:self.chatVC animated:YES];
            }];
        }
        //群聊消息
        else {
            [[JMSGConversation groupConversationWithGroupId:self.single.messagelistArray[indexPath.row]] allMessages:^(id resultObject, NSError *error) {
                self.single.messageArray = @[].mutableCopy;
                self.single.messageArray = (NSMutableArray *)resultObject;
                self.single.groupID = self.single.messagelistArray[indexPath.row];
                self.single.messageType = 2;
                self.chatVC = [[DJChatViewController alloc] init];
                [self.navigationController pushViewController:self.chatVC animated:YES];
            }];
        }
        
        
    }];
}


@end
