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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    JMSGUser *myUser = [JMSGUser myInfo];
    NSDictionary *dic = myUser.extras;

    if(![dic objectForKey:@"朋友圈"]) {
        JMSGGroupInfo *groupinfo = [[JMSGGroupInfo alloc] init];
        groupinfo.name = [myUser.username stringByAppendingString:@"的朋友圈"];
        groupinfo.groupType = kJMSGGroupTypePublic;

        [JMSGGroup createGroupWithGroupInfo:groupinfo memberArray:nil completionHandler:^(id resultObject, NSError *error) {
            JMSGGroup *group = resultObject;
            NSString *groupID = group.gid;
            NSDictionary *dic = [NSDictionary dictionaryWithObject:groupID forKey:@"朋友圈"];
            JMSGUserInfo *info = [[JMSGUserInfo alloc] init];
            info.extras = dic;
            [JMSGUser updateMyInfoWithUserInfo:info completionHandler:^(id resultObject, NSError *error) {

            }];
        }];
    }

    [JMSGGroup groupInfoWithGroupId:[[JMSGUser myInfo].extras objectForKey:@"朋友圈"] completionHandler:^(id resultObject, NSError *error) {
        JMSGGroup *group = resultObject;
        
        [JMSGFriendManager getFriendList:^(id resultObject, NSError *error) {
            NSMutableArray *listItemArray = @[].mutableCopy;
            NSArray *dataArray = resultObject;
            for(JMSGUser *info in dataArray){
                [listItemArray addObject:info.username];
            }
            [group addMembersWithUsernameArray:listItemArray completionHandler:^(id resultObject, NSError *error) {
                NSLog(@"");
            }];
        }];
    }];

}


- (void)reloadchat {
    [_tableview reloadData];
}


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
    /**获取列表的所有消息*/
    [[JMSGConversation singleConversationWithUsername:_single.messagelistArray[indexPath.row]] allMessages:^(id resultObject, NSError *error) {
        self.single.messageArray = @[].mutableCopy;
        self.single.messageArray = (NSMutableArray *)resultObject;
        NSArray *array = [[NSArray alloc] initWithObjects:self.single.messagelistArray[indexPath.row],nil];
        [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
            self.single.userdata = resultObject[0];
            /**设置聊天类型为单聊*/
            self.single.messageType = 1;
            self.chatVC = [[DJChatViewController alloc] init];
            [self.navigationController pushViewController:self.chatVC animated:YES];
        }];
    }];
}


@end
