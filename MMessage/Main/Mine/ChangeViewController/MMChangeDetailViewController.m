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
#import <BRPickerView/BRPickerView.h>
#import "MMTimeFormatter.h"
#import "TZImagePickerController/TZImagePickerController.h"
#import "SDWebImage/SDWebImage.h"

@interface MMChangeDetailViewController ()<UITextViewDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, strong, readwrite) MMMineTableViewInfoItem *infoItem;
@property (nonatomic, strong, readwrite) UIButton *finishButton;
@property (nonatomic, strong, readwrite) JMSGUser *user;
@property (nonatomic, strong, readwrite) MMMineTextView *mineTextView;
@property (nonatomic, strong, readwrite) JMSGUserInfo *userInfo;

// 跟选择有关的button
@property (nonatomic, strong, readwrite) UIButton *pickChangeButton;
@property (nonatomic, strong, readwrite) UILabel *pickButtonLeftLabel;
@property (nonatomic, strong, readwrite) UILabel *pickButtonRightLabel;

// 跟修改头像有关
@property (nonatomic, strong, readwrite) UIImageView *headImageView;
@property (nonatomic, strong, readwrite) UIButton *pickPictureButton;

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
            [self _changeHeadPicture];
            break;
        case MMInfoTypeNickname:
            [self _changeNickName];
            break;
        case MMInfoTypeBirthday:
            [self _changeAboutPick];
            break;
        case MMInfoTypeGender:
            [self _changeAboutPick];
            break;
        case MMInfoTypeAddress:
            [self _changeAboutPick];
            break;
        case MMInfoTypeSignature:
            [self _changeSignature];
            break;
    }
    
}

#pragma mark - private method

#pragma mark 点击结束按钮

- (void)_clickFinishButton {
    
    if (self.mineTextView != nil) {
        [self.mineTextView resignFirstResponder];
    }
    
    switch (self.infoItem.infoType) {
            
        case MMInfoTypeHeadPicture:
        {
            NSData *headImageData = UIImageJPEGRepresentation(self.headImageView.image, 1.0f);
            [JMSGUser updateMyAvatarWithData:headImageData avatarFormat:@"jpeg" completionHandler:^(id resultObject, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }];
            break;
        }
            
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
        {
            self.userInfo.birthday = [MMTimeFormatter NSStringToTimeStamp:self.pickButtonRightLabel.text];
            [JMSGUser updateMyInfoWithUserInfo:self.userInfo completionHandler:^(id resultObject, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }];
            break;
        }
            
            
        case MMInfoTypeGender:
        {
            if ([self.pickButtonRightLabel.text isEqualToString:@"男"]) {
                self.userInfo.gender = kJMSGUserGenderMale;
            } else if ([self.pickButtonRightLabel.text isEqualToString:@"女"]) {
                self.userInfo.gender = kJMSGUserGenderFemale;
            }
            [JMSGUser updateMyInfoWithUserInfo:self.userInfo completionHandler:^(id resultObject, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }];
            break;
        }
            
        case MMInfoTypeAddress:
        {
            self.userInfo.address = self.pickButtonRightLabel.text;
            [JMSGUser updateMyInfoWithUserInfo:self.userInfo completionHandler:^(id resultObject, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }];
            break;
        }
    
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

#pragma mark 修改文本相关

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

#pragma mark 修改选择器相关

- (void)_changeAboutPick {
    [self.view addSubview:({
        self.pickChangeButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                           STATUS_NAVIGATION_BAR_HEIGHT,
                                                                           SCREEN_WIDTH,
                                                                           UI(100) * 0.55)];
        self.pickChangeButton.backgroundColor = [UIColor whiteColor];
        [self.pickChangeButton addTarget:self action:@selector(_clickPickChangeButton) forControlEvents:UIControlEventTouchUpInside];
        [self.pickChangeButton addSubview:({
            self.pickButtonLeftLabel = [[UILabel alloc] init];
            self.pickButtonLeftLabel.text = @"集合";
            self.pickButtonLeftLabel.font = [UIFont systemFontOfSize:17];
            [self.pickButtonLeftLabel sizeToFit];
            self.pickButtonLeftLabel.center = CGPointMake(UI(38), self.pickChangeButton.bounds.size.height / 2);
            self.pickButtonLeftLabel;
        })];
        
        [self.pickChangeButton addSubview:({
            self.pickButtonRightLabel = [[UILabel alloc] init];
            self.pickButtonRightLabel.text = @"集合";
            self.pickButtonRightLabel.font = [UIFont systemFontOfSize:17];
            [self.pickButtonRightLabel sizeToFit];
            self.pickButtonRightLabel.alpha = 0.5;
            [self.pickButtonRightLabel setFrame:CGRectMake(self.pickButtonLeftLabel.frame.size.width + self.pickButtonLeftLabel.frame.origin.x + UI(30),
                                                           self.pickButtonLeftLabel.frame.origin.y,
                                                           UI(300),
                                                           self.pickButtonRightLabel.frame.size.height)];
            self.pickButtonRightLabel;
        })];
        
        self.pickButtonLeftLabel.text = self.infoItem.text;
        
        // 设置内容信息
        switch (self.infoItem.infoType) {
            case MMInfoTypeBirthday:
            {
                
                self.pickButtonRightLabel.text = self.user.birthday;
                break;
            }
                
            case MMInfoTypeGender:
            {
                if (self.user.gender == kJMSGUserGenderMale) {
                    self.pickButtonRightLabel.text = @"男";
                } else if (self.user.gender == kJMSGUserGenderFemale) {
                    self.pickButtonRightLabel.text = @"女";
                } else {
                    self.pickButtonRightLabel.text = @"";
                }
                break;
            }
                
            case MMInfoTypeAddress:
            {
                self.pickButtonRightLabel.text = self.user.address;
                break;
            }
            
            default:
                break;
        }
        
        self.pickChangeButton;
    })];
    
    [self _clickPickChangeButton];
}

- (void)_clickPickChangeButton {
    switch (self.infoItem.infoType) {
        case MMInfoTypeBirthday:
        {
            NSString *originString = [[NSString alloc] init];
            originString = self.pickButtonRightLabel.text;
            
            // 时间选择器
            BRDatePickerView *datePickerView = [[BRDatePickerView alloc] init];
            datePickerView.pickerMode = BRDatePickerModeYMD;
            datePickerView.title = @"选择年月日";
            datePickerView.selectValue = originString;
            datePickerView.minDate = [NSDate br_setYear:1919 month:3 day:29];
            datePickerView.maxDate = [NSDate date];
            datePickerView.isAutoSelect = YES;
            datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                self.pickButtonRightLabel.text = selectValue;
            };
            datePickerView.cancelBlock = ^{
                self.pickButtonRightLabel.text = originString;
            };
            [datePickerView show];
            break;
        }
            
        case MMInfoTypeGender:
        {
            NSString *originString = [[NSString alloc] init];
            originString = self.pickButtonRightLabel.text;
            
            // 性别
            BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
            stringPickerView.pickerMode = BRStringPickerComponentSingle;
            stringPickerView.isAutoSelect = YES;
            stringPickerView.title = @"请选择性别";
            if ([originString isEqualToString:@"女"]) {
                stringPickerView.selectIndex = 1;
            } else {
                stringPickerView.selectIndex = 0;
            }
            stringPickerView.dataSourceArr = @[@"男", @"女"];
            stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
                self.pickButtonRightLabel.text = resultModel.value;
            };
            stringPickerView.cancelBlock = ^{
                self.pickButtonRightLabel.text = originString;
            };
            [stringPickerView show];
            break;
        }
            
        case MMInfoTypeAddress:
        {
            NSString *originString = [[NSString alloc] init];
            originString = self.pickButtonRightLabel.text;
            NSArray *originStringArray = [originString componentsSeparatedByString:@" "];
            
            // 地址选择器
            BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc] init];
            addressPickerView.pickerMode = BRAddressPickerModeArea;
            addressPickerView.title = @"请选择地区";
            addressPickerView.selectValues = originStringArray;
            addressPickerView.isAutoSelect = YES;
            addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                self.pickButtonRightLabel.text = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
            };
            addressPickerView.cancelBlock = ^{
                self.pickButtonRightLabel.text = originString;
            };
            [addressPickerView show];
            break;
        }
        
        default:
            break;
    }
}

#pragma mark 修改头像

- (void)_changeHeadPicture {
    [self.view addSubview:({
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
        self.headImageView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        if (self.user.avatar != nil) {
            [self.user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                if (data != nil) {
                    self->_headImageView.image = [UIImage imageWithData:data];
                } else {
                    self->_headImageView.image = [UIImage imageNamed:@"head"];
                }
            }];
        } else {
            self->_headImageView.image = [UIImage imageNamed:@"head"];
        }
        self.headImageView;
    })];
    
    [self.view addSubview:({
        self.pickPictureButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                           self.headImageView.frame.size.width + self.headImageView.frame.origin.y + UI(20),
                                                                           SCREEN_WIDTH,
                                                                           UI(60))];
        [self.pickPictureButton addSubview:({
            UILabel *buttonLabel = [[UILabel alloc] init];
            buttonLabel.text = @"从相册中选取图片";
            buttonLabel.font = [UIFont systemFontOfSize:18];
            buttonLabel.alpha = 0.7;
            [buttonLabel sizeToFit];
            buttonLabel.center = CGPointMake(self.pickPictureButton.frame.size.width / 2, self.pickPictureButton.frame.size.height / 2);
            buttonLabel;
        })];

        
        [self.pickPictureButton addTarget:self action:@selector(_clickPickPictureButton) forControlEvents:UIControlEventTouchUpInside];
        self.pickPictureButton.backgroundColor = [UIColor whiteColor];
        self.pickPictureButton;
    })];
}

- (void)_clickPickPictureButton {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = SCREEN_WIDTH - 2 * left;
    NSInteger top = (SCREEN_HEIGHT - widthHeight) / 2;
    if ([TZCommonTools tz_isLandscape]) {
        top = 30;
        widthHeight = SCREEN_HEIGHT - 2 * left;
        left = (SCREEN_WIDTH - widthHeight) / 2;
    }
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [SVProgressHUD show];
        self->_headImageView.image = photos[0];
        [SVProgressHUD dismiss];
    }];
    
    imagePickerVc.allowCrop = YES;
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];

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
