//
//  MMMineTableViewCell.m
//  MMessage
//
//  Created by JiangNan on 2022/8/1.
//

#import "MMScreen.h"
#import "MMMineTableViewCell.h"
#import "JMessage/JMessage.h"

@interface MMMineTableViewCell()

@property (nonatomic, strong, readwrite) JMSGUser *user;
@property (nonatomic, strong, readwrite) MMMineTableViewInfoItem* infoItem;
@property (nonatomic, strong, readwrite) UIImageView *headImageView;

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
            [self.contentView addSubview:({
                
                self.detailTextLabel.text = @"";
                
                NSLog(@"");
                
                self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - UI(39) - UI(75),
                                                                                   0,
                                                                                   UI(75),
                                                                                   UI(75))];
                self.headImageView.center = CGPointMake(self.headImageView.center.x,
                                                        self.infoItem.height / 2);
                if (self.user.avatar != nil) {
                    [self.user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                        if (data != nil) {
                            self->_headImageView.image = [UIImage imageWithData:data];
                        } else {
                            self->_headImageView.image = [UIImage imageNamed:@"head"];
                        }
                    }];
                } else {
                    self->_headImageView.image = [UIImage imageNamed:@"head"];
                }
                
                self.headImageView.layer.cornerRadius = UI(8);
                self.headImageView.layer.masksToBounds = YES;
                self.headImageView;
            })];
            break;

            
        case MMInfoTypeNickname:
            self.detailTextLabel.text = self.user.nickname;
            break;
        case MMInfoTypeBirthday:
            self.detailTextLabel.text = self.user.birthday;
            break;
        case MMInfoTypeGender:
            if (self.user.gender == kJMSGUserGenderMale) {
                self.detailTextLabel.text = @"男";
            } else if (self.user.gender == kJMSGUserGenderFemale) {
                self.detailTextLabel.text = @"女";
            } else {
                self.detailTextLabel.text = @"";
            }
            break;
        case MMInfoTypeAddress:
            self.detailTextLabel.text = self.user.address;
            break;
        case MMInfoTypeSignature:
            self.detailTextLabel.text = self.user.signature;
            self.detailTextLabel.numberOfLines = 2;
            break;
        case MMInfoTypeChangePassword:
            break;
    }
}

- (void)reLayoutWithInfoItem:(MMMineTableViewInfoItem *)infoItem {
    self.detailTextLabel.text = @"";
    if (self.headImageView != nil) {
        [self.headImageView removeFromSuperview];
        self.headImageView = nil;
    }
    [self layoutWithInfoItem:infoItem];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
