//
//  LoginView.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView

@property(nonatomic,strong)UIImageView *background1;
@property(nonatomic,strong)UIImageView *background2;

@property(nonatomic,strong)UIImageView *circle1;
@property(nonatomic,strong)UIImageView *circle2;
@property(nonatomic,strong)UIImageView *circle3;

@property(nonatomic,strong)UIImageView *title;

@property(nonatomic,strong)UIImageView *account;
@property(nonatomic,strong)UIImageView *password;

@property(strong,nonatomic)UITextField *textaccount;
@property(strong,nonatomic)UITextField *textpassword;

@property(nonatomic,strong)UIImageView *line1;
@property(nonatomic,strong)UIImageView *line2;
@property(nonatomic,strong)UIImageView *line3;
@property(nonatomic,strong)UIImageView *line4;


@property(nonatomic,strong)UIButton *btnlogin;
@property(nonatomic,strong)UIButton *btnforget;
@property(nonatomic,strong)UIButton *btnZhifubao;
@property(nonatomic,strong)UIButton *btnregister;

- (void)LoadLoaginView;

@end

NS_ASSUME_NONNULL_END
