//
//  MMMineTableViewInfo.m
//  MMessage
//
//  Created by JiangNan on 2022/7/30.
//

#import "MMScreen.h"
#import "MMMineTableViewInfo.h"

@implementation MMMineTableViewInfoItem

@end

@implementation MMMineTableViewInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray<MMMineTableViewInfoItem *> *mutableArray = @[].mutableCopy;
        
        MMMineTableViewInfoItem *item0 = [[MMMineTableViewInfoItem alloc] init];;
        item0.infoType = MMInfoTypeHeadPicture;
        item0.text = @"头像";
        [mutableArray addObject:item0];
        
        MMMineTableViewInfoItem *item1 = [[MMMineTableViewInfoItem alloc] init];
        item1.infoType = MMInfoTypeNickname;
        item1.text = @"昵称";
        [mutableArray addObject:item1];
        
        MMMineTableViewInfoItem *item2 = [[MMMineTableViewInfoItem alloc] init];;
        item2.infoType = MMInfoTypeBirthday;
        item2.text = @"生日";
        [mutableArray addObject:item2];
        
        MMMineTableViewInfoItem *item3 = [[MMMineTableViewInfoItem alloc] init];;
        item3.infoType = MMInfoTypeGender;
        item3.text = @"性别";
        [mutableArray addObject:item3];
        
        MMMineTableViewInfoItem *item4 = [[MMMineTableViewInfoItem alloc] init];;
        item4.infoType = MMInfoTypeAddress;
        item4.text = @"地址";
        [mutableArray addObject:item4];
        
        MMMineTableViewInfoItem *item5 = [[MMMineTableViewInfoItem alloc] init];;
        item5.infoType = MMInfoTypeSignature;
        item5.text = @"签名";
        [mutableArray addObject:item5];
        
        // 布局高度
        mutableArray[0].height = UI(100);
        for (int i = 1; i < mutableArray.count; i++) {
            mutableArray[i].height = UI(100) * 0.618;
        }
        
        self = mutableArray.copy;
    }
    return self;
}

@end


 
