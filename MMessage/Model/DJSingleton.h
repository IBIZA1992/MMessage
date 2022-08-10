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
@property(nonatomic, strong)NSMutableArray *addrequestArray;//好友请求列表
@property(nonatomic, strong)JMSGUser *user;
@property(nonatomic, strong)NSMutableArray *messageArray;//消息内容
@property(nonatomic, strong)NSMutableArray *messagelistArray;//消息列表

@property(nonatomic, strong)NSString *imagePath1;//我的头像地址
@property(nonatomic, strong)NSString *imagePath2;//聊天对方头像地址
@property(nonatomic, strong)NSMutableArray *imagePathArray;//聊天图片地址


+ (DJSingleton *)sharedManager;

@end

NS_ASSUME_NONNULL_END
