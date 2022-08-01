//
//  MMMineTableViewCell.m
//  MMessage
//
//  Created by JiangNan on 2022/8/1.
//

#import "MMMineTableViewCell.h"
#import "JMessage/JMessage.h"

@interface MMMineTableViewCell()

@property (nonatomic, strong, readwrite) JMSGUser *user;
@property (nonatomic, strong, readwrite) MMMineTableViewInfoItem* infoItem;

@end

@implementation MMMineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 设置右边的一个小箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutWithInfoItem:(MMMineTableViewInfoItem *)infoItem {
    self.infoItem = infoItem;
    self.textLabel.text = self.infoItem.text;
    
    self.user = [JMSGUser myInfo];
    
    switch (self.infoItem.infoType) {
        case MMInfoTypeHeadPicture:
            NSLog(@"");
            break;
        case MMInfoTypeNickname:
            self.detailTextLabel.text = self.user.nickname;
            break;
        case MMInfoTypeBirthday:
            NSLog(@"");
            break;
        case MMInfoTypeGender:
            NSLog(@"");
            break;
        case MMInfoTypeAddress:
            NSLog(@"");
            break;
        case MMInfoTypeSignature:
            self.detailTextLabel.text = self.user.signature;
            self.detailTextLabel.numberOfLines = 2;
            break;
    }
}

- (void)reLayoutWithInfoItem:(MMMineTableViewInfoItem *)infoItem {
    self.detailTextLabel.text = @"";
    [self layoutWithInfoItem:infoItem];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
