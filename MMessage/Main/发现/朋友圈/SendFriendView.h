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



- (void)loadSendFriendView;

@end

NS_ASSUME_NONNULL_END
