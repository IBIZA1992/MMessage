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

@interface FriendCircleViewController () <JMessageDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation FriendCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    backImage.image = [UIImage imageNamed:@"newfriend"];
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
    
    //接收消息
    //分析数据分组朋友圈信息类型
    [JMSGConversation createGroupConversationWithGroupId:[[JMSGUser myInfo].extras objectForKey:@"朋友圈"]completionHandler:^(id resultObject, NSError *error) {
        NSMutableArray *friendMessageArr = @[].mutableCopy;
        [resultObject allMessages:^(id resultObject, NSError *error) {
            NSMutableArray *arr = @[].mutableCopy;
            for(JMSGMessage *info in resultObject){
                [arr addObject:info];
            }

            NSInteger count = arr.count;
            for(int i=0; i<count; i++) {
             
                if(i != 0) {
                    JMSGMessage *mess1 = arr[i-1];
                    JMSGMessage *mess2 = arr[i];
                    if([mess1.fromUser.username isEqual:mess2.fromUser.username]) {
                        if(([mess1.timestamp intValue] - [mess2.timestamp intValue])/1000 < 10) {
                            //字典里面存两个元素
                            NSMutableArray *arrM = @[].mutableCopy;
                            arrM = [friendMessageArr lastObject];
                            [arrM addObject:mess2];
                            [friendMessageArr removeLastObject];
                            [friendMessageArr addObject:arrM];
                        }
                        else {
                            NSMutableArray *arrM = @[].mutableCopy;
                            [arrM addObject:arr[i]];
                            [friendMessageArr addObject:arrM];
                        }
                    }
                    else {
                        NSMutableArray *arrM = @[].mutableCopy;
                        [arrM addObject:arr[i]];
                        [friendMessageArr addObject:arrM];
                    }
                }
                else {
                    NSMutableArray *arrM = @[].mutableCopy;
                    [arrM addObject:arr[i]];
                    [friendMessageArr addObject:arrM];
                }
            }
            
            NSLog(@"");
            
        }];
    }];
 

}

//+ (void)allConversations:(JMSGCompletionHandler)handler;

- (void)sendFriendCircle {
    SendFriendViewController *sendVC = [[SendFriendViewController alloc] init];
    [self.navigationController pushViewController:sendVC animated:YES];
}

///监听接收消息
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error{
    NSLog(@"");
}




/*!
 * @abstract 发送群聊文本消息
 *
 * @param text 文本内容
 * @param groupId 群聊目标群组ID
 *
 * @discussion 快捷方法，不需要先创建消息而直接发送。
 */
//+ (void)sendGroupTextMessage:(NSString *)text toGroup:(NSString *)groupId;
//获取全部群组，如果是朋友圈群组就发送消息

@end
