//
//  DJSingleton.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/1.
//

#import <Foundation/Foundation.h>
#import "DJListItem.h"
#import "JMessage/JMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJSingleton : NSObject

@property(nonatomic, strong)DJListItem *userdata;
@property(nonatomic, strong)NSMutableArray *addrequestArray;
@property(nonatomic, strong)JMSGUser *user;
@property(nonatomic, strong)NSMutableArray *messageArray;//消息内容
@property(nonatomic, strong)NSMutableArray *messagelistArray;//消息列表


+ (DJSingleton *)sharedManager;

@end

NS_ASSUME_NONNULL_END
