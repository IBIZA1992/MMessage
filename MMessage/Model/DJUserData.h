//
//  DJUserData.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/29.
//

#import <Foundation/Foundation.h>
# import "JMessage/JMessage.h"
#import "DJListItem.h"

NS_ASSUME_NONNULL_BEGIN
@class DJListItem;

///定义一个block
typedef void(^FriendDataListBlock)(NSArray<DJListItem *> *dataArray);//返回好友信息数组

@interface DJUserData : NSObject

- (void)LoadFriendData:(FriendDataListBlock)finishBlock;



@end

NS_ASSUME_NONNULL_END
