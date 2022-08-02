//
//  DJChatView.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJChatView : UIView

@property(nonatomic, strong)UITableView *tableview;

- (void)LoadChatView;

@end

NS_ASSUME_NONNULL_END
