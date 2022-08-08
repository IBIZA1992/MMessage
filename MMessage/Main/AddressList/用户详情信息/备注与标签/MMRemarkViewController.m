//
//  MMRemarkViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/8/8.
//

#import "MMScreen.h"
#import "MMColor.h"
#import "MMRemarkViewController.h"
#import "MMMineTextView.h"
#import "DJSingleton.h"
#import <SVProgressHUD.h>

@interface MMRemarkViewController ()<UITextViewDelegate>

@property (nonatomic, strong, readwrite) MMMineTextView *mineTextView;
@property (nonatomic, strong, readwrite) UIButton *finishButton;

@end

@implementation MMRemarkViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = WECHAT_BACKGROUND_GREY;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    DJSingleton *singleton = [DJSingleton sharedManager];
    
    [self.view addSubview:({
        self.mineTextView = [[MMMineTextView alloc] initWithFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, 80)
                                                             text:singleton.user.noteName
                                                        maxNumber:@(16)];
        self.mineTextView.textView.delegate = self;
        self.mineTextView;
    })];
}

#pragma mark - private method

- (void)_clickFinishButton {
    // 显示弹窗
    [SVProgressHUD showWithStatus:@"加载中"];
    
    DJSingleton *singleton = [DJSingleton sharedManager];
    [singleton.user updateNoteName:self.mineTextView.textView.text completionHandler:^(id resultObject, NSError *error) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
