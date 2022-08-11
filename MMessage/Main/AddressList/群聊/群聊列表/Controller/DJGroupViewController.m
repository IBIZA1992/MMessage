//
//  DJGroupViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import "DJGroupViewController.h"
#import "DJGroupView.h"
#import "MMScreen.h"
#import "DJGrouplistTableViewCell.h"
#import "DJChatViewController.h"
#import "JMessage/JMessage.h"
#import "DJSingleton.h"

@interface DJGroupViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic, strong)DJGroupView *groupView;
@property(nonatomic, strong)DJGrouplistTableViewCell *cell;
@property(nonatomic, strong)NSMutableArray *GroupListIDArray;
@property(nonatomic, strong)DJChatViewController *chatVC;
@property(nonatomic, strong)DJSingleton *single;

@end

@implementation DJGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _groupView = [[DJGroupView alloc] init];
    [_groupView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_groupView LoadGroupView];
    [self.view addSubview:_groupView];
    
    
    /**代理*/
    _groupView.tableView.delegate = self;
    _groupView.tableView.dataSource = self;
    _groupView.tableView.tableHeaderView = _groupView.btnsearch;
    
    self.navigationItem.title = @"群聊";

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _GroupListIDArray = @[].mutableCopy;
    [self LoadGroupListData];
}

///加载群聊列表数据
- (void)LoadGroupListData{
    [JMSGGroup myGroupArray:^(id resultObject, NSError *error) {
        self->_GroupListIDArray = (NSMutableArray *)resultObject;
        [self->_groupView.tableView reloadData];
    }];
}




//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _GroupListIDArray.count;
}

//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

//设置内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _cell = [[DJGrouplistTableViewCell alloc] init];
    
    [_cell LoadGroupListTableViewCellWithItem:_GroupListIDArray[indexPath.row]];

    return _cell;
}

//点击进入tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _single = [DJSingleton sharedManager];
    _single.messageType = 2;
    NSString *str = [[[NSNumberFormatter alloc] init] stringFromNumber:_GroupListIDArray[indexPath.row]];
    _single.groupID = str; /**获取群聊id传入单例*/
    [JMSGConversation createGroupConversationWithGroupId:str completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"");
        [resultObject allMessages:^(id resultObject, NSError *error) {
            NSLog(@"");
            self->_single.messageArray = @[].mutableCopy;
            self->_single.messageArray = (NSMutableArray *)resultObject;
            self->_chatVC = [[DJChatViewController alloc] init];
            [self.navigationController pushViewController:self->_chatVC animated:YES];

        }];
        
    }];
    
    
    
}













@end
