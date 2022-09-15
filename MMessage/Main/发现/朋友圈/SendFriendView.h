//
//  SendFriendView.h
//  MMessage
//
//  Created by 邓杰 on 2022/9/7.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"
#import "MMColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendFriendView : UIView

@property(strong, nonatomic) UITextView *text;
@property(strong, nonatomic) UILabel *placeholder;
@property(nonatomic, strong) UIImageView *image1;
@property(nonatomic, strong) UIButton *button1;

@property(nonatomic, strong) UIImageView *image2;
@property(nonatomic, strong) UIButton *button2;

@property(nonatomic, strong) UIImageView *image3;
@property(nonatomic, strong) UIButton *button3;

@property(nonatomic, strong) UIImageView *image4;
@property(nonatomic, strong) UIButton *button4;

@property(nonatomic, strong) UIImageView *image5;
@property(nonatomic, strong) UIButton *button5;

@property(nonatomic, strong) UIImageView *image6;
@property(nonatomic, strong) UIButton *button6;

@property(nonatomic, strong) UIImageView *image7;
@property(nonatomic, strong) UIButton *button7;

@property(nonatomic, strong) UIImageView *image8;
@property(nonatomic, strong) UIButton *button8;

@property(nonatomic, strong) UIImageView *image9;
@property(nonatomic, strong) UIButton *button9;



- (void)loadSendFriendView;

@end

NS_ASSUME_NONNULL_END
