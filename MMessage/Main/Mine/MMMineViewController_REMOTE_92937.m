//
//  MMMineViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/7/28.
//

#import "MMScreen.h"
#import "MMColor.h"
#import "MMMineViewController.h"
#import "MMMineChangeViewController.h"
#import "JMessage/JMessage.h"

@interface MMMineViewController ()
@property (nonatomic, strong ,readwrite) UIView *imageBackgroundView;
@property (nonatomic, strong, readwrite) UIImageView *headImageView;
@property (nonatomic, strong, readwrite) UILabel *nickNameLabel;
@property (nonatomic, strong, readwrite) UILabel *userNameLabel;
@property (nonatomic, strong, readwrite) UIImageView *enterImageView;  // 最右侧进入的图片
@property (nonatomic, strong, readwrite) UIButton *logoutButton;
@end

@implementation MMMineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"我";
        self.tabBarItem.image = [UIImage imageNamed:@"people"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"people.fill"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WECHAT_BACKGROUND_GREY;
    
    // 设置图片的栏目
    [self.view addSubview:({
        self.imageBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBARHEIGHT + SCREEN_HEIGHT / 4)];
        self.imageBackgroundView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_clikeBackgroundView)];
        self.imageBackgroundView.userInteractionEnabled = YES;
        [self.imageBackgroundView addGestureRecognizer:tapGestureRecognizer];
        self.imageBackgroundView;
    })];
    
    [self.imageBackgroundView addSubview:({
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI(75), UI(75))];
        self.headImageView.center = CGPointMake(SCREEN_WIDTH / 5, STATUSBARHEIGHT + SCREEN_HEIGHT / 8);
        self.headImageView.image = [UIImage imageNamed:@"head"];
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headImageView.layer.cornerRadius = UI(8);
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView;
    })];
    
    [self.imageBackgroundView addSubview:({
        self.nickNameLabel = [[UILabel alloc] init];
        self.nickNameLabel.text = @"未设置昵称";
        self.nickNameLabel.font = [UIFont boldSystemFontOfSize:UI(24)];
        [self.nickNameLabel sizeToFit];
        [self.nickNameLabel setFrame:CGRectMake(self.headImageView.frame.size.width + self.headImageView.frame.origin.x + UI(20),
                                            self.headImageView.frame.origin.y + UI(8),
                                            self.nickNameLabel.frame.size.width,
                                            self.nickNameLabel.frame.size.height)];
        self.nickNameLabel;
    })];
    
    [self.imageBackgroundView addSubview:({
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.text = @"用户名：Mega";
        self.userNameLabel.font = [UIFont boldSystemFontOfSize:UI(16)];
        self.userNameLabel.alpha = 0.5;
        [self.userNameLabel sizeToFit];
        [self.userNameLabel setFrame:CGRectMake(self.nickNameLabel.frame.origin.x,
                                            self.nickNameLabel.frame.size.height + self.nickNameLabel.frame.origin.y + UI(12),
                                            self.userNameLabel.frame.size.width,
                                            self.userNameLabel.frame.size.height)];
        self.userNameLabel;
    })];
    
    [self.imageBackgroundView addSubview:({
        self.enterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI(25), UI(25))];
        self.enterImageView.center = CGPointMake(SCREEN_WIDTH * 12 / 13, self.headImageView.center.y);
        self.enterImageView.image = [UIImage imageNamed:@"enter"];
        self.enterImageView;
    })];
    
    [self.view addSubview:({
        self.logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2.5, SCREEN_WIDTH / 4)];
        self.logoutButton.center = CGPointMake(SCREEN_WIDTH / 2, self.imageBackgroundView.frame.size.height + UI(110));
        self.logoutButton.backgroundColor = WECHAT_GREEN;
        self.logoutButton.layer.cornerRadius = UI(20);
        
        [self.logoutButton addSubview:({
            UILabel *logoutLabel = [[UILabel alloc] init];
            logoutLabel.text = @"退出登陆";
            logoutLabel.font = [UIFont boldSystemFontOfSize:UI(24)];
            logoutLabel.textColor = [UIColor whiteColor];
            [logoutLabel sizeToFit];
            logoutLabel.center = CGPointMake(self.logoutButton.frame.size.width / 2, self.logoutButton.frame.size.height / 2);
            logoutLabel;
        })];

        [self.logoutButton addTarget:self action:@selector(_clikeLogoutButton) forControlEvents:UIControlEventTouchUpInside];
        self.logoutButton;
    })];
}

/// 在即将出现时加载，用于加载真实数据
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    JMSGUser *user = [JMSGUser myInfo];
    self.userNameLabel.text = [NSString stringWithFormat:@"用户名：%@", user.username];
    [self.userNameLabel sizeToFit];
    if (user.nickname != nil) {
        self.nickNameLabel.text = user.nickname;
        [self.nickNameLabel sizeToFit];
    }
    if (user.avatar == nil) {
        NSLog(@"");
    }
}

#pragma mark - private method

/// 点击退出按钮
- (void)_clikeLogoutButton {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"outlogin" object:nil];
}

/// 点击头像的背景控件，进入信息底层页
- (void)_clikeBackgroundView {
    MMMineChangeViewController *changeViewController = [[MMMineChangeViewController alloc] init];
    [self.navigationController pushViewController:changeViewController animated:YES];
}

@end
