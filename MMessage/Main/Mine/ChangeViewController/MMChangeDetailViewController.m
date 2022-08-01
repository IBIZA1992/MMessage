//
//  MMChangeDetailViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/8/1.
//

#import "MMScreen.h"
#import "MMColor.h"
#import "MMChangeDetailViewController.h"

@interface MMChangeDetailViewController ()

@property (nonatomic, strong, readwrite) MMMineTableViewInfoItem *infoItem;
@property (nonatomic, strong, readwrite) UIButton *finishButton;

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
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    switch (self.infoItem.infoType) {
        case MMInfoTypeHeadPicture:
            NSLog(@"");
            break;
        case MMInfoTypeNickname:
            NSLog(@"");
            break;
        case MMInfoTypeUsername:
            NSLog(@"");
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
           
            break;
    }
    
}

@end
