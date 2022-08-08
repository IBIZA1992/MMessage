//
//  DJChatViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import "DJChatViewController.h"
#import "DJSingleton.h"
#import "DJChatTableViewCell.h"
#import "JMessage/JMessage.h"
#import "TextFieldView.h"


@interface DJChatViewController ()<UITableViewDelegate, UITableViewDataSource, JMessageDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)DJChatTableViewCell *cell;
@property(nonatomic, strong)NSMutableArray *messageArray;
@property(nonatomic, strong)TextFieldView *textview;
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)UIImagePickerController *imageVC;

@end

@implementation DJChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableview = [[UITableView alloc] init];
    [_tableview setFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-55-STATUS_NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:_tableview];
    
    _textview = [[TextFieldView alloc] init];
    [_textview setFrame:CGRectMake(0, SCREEN_HEIGHT-55, SCREEN_WIDTH, 55)];
    [_textview LoadTextFieldView];
    [self.view addSubview:_textview];
    
    /**图片选择器*/
    _imageVC = [[UIImagePickerController alloc] init];
    _imageVC.delegate = self;
    _imageVC.allowsEditing = YES;
    
    
    
    /**发送消息*/
    [_textview.btnsend addTarget:self action:@selector(sendpicture)  forControlEvents:UIControlEventTouchUpInside];
    /**键盘出现时*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    /**键盘消失时*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    _textview.textfield.returnKeyType = UIReturnKeySend;
    _textview.textfield.delegate = self;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _textview.textfield.delegate = self;
    [JMessage addDelegate:self withConversation:nil];
    
}


//获取聊天数据
- (void)viewWillAppear:(BOOL)animated{
    _single = [DJSingleton sharedManager];
    self.navigationItem.title = _single.userdata.username;
    _tableview.separatorStyle = NO;
    [self->_tableview reloadData];
    if(_single.messageArray.count){
        [self->_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self->_single.messageArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

//tableview滑到最底部
- (void)viewDidAppear:(BOOL)animated{
    _single = [DJSingleton sharedManager];
    if(_single.messageArray.count){
        [self->_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self->_single.messageArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}


//键盘弹出时 刷新子视图位置
- (void)keyboardWillShow:(NSNotification *)Notification{
    /**获取键盘的高度*/
    NSDictionary *userInfo = [Notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;     //width  键盘宽度
    [_tableview setFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_NAVIGATION_BAR_HEIGHT - height-55)];
    [_textview setFrame:CGRectMake(0, SCREEN_HEIGHT-55-height, SCREEN_WIDTH, 55)];
    [self.view layoutIfNeeded];
    [_tableview reloadData];
    if(_single.messageArray.count){
        [self->_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self->_single.messageArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

//键盘退出时 刷新子视图位置
- (void)keyboardWillHide:(NSNotification *)Notification{
    [_textview setFrame:CGRectMake(0, SCREEN_HEIGHT-55, SCREEN_WIDTH, 55)];
    [_tableview setFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-55-STATUS_NAVIGATION_BAR_HEIGHT)];
    [self.view layoutIfNeeded];
    [_tableview reloadData];
    if(_single.messageArray.count){
        [self->_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self->_single.messageArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}


//加入到消息列表中
- (void)Loadmessagelist{
    _single = [DJSingleton sharedManager];
    if(_single.messagelistArray.count != 0){
        BOOL isbool = [_single.messagelistArray containsObject: _single.userdata.username];
        if(isbool == NO){
            [_single.messagelistArray addObject:_single.userdata.username];
        }
    }
    if(_single.messagelistArray.count == 0){
        [_single.messagelistArray addObject:_single.userdata.username];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chat"
                                                        object:nil];
  
}

//发送按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _single = [DJSingleton sharedManager];
    [self Loadmessagelist];
    
    [JMSGConversation createSingleConversationWithUsername:_single.userdata.username completionHandler:^(id resultObject, NSError *error) {
        NSString *str = self->_textview.textfield.text;
        JMSGTextContent  *content = [[JMSGTextContent alloc] initWithText:str];
        JMSGMessage *message = [JMSGMessage createSingleMessageWithContent:content username:self->_single.userdata.username];
        [JMSGMessage sendMessage:message];
        /**获取列表的所有消息*/
        [[JMSGConversation singleConversationWithUsername:self->_single.userdata.username] allMessages:^(id resultObject, NSError *error) {
            self->_single.messageArray = @[].mutableCopy;
            self->_single.messageArray = (NSMutableArray *)resultObject;
            [self->_tableview reloadData];
            [self->_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self->_single.messageArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }];
        [self->_single.messagelistArray removeObject:self->_single.userdata.username];
        [self->_single.messagelistArray insertObject:self->_single.userdata.username atIndex:0];
    }];
    return YES;
}

//发送图片
- (void)sendpicture{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        /**设置数据来源*/
        _imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        /**打开相机/相册/图库*/
        [self presentViewController:_imageVC animated:YES completion:nil];
    }
}
//图片代理方法
// 取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    /**退出当前界面  */
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 选择完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,self.view.frame.size.height - 20)];
    [self.view addSubview:imageView];
    // 获取点击的图片
    imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//监听接收消息
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error{
    _single = [DJSingleton sharedManager];
    [self Loadmessagelist];
    /**获取列表的所有消息*/
    [[JMSGConversation singleConversationWithUsername:_single.userdata.username] allMessages:^(id resultObject, NSError *error) {
        self->_single.messageArray = @[].mutableCopy;
        self->_single.messageArray = (NSMutableArray *)resultObject;
        [self->_tableview reloadData];
        [self->_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self->_single.messageArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
    [_single.messagelistArray removeObject:_single.userdata.username];
    [_single.messagelistArray insertObject:_single.userdata.username atIndex:0];
}



//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _single = [DJSingleton sharedManager];
    return _single.messageArray.count;
    
}



//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    _single = [DJSingleton sharedManager];
    _cell = [[DJChatTableViewCell alloc] init];
    [_cell LoadChatTableViewCell:_single.messageArray[_single.messageArray.count-1-indexPath.row]];
    return _cell.cellheight;
}


//设置内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _single = [DJSingleton sharedManager];
    static NSString *CellIdentifier = @"Cell";
    _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (_cell == nil) {
        _cell = [[DJChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    /**倒叙排列*/
    [_cell LoadChatTableViewCell:_single.messageArray[_single.messageArray.count-1-indexPath.row]];
    
    return _cell;
}





@end
