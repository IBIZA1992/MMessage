//
//  MMMineViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/7/28.
//

#import "MMScreen.h"
#import "MMColor.h"
#import "MMMineViewController.h"

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
        
        self.view.backgroundColor = WECHAT_BACKGROUND_GREY;
        
        // 设置图片的栏目
        [self.view addSubview:({
            _imageBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBARHEIGHT + SCREEN_HEIGHT / 4)];
            _imageBackgroundView.backgroundColor = [UIColor whiteColor];
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_clikeBackgroundView)];
            _imageBackgroundView.userInteractionEnabled = YES;
            [_imageBackgroundView addGestureRecognizer:tapGestureRecognizer];
            _imageBackgroundView;
        })];
        
        [_imageBackgroundView addSubview:({
            _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI(75), UI(75))];
            _headImageView.center = CGPointMake(SCREEN_WIDTH / 5, STATUSBARHEIGHT + SCREEN_HEIGHT / 8);
            _headImageView.image = [UIImage imageNamed:@"head"];
            _headImageView.contentMode = UIViewContentModeScaleAspectFill;
            _headImageView.layer.cornerRadius = UI(8);
            _headImageView.layer.masksToBounds = YES;
            _headImageView;
        })];
        
        [_imageBackgroundView addSubview:({
            _nickNameLabel = [[UILabel alloc] init];
            _nickNameLabel.text = @"IBIZA";
            _nickNameLabel.font = [UIFont boldSystemFontOfSize:UI(24)];
            [_nickNameLabel sizeToFit];
            [_nickNameLabel setFrame:CGRectMake(_headImageView.frame.size.width + _headImageView.frame.origin.x + UI(20),
                                                _headImageView.frame.origin.y + UI(8),
                                                _nickNameLabel.frame.size.width,
                                                _nickNameLabel.frame.size.height)];
            _nickNameLabel;
        })];
        
        [_imageBackgroundView addSubview:({
            _userNameLabel = [[UILabel alloc] init];
            _userNameLabel.text = @"用户名：Mega";
            _userNameLabel.font = [UIFont boldSystemFontOfSize:UI(16)];
            _userNameLabel.alpha = 0.5;
            [_userNameLabel sizeToFit];
            [_userNameLabel setFrame:CGRectMake(_nickNameLabel.frame.origin.x,
                                                _nickNameLabel.frame.size.height + _nickNameLabel.frame.origin.y + UI(12),
                                                _userNameLabel.frame.size.width,
                                                _userNameLabel.frame.size.height)];
            _userNameLabel;
        })];
        
        [_imageBackgroundView addSubview:({
            _enterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI(25), UI(25))];
            _enterImageView.center = CGPointMake(SCREEN_WIDTH * 12 / 13, _headImageView.center.y);
            _enterImageView.image = [UIImage imageNamed:@"enter"];
            _enterImageView;
        })];
        
        [self.view addSubview:({
            _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2.5, SCREEN_WIDTH / 4)];
            _logoutButton.center = CGPointMake(SCREEN_WIDTH / 2, _imageBackgroundView.frame.size.height + UI(110));
            _logoutButton.backgroundColor = WECHAT_GREEN;
            _logoutButton.layer.cornerRadius = UI(20);
            
            [_logoutButton addSubview:({
                UILabel *logoutLabel = [[UILabel alloc] init];
                logoutLabel.text = @"退出登陆";
                logoutLabel.font = [UIFont boldSystemFontOfSize:UI(24)];
                logoutLabel.textColor = [UIColor whiteColor];
                [logoutLabel sizeToFit];
                logoutLabel.center = CGPointMake(_logoutButton.frame.size.width / 2, _logoutButton.frame.size.height / 2);
                logoutLabel;
            })];

            [_logoutButton addTarget:self action:@selector(_clikeLogoutButton) forControlEvents:UIControlEventTouchUpInside];
            _logoutButton;
        })];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - private method

/// 点击退出按钮
- (void)_clikeLogoutButton {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"outlogin" object:nil];
}

/// 点击头像的背景控件，进入信息底层页
- (void)_clikeBackgroundView {
    NSLog(@"");
}

@end
