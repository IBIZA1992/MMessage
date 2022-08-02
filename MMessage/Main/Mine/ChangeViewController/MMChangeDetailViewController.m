//
//  MMChangeDetailViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/8/1.
//

#import "MMScreen.h"
#import "MMColor.h"
#import "MMChangeDetailViewController.h"
#import "JMessage/JMessage.h"
#import "MMMineTextView.h"
#import "SVProgressHUD/SVProgressHUD.h"

@interface MMChangeDetailViewController ()<UITextViewDelegate>

@property (nonatomic, strong, readwrite) MMMineTableViewInfoItem *infoItem;
@property (nonatomic, strong, readwrite) UIButton *finishButton;
@property (nonatomic, strong, readwrite) JMSGUser *user;
@property (nonatomic, strong, readwrite) MMMineTextView *mineTextView;
@property (nonatomic, strong, readwrite) JMSGUserInfo *userInfo;

@end

@implementation MMChangeDetailViewController

- (instancetype)initWithInfoItem:(MMMineTableViewInfoItem *)infoItem {
    self = [super init];
    if (self) {
        self.infoItem = infoItem;
        self.view.backgroundColor = WECHAT_BACKGROUND_GREY;
        self.navigationItem.title = [NSString stringWithFormat:@"设置%@", self.infoItem.text];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [JMSGUser myInfo];
    
    self.userInfo = [[JMSGUserInfo alloc] init];
//    userInfo.nickname = @"啦啦啦";
//    [JMSGUser updateMyInfoWithUserInfo:userInfo completionHandler:^(id resultObject, NSError *error) {
//            NSLog(@"");
//    }];
    
    // 完成按钮（在navigationBar上布局，不用UI适应）
    self.finishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 34)];
    self.finishButton.backgroundColor = WECHAT_GREEN;
    self.finishButton.layer.cornerRadius = 5;
    self.finishButton.layer.masksToBounds = YES;
    [self.finishButton addSubview:({
        UILabel *buttonLabel = [[UILabel alloc] init];
        buttonLabel.text = @"完成";
        buttonLabel.font = [UIFont boldSystemFontOfSize:17];
        buttonLabel.textColor = [UIColor whiteColor];
        [buttonLabel sizeToFit];
        buttonLabel.center = CGPointMake(self.finishButton.frame.size.width / 2, 34 / 2);
        buttonLabel;
    })];
    [self.finishButton addTarget:self action:@selector(_clickFinishButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    // 不同情况下的选择
    switch (self.infoItem.infoType) {
        case MMInfoTypeHeadPicture:
            NSLog(@"");
            break;
        case MMInfoTypeNickname:
            [self _changeNickName];
            break;
        case MMInfoTypeBirthday:
            NSLog(@"");
            break;
        case MMInfoTypeGender:
            NSLog(@"");
            break;
        case MMInfoTypeAddress:
            NSLog(@"");
            break;
        case MMInfoTypeSignature:
            [self _changeSignature];
            break;
    }
    
}

#pragma mark - private method

- (void)_clickFinishButton {
    
    if (self.mineTextView != nil) {
        [self.mineTextView resignFirstResponder];
    }
    
    switch (self.infoItem.infoType) {
            
        case MMInfoTypeHeadPicture:
            NSLog(@"");
            break;
            
        case MMInfoTypeNickname:
        {
            self.userInfo.nickname = self.mineTextView.textView.text;
            [JMSGUser updateMyInfoWithUserInfo:self.userInfo completionHandler:^(id resultObject, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }];
            break;
        }
            
            
        case MMInfoTypeBirthday:
            NSLog(@"");
            break;
        case MMInfoTypeGender:
            NSLog(@"");
            break;
        case MMInfoTypeAddress:
            NSLog(@"");
            break;
            
        case MMInfoTypeSignature:
        {
            self.userInfo.signature = self.mineTextView.textView.text;
            [JMSGUser updateMyInfoWithUserInfo:self.userInfo completionHandler:^(id resultObject, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }];
            break;
        }
    }
    
    // 显示弹窗
    [SVProgressHUD showWithStatus:@"加载中"];
}

/// 修改头像
- (void)_changeHeadPicture {
    
}

/// 修改昵称
- (void)_changeNickName {
    [self.view addSubview:({
        _mineTextView = [[MMMineTextView alloc] initWithFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, 80)
                                                                    text:self.user.nickname
                                                               maxNumber:@(16)];
        _mineTextView.textView.delegate = self;
        _mineTextView;
    })];
}

/// 修改签名
- (void)_changeSignature {
    [self.view addSubview:({
        _mineTextView = [[MMMineTextView alloc] initWithFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, 80)
                                                                    text:self.user.signature
                                                               maxNumber:@(32)];
        _mineTextView.textView.delegate = self;
        _mineTextView;
    })];
}

#pragma mark - UITextViewDelegate

// 将要改变文字
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ((textView.text.length >= self.mineTextView.maxNumber.intValue) && !([text isEqualToString:@""])) {
        [textView resignFirstResponder];
        return NO;
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self _clickFinishButton];
        return NO;
    }
    return YES;
}

// 已经改变文字
- (void)textViewDidChange:(UITextView *)textView {
    self.mineTextView.numberLabel.text = [NSString stringWithFormat:@"%ld", self.mineTextView.maxNumber.intValue - textView.text.length];
}

@end
