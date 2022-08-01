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


@interface DJUserDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)DJUserdataView *userdataView;
@property(nonatomic, strong)DJListItem *list;

@end

@implementation DJUserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _userdataView = [[DJUserdataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_userdataView LoadUserdataView];
    [self.view addSubview:_userdataView];
    
    _userdataView.tableview.delegate = self;
    _userdataView.tableview.dataSource = self;
    

    _single = [DJSingleton sharedManager];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }
    if(section == 1){
        return 2;
    }
    if(section == 2){
        return 3;
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
    
    if(indexPath.section == 2){
        if(indexPath.row == 0){
            cell.textLabel.text =@"添加好友";
        }
        if(indexPath.row == 1){
            cell.textLabel.text=@"删除好友";
        }
        if(indexPath.row == 2){
            cell.textLabel.text=@"同意申请";
        }
    }
    else{
    cell.textLabel.text=@"123";
    cell.detailTextLabel.text=@"123";
    cell.imageView.image=[UIImage imageNamed:@"1"];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _single = [DJSingleton sharedManager];
    
    if(indexPath.section == 2){
        if(indexPath.row == 1){
            _list = [[DJListItem alloc] init];
            _list = _single.userdata;
            [JMSGFriendManager removeFriendWithUsername:_single.userdata.username appKey:nil completionHandler:^(id resultObject, NSError *error) {
                NSLog(@"");
            }];
        }
        if(indexPath.row == 0){
            _list = [[DJListItem alloc] init];
            _list = _single.userdata;
            [JMSGFriendManager sendInvitationRequestWithUsername:_single.userdata.username appKey:nil reason:@"添加好友" completionHandler:^(id resultObject, NSError *error) {
                NSLog(@"");
            }];
        }
        if(indexPath.row == 2){
            _list = [[DJListItem alloc] init];
            _list = _single.userdata;
            [JMSGFriendManager acceptInvitationWithUsername:_single.userdata.username appKey:nil completionHandler:^(id resultObject, NSError *error) {
                NSLog(@"");
            }];
        }
    }
    
}

@end
