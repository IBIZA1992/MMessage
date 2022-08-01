//
//  DJSingleton.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/1.
//

#import <Foundation/Foundation.h>
#import "DJListItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJSingleton : NSObject

@property(nonatomic, strong)DJListItem *userdata;
@property(nonatomic, strong)NSMutableArray *addrequestArray;


+ (DJSingleton *)sharedManager;

@end

NS_ASSUME_NONNULL_END
