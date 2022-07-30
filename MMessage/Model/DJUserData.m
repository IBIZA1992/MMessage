//
//  DJUserData.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/29.
//

#import "DJUserData.h"

@implementation DJUserData


/// 获取好像信息列表
/// @param finishBlock 返回好友信息ListItem数组
- (void)LoadFriendData:(FriendDataListBlock)finishBlock{
    
    [JMSGFriendManager getFriendList:^(id resultObject, NSError *error) {
        NSMutableArray *listItemArray = @[].mutableCopy;
        NSArray *dataArray = resultObject;
        for(JMSGUser *info in dataArray){
            DJListItem *list = [[DJListItem alloc] init];
            [list LoadUserDataModel:info];
            [listItemArray addObject:list];
        }
        dispatch_async(dispatch_get_main_queue(),^{
            if(finishBlock){
                finishBlock(listItemArray.copy);
            }
        });
    }];
    
}




@end
