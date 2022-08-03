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
@property(nonatomic, strong)NSMutableArray *messageArray;

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
    _single.user = [JMSGUser myInfo];
    self.navigationItem.title = _single.userdata.username;
   // [self createSession];
}


- (void)createSession{
    _single = [DJSingleton sharedManager];
    [JMSGConversation createSingleConversationWithUsername:_single.userdata.username completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"");
        NSString *str = @"dfhgaga";

        JMSGTextContent  *content = [[JMSGTextContent alloc] initWithText:str];
        JMSGMessage *message = [JMSGMessage createSingleMessageWithContent:content username:self->_single.userdata.username];
        [JMSGMessage sendMessage:message];
        NSLog(@"");
    }];
    
    
}


//监听会话改变
- (void)onConversationChanged:(JMSGConversation *)conversation{
    NSLog(@"");
}

//在线监听消息
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error{
    _single = [DJSingleton sharedManager];
    /**获取列表的所有消息*/
    [[JMSGConversation singleConversationWithUsername:_single.userdata.username] allMessages:^(id resultObject, NSError *error) {
        NSLog(@"");
        self->_messageArray = @[].mutableCopy;
        self->_messageArray = (NSMutableArray *)resultObject;
    }];

}

//监听消息发送
- (void)onSendMessageResponse:(JMSGMessage *)message error:(NSError *)error{
    NSLog(@"");
    /**获取列表的所有消息*/
    [[JMSGConversation singleConversationWithUsername:_single.userdata.username] allMessages:^(id resultObject, NSError *error) {
        self->_messageArray = @[].mutableCopy;
        self->_messageArray = (NSMutableArray *)resultObject;
        NSLog(@"");
    }];
}

//监听命令透传事件
- (void)onReceiveMessageTransparentEvent:(JMSGMessageTransparentEvent *)transparentEvent{
    NSLog(@"");
}


//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return _messageArray.count;
    _single = [DJSingleton sharedManager];
    NSLog(@"");
    return _single.messageArray.count;
    
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
        _cell = [[DJChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [_cell LoadChatTableViewCell:_single.messageArray[indexPath.row]];
    
//
//    static NSString *CellIdentifier = @"Cell";
//    self.homecell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//    if (self.homecell == nil) {
//    self.homecell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    [self.homecell HomelayoutTableViewCellWithItem:(GetListItem *)[single.HomeArray objectAtIndex:indexPath.row]];
//    return self.homecell;
    
    
    
    
    return _cell;
}





@end
