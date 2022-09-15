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
#import "JMessage/JMessage.h"

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



- (void)viewWillAppear:(BOOL)animated{
    
//    [JMSGGroup myGroupArray:^(id resultObject, NSError *error) {
//        NSMutableArray * groupArr = @[].mutableCopy;
//        groupArr = resultObject;
//        for(NSNumber *info in groupArr) {
//            [JMSGGroup dissolveGroupWithGid:info.description handler:^(id resultObject, NSError *error) {
//                NSLog(@"");
//            }];
//
//        }
//        JMSGUserInfo *info = [[JMSGUserInfo alloc] init];
//        NSDictionary *dic = [[NSDictionary alloc] init];
//        info.extras = dic;
//        JMSGUser *a = [JMSGUser myInfo];
//        NSLog(@"");
//        [JMSGUser updateMyInfoWithUserInfo:info completionHandler:^(id resultObject, NSError *error) {
//            JMSGUser *a = [JMSGUser myInfo];
//            NSLog(@"");
//        }];
//    }];
    
    
    
    
    

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
                NSLog(@"");
            }];

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
