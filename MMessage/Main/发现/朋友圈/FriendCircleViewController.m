//
//  FriendCircleViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/9/7.
//

#import "FriendCircleViewController.h"
#import "MMScreen.h"
#import "SendFriendViewController.h"
#import "JMessage/JMessage.h"
#import "FriendTableViewCell.h"

@interface FriendCircleViewController () <JMessageDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *friendMessageArr;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) FriendTableViewCell *cell;

@end

@implementation FriendCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    backImage.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:backImage];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage*image = [UIImage imageNamed:@"setmore"];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendFriendCircle) forControlEvents:UIControlEventTouchUpInside];
    [button.widthAnchor constraintEqualToConstant:30].active =YES;
    [button.heightAnchor constraintEqualToConstant:30].active =YES;
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    [JMessage addDelegate:self withConversation:nil];
    
    _tableView = [[UITableView alloc] init];
    [_tableView setFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-200)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
   
  
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(reLoad)
                                              name:@"reloadData"
                                            object:nil];
   
    
    //接收消息
    //分析数据分组朋友圈信息类型
    [JMSGConversation createGroupConversationWithGroupId:[[JMSGUser myInfo].extras objectForKey:@"朋友圈"]completionHandler:^(id resultObject, NSError *error) {
        self.friendMessageArr = @[].mutableCopy;
        [resultObject allMessages:^(id resultObject, NSError *error) {
            NSMutableArray *arr = @[].mutableCopy;
            for(JMSGMessage *info in resultObject){
                [arr addObject:info];
            }
            [arr removeLastObject];

            NSInteger count = arr.count;
            for(int i=0; i<count; i++) {
             
                if(i != 0) {
                    JMSGMessage *mess1 = arr[i-1];
                    JMSGMessage *mess2 = arr[i];
                    if([mess1.fromUser.username isEqual:mess2.fromUser.username]) {
                        if(([mess1.timestamp intValue] - [mess2.timestamp intValue])/1000 < 10 &&(mess2.contentType != kJMSGContentTypeText)) {
                            //字典里面存两个元素
                            NSMutableArray *arrM = @[].mutableCopy;
                            arrM = [self.friendMessageArr lastObject];
                            [arrM addObject:mess2];
                            [self.friendMessageArr removeLastObject];
                            [self.friendMessageArr addObject:arrM];
                        }
                        else {
                            NSMutableArray *arrM = @[].mutableCopy;
                            [arrM addObject:arr[i]];
                            [self.friendMessageArr addObject:arrM];
                        }
                    }
                    else {
                        NSMutableArray *arrM = @[].mutableCopy;
                        [arrM addObject:arr[i]];
                        [self.friendMessageArr addObject:arrM];
                    }
                }
                else {
                    NSMutableArray *arrM = @[].mutableCopy;
                    [arrM addObject:arr[i]];
                    [self.friendMessageArr addObject:arrM];
                }
            }
            
            [self.tableView reloadData];
        }];
    }];
 

}

- (void)reLoad{
    //[_tableView reloadData];
}



- (void)sendFriendCircle {
    SendFriendViewController *sendVC = [[SendFriendViewController alloc] init];
    [self.navigationController pushViewController:sendVC animated:YES];
}

///监听接收消息
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error{
    NSLog(@"");
}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _friendMessageArr.count;
}



///设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [[FriendTableViewCell alloc] init];
    [_cell loadFriendCell:_friendMessageArr[indexPath.row]];
    return _cell.cell_Height;
}


///设置内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [[FriendTableViewCell alloc] init];
    [_cell loadFriendCell:_friendMessageArr[indexPath.row]];
    return _cell;
}




@end
