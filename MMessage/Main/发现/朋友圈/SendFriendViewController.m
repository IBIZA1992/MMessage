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
///图片选择控制器
@property(nonatomic, strong) UIImagePickerController *imageVC;
///文字文本内容
@property(nonatomic, strong) JMSGTextContent *TextContent;
///图片的位置
@property(nonatomic ) int ImageNumber;
///图片文本内容
@property(nonatomic, strong) JMSGImageContent *ImageContent1;
@property(nonatomic, strong) JMSGImageContent *ImageContent2;
@property(nonatomic, strong) JMSGImageContent *ImageContent3;
@property(nonatomic, strong) JMSGImageContent *ImageContent4;
@property(nonatomic, strong) JMSGImageContent *ImageContent5;
@property(nonatomic, strong) JMSGImageContent *ImageContent6;

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

    
    [_sendView.button1 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendView.button2 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendView.button3 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendView.button4 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendView.button5 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendView.button6 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendView.button7 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendView.button8 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendView.button9 addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    

    

}

- (void)send{
  
    [JMSGGroup myGroupArray:^(id resultObject, NSError *error) {
        NSMutableArray * groupArr = @[].mutableCopy;
        groupArr = resultObject;
        for(NSNumber *info in groupArr) {
            JMSGMessage *textMessage = [JMSGMessage createGroupMessageWithContent:self.TextContent groupId:info.description];
            JMSGMessage *imageMessaage = [JMSGMessage createGroupMessageWithContent:self.ImageContent1 groupId:info.description];
            [JMSGGroup groupInfoWithGroupId:info.description completionHandler:^(id resultObject, NSError *error) {
                JMSGGroup *group = resultObject;

                if(self.ImageNumber == 1){
                    [self sendOneImage:info.description groupName:group.name];
                }
                if(self.ImageNumber == 2){
                    [self sendTwoImage:info.description groupName:group.name];
                }
                if(self.ImageNumber == 3){
                    [self sendThreeImage:info.description groupName:group.name];
                }
                if(self.ImageNumber == 4){
                    [self sendFourImage:info.description groupName:group.name];
                }
                if(self.ImageNumber == 5){
                    [self sendFiveImage:info.description groupName:group.name];
                }
                if(self.ImageNumber == 6){
                    [self sendSixImage:info.description groupName:group.name];
                }

                if([group.name containsString:@"朋友圈"]) {
                    if(self.TextContent) {
                        [JMSGMessage sendMessage:textMessage];
                    }
                }
            }];
        }
 

        [self.navigationController popViewControllerAnimated:YES];
    }];

}

- (void)onSendMessageResponse:(JMSGMessage *)message error:(NSError *)error {
    NSLog(@"");
}

///发送一张照片
- (void)sendOneImage:(NSString *)groupId groupName:(NSString *)groupName {
    JMSGMessage *imageMessaage = [JMSGMessage createGroupMessageWithContent:self.ImageContent1 groupId:groupId];
    if([groupName containsString:@"朋友圈"]) {
        if(self.ImageContent1) {
            [JMSGMessage sendMessage:imageMessaage];
        }
    }
}
///发送两张图片
- (void)sendTwoImage:(NSString *)groupId groupName:(NSString *)groupName {
    JMSGMessage *imageMessaage = [JMSGMessage createGroupMessageWithContent:self.ImageContent2 groupId:groupId];
    if([groupName containsString:@"朋友圈"]) {
        if(self.ImageContent2) {
            [JMSGMessage sendMessage:imageMessaage];
        }
    }
    [self sendOneImage:groupId groupName:groupName];
}
///发送三张图片
- (void)sendThreeImage:(NSString *)groupId groupName:(NSString *)groupName {
    JMSGMessage *imageMessaage = [JMSGMessage createGroupMessageWithContent:self.ImageContent3 groupId:groupId];
    if([groupName containsString:@"朋友圈"]) {
        if(self.ImageContent3) {
            [JMSGMessage sendMessage:imageMessaage];
        }
    }
    [self sendTwoImage:groupId groupName:groupName];
}
///发送四张图片
- (void)sendFourImage:(NSString *)groupId groupName:(NSString *)groupName {
    JMSGMessage *imageMessaage = [JMSGMessage createGroupMessageWithContent:self.ImageContent4 groupId:groupId];
    if([groupName containsString:@"朋友圈"]) {
        if(self.ImageContent4) {
            [JMSGMessage sendMessage:imageMessaage];
        }
    }
    [self sendThreeImage:groupId groupName:groupName];
}
///发送五张图片
- (void)sendFiveImage:(NSString *)groupId groupName:(NSString *)groupName {
    JMSGMessage *imageMessaage = [JMSGMessage createGroupMessageWithContent:self.ImageContent5 groupId:groupId];
    if([groupName containsString:@"朋友圈"]) {
        if(self.ImageContent5) {
            [JMSGMessage sendMessage:imageMessaage];
        }
    }
    [self sendFourImage:groupId groupName:groupName];
}
///发送六张图片
- (void)sendSixImage:(NSString *)groupId groupName:(NSString *)groupName {
    JMSGMessage *imageMessaage = [JMSGMessage createGroupMessageWithContent:self.ImageContent6 groupId:groupId];
    if([groupName containsString:@"朋友圈"]) {
        if(self.ImageContent6) {
            [JMSGMessage sendMessage:imageMessaage];
        }
    }
    [self sendFiveImage:groupId groupName:groupName];
}




//获取全部群组，如果是朋友圈群组就发送消息
- (void)addImage{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        /**设置数据来源*/
        _imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        /**打开相机/相册/图库*/
        [self presentViewController:_imageVC animated:YES completion:nil];
    }
}

- (void)addImage:(UIButton *)btn {
    if(btn.tag == 1) {
        _sendView.image2.alpha = 1;
        _sendView.button2.enabled = YES;
    }
    if(btn.tag == 2) {
        _sendView.image3.alpha = 1;
        _sendView.button3.enabled = YES;
    }
    if(btn.tag == 3) {
        _sendView.image4.alpha = 1;
        _sendView.button4.enabled = YES;
    }
    if(btn.tag == 4) {
        _sendView.image5.alpha = 1;
        _sendView.button5.enabled = YES;
    }
    if(btn.tag == 5) {
        _sendView.image6.alpha = 1;
        _sendView.button6.enabled = YES;
    }
    if(btn.tag == 6) {
        _sendView.image7.alpha = 1;
        _sendView.button7.enabled = YES;
    }
    if(btn.tag == 7) {
        _sendView.image8.alpha = 1;
        _sendView.button8.enabled = YES;
    }
    if(btn.tag == 8) {
        _sendView.image9.alpha = 1;
        _sendView.button9.enabled = YES;
    }
    
    _ImageNumber = (int)btn.tag;
    
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

    if(_ImageNumber == 1) {
        _sendView.image1.image = [UIImage imageWithData:imageData];
        [JMSGConversation createGroupConversationWithGroupId:GroupID completionHandler:^(id resultObject, NSError *error) {
            JMSGImageContent *content = [[JMSGImageContent alloc] initWithImageData:imageData];
            self.ImageContent1 = content;
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    if(_ImageNumber == 2) {
        _sendView.image2.image = [UIImage imageWithData:imageData];
        [JMSGConversation createGroupConversationWithGroupId:GroupID completionHandler:^(id resultObject, NSError *error) {
            JMSGImageContent *content = [[JMSGImageContent alloc] initWithImageData:imageData];
            self.ImageContent2 = content;
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    if(_ImageNumber == 3) {
        _sendView.image3.image = [UIImage imageWithData:imageData];
        [JMSGConversation createGroupConversationWithGroupId:GroupID completionHandler:^(id resultObject, NSError *error) {
            JMSGImageContent *content = [[JMSGImageContent alloc] initWithImageData:imageData];
            self.ImageContent3 = content;
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    if(_ImageNumber == 4) {
        _sendView.image4.image = [UIImage imageWithData:imageData];
        [JMSGConversation createGroupConversationWithGroupId:GroupID completionHandler:^(id resultObject, NSError *error) {
            JMSGImageContent *content = [[JMSGImageContent alloc] initWithImageData:imageData];
            self.ImageContent4 = content;
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    if(_ImageNumber == 5) {
        _sendView.image5.image = [UIImage imageWithData:imageData];
        [JMSGConversation createGroupConversationWithGroupId:GroupID completionHandler:^(id resultObject, NSError *error) {
            JMSGImageContent *content = [[JMSGImageContent alloc] initWithImageData:imageData];
            self.ImageContent5 = content;
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    if(_ImageNumber == 6) {
        _sendView.image6.image = [UIImage imageWithData:imageData];
        [JMSGConversation createGroupConversationWithGroupId:GroupID completionHandler:^(id resultObject, NSError *error) {
            JMSGImageContent *content = [[JMSGImageContent alloc] initWithImageData:imageData];
            self.ImageContent6 = content;
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
        
    
}




/**TextView代理*/
- (void)textViewDidChange:(UITextView *)textView {
    if(textView.text.length){
        _sendView.placeholder.hidden = YES;
    }
    else{
        _sendView.placeholder.hidden = NO;
    }
    _TextContent = [[JMSGTextContent alloc] initWithText:self.sendView.text.text];
    
}

///接收消息
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error {
    NSLog(@"");
}


///接收离线消息
- (void)onSyncOfflineMessageConversation:(JMSGConversation *)conversation offlineMessages:(NSArray JMSG_GENERIC(__kindof JMSGMessage *)*)offlineMessages {
    NSLog(@"");
}


@end
