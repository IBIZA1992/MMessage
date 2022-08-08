//
//  DJUserDataViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/1.
//

#import "DJUserDataViewController.h"
#import "DJSingleton.h"
#import "DJUserdataView.h"
#import "MMScreen.h"
#import "JMessage/JMessage.h"
#import "DJListItem.h"
#import "MMColor.h"
#import "MMScreen.h"
#import "DJSetUserDataViewController.h"
#import "DJChatViewController.h"
#import "RemarkViewController.h"
#import "FriendLimitViewController.h"
#import "MoremessageViewController.h"


@interface DJUserDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)DJUserdataView *userdataView;
@property(nonatomic, strong)DJListItem *list;
@property(nonatomic, strong)DJSetUserDataViewController *setuserdataVC;
@property(nonatomic, strong)DJChatViewController *chatVC;
@property(nonatomic, strong)FriendLimitViewController *friendlimitVC;
@property(nonatomic, strong)RemarkViewController *remarkVC;
@property(nonatomic, strong)MoremessageViewController *moreVC;

@end

@implementation DJUserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WECHAT_GREEN;
    _userdataView = [[DJUserdataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_userdataView LoadUserdataView];
    [self.view addSubview:_userdataView];
    
    _userdataView.tableview.delegate = self;
    _userdataView.tableview.dataSource = self;

    


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, STATUS_NAVIGATION_BAR_HEIGHT-30, 20, 20)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setBackgroundImage:[UIImage imageNamed:@"setmore"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setmore) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    
}

- (void)setmore{
    _setuserdataVC = [[DJSetUserDataViewController alloc] init];
    [self.navigationController pushViewController:_setuserdataVC animated:YES];
}


//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//设置组头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"第一组";
    }
    if(section == 1){
        return @"第二组";
    }
    if(section == 2){
        return @"第三组";
    }
    else
        return nil;
}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _single = [DJSingleton sharedManager];
    if(section == 0){
        return 3;
    }
    if(section == 1){
        return 2;
    }
    if(section == 2){
        if(_single.userdata.isFriend == NO){
            return 3;
        }
        else
            return 2;
    }
    if(section == 3){
        return 1;
    }
    else
        return 0;
}

//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell.textLabel.text = @"用户头像等信息";
            return cell;
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"备注和标签";
            return cell;
        }
        if(indexPath.row == 2){
            cell.textLabel.text = @"朋友权限";
            return cell;
        }
    }
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            cell.textLabel.text = @"朋友圈";
            return cell;
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"更多信息";
            return cell;
        }
    }
    if(indexPath.section == 2){
        if(indexPath.row == 0){
            cell.textLabel.text = @"发信息";
            return cell;
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"音视频通话";
            return cell;
        }
        if(indexPath.row == 2){
            cell.textLabel.text =@"添加好友";
            return cell;
        }
    }
    if(indexPath.section == 3){
        cell.textLabel.text = @"同意申请";
    }
    
    
    else
        cell.textLabel.text = @"1";
    return cell;


    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _single = [DJSingleton sharedManager];
    
    if(indexPath.section == 3){
        if(indexPath.row == 0){
            _list = [[DJListItem alloc] init];
            _list = _single.userdata;
            [JMSGFriendManager acceptInvitationWithUsername:_single.userdata.username appKey:nil completionHandler:^(id resultObject, NSError *error) {
                NSLog(@"");
            }];
        }
    }
    
    if(indexPath.section == 2){
        if(indexPath.row == 2){
            _list = [[DJListItem alloc] init];
            _list = _single.userdata;
            [JMSGFriendManager sendInvitationRequestWithUsername:_single.userdata.username appKey:nil reason:@"添加好友" completionHandler:^(id resultObject, NSError *error) {
                if(error == nil){
                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"好友申请已经发送" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *tishi=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                        
                    }];
                    [alert addAction:tishi];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }];
        }
        
        if(indexPath.row == 0){
            _single = [DJSingleton sharedManager];
            /**获取列表的所有消息*/
            [JMSGConversation createSingleConversationWithUsername:_single.userdata.username completionHandler:^(id resultObject, NSError *error) {
                [resultObject allMessages:^(id resultObject, NSError *error) {
                    NSLog(@"");
                    self->_single.messageArray = @[].mutableCopy;
                    self->_single.messageArray = (NSMutableArray *)resultObject;
                    self->_chatVC = [[DJChatViewController alloc] init];
                    [self.navigationController pushViewController:self->_chatVC animated:YES];
                }];
            }];
        }
    }
    
    
    if(indexPath.section == 0){
        if(indexPath.row == 1){
            
            _remarkVC = [[RemarkViewController alloc] init];
            [self.navigationController pushViewController:_remarkVC animated:YES];
            
            /**
             
             备注与标签
             
             */
       
        }
        if(indexPath.row == 2){
            
            _friendlimitVC = [[FriendLimitViewController alloc] init];
            [self.navigationController pushViewController:_friendlimitVC animated:YES];
            
            /**
             朋友权限
             */
            
        }
    }

    if(indexPath.section == 1){
        if(indexPath.row == 1){
            /**
             更多信息
             */
            _moreVC = [[MoremessageViewController alloc] init];
            [self.navigationController pushViewController:_moreVC animated:YES];
        }
    }
    
    
    
}

@end
