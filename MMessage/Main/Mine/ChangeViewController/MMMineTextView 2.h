//
//  MMMineTextView.h
//  MMessage
//
//  Created by JiangNan on 2022/8/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMMineTextView : UIView

/// 初始化大小，默认文本
/// @param frame 大小
/// @param text 默认文本
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text maxNumber:(NSNumber *)maxNumber;

@property (nonatomic, strong, readwrite) UITextView *textView;
@property (nonatomic, strong, readwrite) UILabel *numberLabel;
@property (nonatomic, strong, readwrite) NSNumber *maxNumber;

@end

NS_ASSUME_NONNULL_END
