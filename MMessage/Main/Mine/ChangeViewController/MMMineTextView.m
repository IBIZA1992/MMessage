//
//  MMMineTextView.m
//  MMessage
//
//  Created by JiangNan on 2022/8/1.
//

#import "MMColor.h"
#import "MMScreen.h"
#import "MMMineTextView.h"

@interface MMMineTextView()

@end

@implementation MMMineTextView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text maxNumber:(NSNumber *)maxNumber{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.maxNumber = maxNumber;
        
        [self addSubview:({
            _textView = [[UITextView alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, self.frame.size.height)];
            _textView.text = text;
            _textView.font = [UIFont systemFontOfSize:17];
            _textView.tintColor = WECHAT_GREEN;
            _textView.backgroundColor = [UIColor whiteColor];
            _textView;
        })];
        
        [self addSubview:({
            _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, self.frame.size.height - 30, 30, 20)];
            _numberLabel.textAlignment = NSTextAlignmentRight;
            _numberLabel.alpha = 0.4;
            _numberLabel.text = [NSString stringWithFormat:@"%ld", self.maxNumber.intValue - _textView.text.length];
            _numberLabel;
        })];
    }
    return self;
}

@end
