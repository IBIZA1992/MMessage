//
//  DJChatViewController.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import <UIKit/UIKit.h>
#import "Foundation/Foundation.h"
#import "AVFoundation/AVFoundation.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^RecordingStopCompletionHandler)(BOOL);
typedef void(^RecordingSaveCompletionHandler)(BOOL);

@interface DJChatViewController : UIViewController
@property(nonatomic,readonly)NSString * formattedCurrentTime;



@end

NS_ASSUME_NONNULL_END
