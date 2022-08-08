//
//  MMMoremessageTableViewCell.m
//  MMessage
//
//  Created by JiangNan on 2022/8/8.
//

#import "MMMoremessageTableViewCell.h"
#import "DJSingleton.h"

@interface MMMoremessageTableViewCell()

@end

@implementation MMMoremessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutWithRow:(NSInteger)row {
    DJSingleton *singleton = [DJSingleton sharedManager];
    JMSGUser *user = singleton.user;
    
    switch (row) {
        case 0:
        {
            self.textLabel.text = @"昵称";
            self.detailTextLabel.text = user.nickname;
            break;
        }
            
        case 1:
        {
            self.textLabel.text = @"生日";
            self.detailTextLabel.text = user.birthday;
            break;
        }
            
        case 2:
        {
            self.textLabel.text = @"性别";
            if (user.gender == kJMSGUserGenderMale) {
                self.detailTextLabel.text = @"男";
            } else if (user.gender == kJMSGUserGenderFemale) {
                self.detailTextLabel.text = @"女";
            } else {
                self.detailTextLabel.text = @"";
            }
            break;
        }
            
        case 3:
        {
            self.textLabel.text = @"地址";
            self.detailTextLabel.text = user.region;
            break;
        }
            
        case 4:
        {
            self.textLabel.text = @"签名";
            self.detailTextLabel.text = user.signature;
            self.detailTextLabel.numberOfLines = 2;
            break;
        }
            
        default:
            break;
    }
    
}


@end
