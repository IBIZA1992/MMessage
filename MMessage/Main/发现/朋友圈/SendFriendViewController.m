//
//  SendFriendViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/9/7.
//

#import "SendFriendViewController.h"
#import "SendFriendView.h"
#import "JMessage/JMessage.h"

@interface SendFriendViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, JMessageDelegate, JMSGConversationDelegate>
@property(nonatomic, strong) SendFriendView *sendView;
@property(nonatomic,strong) NSString *text;
@property(nonatomic, strong) UIImagePickerController *imageVC;
@property(nonatomic, strong) JMSGImageContent *ImageContent;

@end

@implementation SendFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage*image = [UIImage imageNamed:@"setmore"];
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [button.widthAnchor constraintEqualToConstant:30].active =YES;
    [button.heightAnchor constraintEqualToConstant:30].active =YES;
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    _sendView = [[SendFriendView alloc] init];
    _sendView.frame = CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAVIGATION_BAR_HEIGHT - SAFEDISTANCE_TABBAR_HEIGHT);
    [_sendView loadSendFriendView];
    [self.view addSubview:_sendView];
    
    /**图片选择器*/
    _imageVC = [[UIImagePickerController alloc] init];
    _imageVC.delegate = self;
    _imageVC.allowsEditing = YES;
    
    _sendView.text.delegate = self;
    
    
    [JMessage addDelegate:self withConversation:nil];

    
    [_sendView.button1 addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)send{
    
    
    NSString *GroupID = [[JMSGUser myInfo].extras objectForKey:@"朋友圈"];
    
    [JMSGConversation createGroupConversationWithGroupId:GroupID completionHandler:^(id resultObject, NSError *error) {
        JMSGTextContent  *content = [[JMSGTextContent alloc] initWithText:self.text];
//        JMSGMessage *textMessage = [JMSGMessage createGroupMessageWithContent:content groupId:GroupID];
//        if(self.text){
//            [JMSGMessage sendMessage:textMessage];
//        }
//        if(self.ImageMessage){
//            [JMSGMessage sendMessage:self.ImageMessage];
//        }
        [JMSGGroup myGroupArray:^(id resultObject, NSError *error) {
            NSMutableArray *groupArr = @[].mutableCopy;
            groupArr = resultObject;
            for(NSNumber *info in groupArr){
                JMSGMessage *textMessage = [JMSGMessage createGroupMessageWithContent:content groupId:info.description];
                JMSGMessage *ImageMessage = [JMSGMessage createGroupMessageWithContent:self.ImageContent groupId:info.description];
                [JMSGGroup groupInfoWithGroupId:info.description completionHandler:^(id resultObject, NSError *error) {
                    JMSGGroup *group = resultObject;
                    if([group.name containsString:@"朋友圈"]){
                        if(self.text){
                            [JMSGMessage sendMessage:textMessage];
                        }
                        if(self.ImageContent){
                            [JMSGMessage sendMessage:ImageMessage];
                        }
                    }
                }];
            }
        }];

        
        
        /**获取列表的所有消息*/
        [resultObject allMessages:^(id resultObject, NSError *error) {
            NSLog(@"");
        }];
        [self.navigationController popViewControllerAnimated:YES];

    }];
    
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
- (void)addImage{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        /**设置数据来源*/
        _imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        /**打开相机/相册/图库*/
        [self presentViewController:_imageVC animated:YES completion:nil];
    }
}


/// 图片代理方法取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    /**退出当前界面  */
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/// 图片代理方法选择完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *GroupID = [[JMSGUser myInfo].extras objectForKey:@"朋友圈"];

    _sendView.image1.image = [UIImage imageWithData:imageData];

    [JMSGConversation createGroupConversationWithGroupId:GroupID completionHandler:^(id resultObject, NSError *error) {
        JMSGImageContent *content = [[JMSGImageContent alloc] initWithImageData:imageData];
//        JMSGMessage *message = [JMSGMessage createGroupMessageWithContent:content groupId:GroupID];
        self.ImageContent = content;
        
        [picker dismissViewControllerAnimated:YES completion:nil];

    }];
        
    
}




/**TextView代理*/
- (void)textViewDidChange:(UITextView *)textView {
    if(textView.text.length){
        _sendView.placeholder.hidden = YES;
    }
    else{
        _sendView.placeholder.hidden = NO;
    }
    _text = self.sendView.text.text;
    
}

///接收消息
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error {
    NSLog(@"");
}

///监听发送消息
- (void)onSendMessageResponse:(JMSGMessage *)message error:(NSError *)error {
    NSLog(@"");
}


///接收离线消息
- (void)onSyncOfflineMessageConversation:(JMSGConversation *)conversation offlineMessages:(NSArray JMSG_GENERIC(__kindof JMSGMessage *)*)offlineMessages {
    NSLog(@"");
}


@end
