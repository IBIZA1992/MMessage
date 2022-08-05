//
//  DJRegisterView.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJRegisterView : UIView

@property(nonatomic,strong)UIImageView *background1;
@property(nonatomic,strong)UIImageView *background2;

@property(nonatomic,strong)UIImageView *circle1;
@property(nonatomic,strong)UIImageView *circle2;
@property(nonatomic,strong)UIImageView *circle3;

@property(nonatomic,strong)UIImageView *icon1;
@property(nonatomic,strong)UIImageView *icon2;
@property(nonatomic,strong)UIImageView *icon3;
@property(nonatomic,strong)UIImageView *text;

@property(strong,nonatomic)UITextField *name;
@property(strong,nonatomic)UITextField *account;
@property(strong,nonatomic)UITextField *password;
@property(strong,nonatomic)UITextField *sure;

@property(nonatomic,strong)UIButton *btnregist;
@property(nonatomic,strong)UIButton *btnback;




- (void)Loadregister;

@end

NS_ASSUME_NONNULL_END
