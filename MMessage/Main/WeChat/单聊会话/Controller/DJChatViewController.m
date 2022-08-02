//
//  DJChatViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import "DJChatViewController.h"
#import "DJChatView.h"
#import "DJSingleton.h"
#import "DJChatTableViewCell.h"
#import "JMessage/JMessage.h"


@interface DJChatViewController ()<UITableViewDelegate, UITableViewDataSource, JMessageDelegate>
@property(nonatomic, strong)DJChatView *chatView;
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)DJChatTableViewCell *cell;

@end

@implementation DJChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _chatView = [[DJChatView alloc] init];
    [_chatView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_chatView LoadChatView];
    [self.view addSubview:_chatView];
    
    _chatView.tableview.delegate = self;
    _chatView.tableview.dataSource = self;
    [JMessage addDelegate:self withConversation:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    _single = [DJSingleton sharedManager];
    self.navigationItem.title = _single.userdata.username;
    [self createSession];
}


- (void)createSession{
    _single = [DJSingleton sharedManager];
    [JMSGConversation createSingleConversationWithUsername:_single.userdata.username completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"");
        NSString *str = @"dfhgaga";

        JMSGTextContent  *content = [[JMSGTextContent alloc] initWithText:str];
        JMSGMessage *message = [JMSGMessage createSingleMessageWithContent:content username:self->_single.userdata.username];
        [JMSGMessage sendMessage:message];
    }];
    
    [[JMSGConversation singleConversationWithUsername:_single.userdata.username] allMessages:^(id resultObject, NSError *error) {
        NSLog(@"");
    }];
    
}

- (void)onSyncOfflineMessageConversation:(JMSGConversation *)conversation
                         offlineMessages:(NSArray JMSG_GENERIC(__kindof JMSGMessage *)*)offlineMessages{
    NSLog(@"");
    
}
- (void)onConversationChanged:(JMSGConversation *)conversation{
    NSLog(@"");
}


- (void)onSendMessageResponse:(JMSGMessage *)message error:(NSError *)error{
    NSLog(@"");
}


//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}



//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


//设置内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (_cell == nil) {
        _cell = [[DJChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    
    return _cell;
}





@end
