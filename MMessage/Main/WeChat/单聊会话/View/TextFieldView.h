//
//  TextFieldView.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/4.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"
#import "MMColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldView : UIView

@property(nonatomic, strong)UITextField *textfield;//输入框
@property(nonatomic, strong)UIButton *btnsend;//发送图片
@property(nonatomic, strong)UIButton *btnaudio;//发送语音



- (void)LoadTextFieldView;

@end

NS_ASSUME_NONNULL_END
