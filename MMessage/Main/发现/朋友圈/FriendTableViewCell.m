//
//  FriendTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/9/11.
//

#import "FriendTableViewCell.h"
#import "JMessage/JMessage.h"

@implementation FriendTableViewCell


- (void)loadFriendCell:(NSMutableArray *)item{
    [self setCellFrame:item];
    [self setCellData:item];
}

///加载数据
- (void)setCellData:(NSMutableArray *)item{
    JMSGMessage *message1 = item[0];
    
    //头像数据
    if([[NSUserDefaults standardUserDefaults] objectForKey:message1.fromUser.username]){/**如果本地有图片*/
        NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:message1.fromUser.username];
        _profile_image_url.image = [UIImage imageWithData:imageData];
    }
    else{/**如果本地没有图片，网络获取并存入本地*/
        if(message1.fromUser.avatar){/**如果用户有头像*/
            NSArray *array=[[NSArray alloc] initWithObjects:message1.fromUser.username,nil]; /**获得对方账号的userdata存入array中*/
            [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) { /**通过对方的userdata获取对方的信息*/
                JMSGUser *user = resultObject[0]; /**返回对象即为对方的user*/
                [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) { /**从网络请求头像数据*/
                    self.profile_image_url.image = [UIImage imageWithData:data]; /**更新UI数据*/
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{/**在子线程中将头像数据存入本地磁盘*/
                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:message1.fromUser.username];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    });
                }];
            }];
        }
    }
    
    //昵称数据
    if(message1.fromUser.nickname) {
        _screen_name.text = message1.fromUser.nickname;
    }
    else {
        _screen_name.text = message1.fromUser.username;
    }
    
    //发布时间
    _created_at.text = [self handleDate:[message1.timestamp description]];

    //内容
    /**如果有文字信息*/
    if(message1.contentType == kJMSGContentTypeText) {
        JMSGTextContent *textcontent = (JMSGTextContent *)message1.content;
        _text.text = textcontent.text;
        switch (item.count) {
            case 2:
                [self loadOneImage:item number:item.count-1];   break;
            case 3:
                [self loadTwoImage:item number:item.count-1];   break;
            case 4:
                [self loadThreeImage:item number:item.count-1];   break;
            case 5:
                [self loadFourImage:item number:item.count-1];   break;
            case 6:
                [self loadFiveImage:item number:item.count-1];   break;
            case 7:
                [self loadSixImage:item number:item.count-1];   break;
            case 8:
                [self loadSevenImage:item number:item.count-1];   break;
            case 9:
                [self loadEightImage:item number:item.count-1];   break;
            case 10:
                [self loadNineImage:item number:item.count-1];   break;
        }
    }
    /**如果是纯图片*/
    else{
        if(message1.contentType == kJMSGContentTypeImage) {
            switch (item.count) {
                case 1:
                    [self loadOneImage:item number:item.count];   break;
                case 2:
                    [self loadTwoImage:item number:item.count];   break;
                case 3:
                    [self loadThreeImage:item number:item.count];   break;
                case 4:
                    [self loadFourImage:item number:item.count];   break;
                case 5:
                    [self loadFiveImage:item number:item.count];   break;
                case 6:
                    [self loadSixImage:item number:item.count];   break;
                case 7:
                    [self loadSevenImage:item number:item.count];   break;
                case 8:
                    [self loadEightImage:item number:item.count];   break;
                case 9:
                    [self loadNineImage:item number:item.count];   break;
            }
        }
    }
}

///加载位置
- (void)setCellFrame:(NSMutableArray *)item{
    //如果是事件消息(创建群组)
    if(_text == nil && _thumbnail_pic1 == nil){
        _cell_Height = 0;
    }
    else{
        /**头像Frame*/
        self.profile_image_url.layer.masksToBounds=YES; //设置圆角
        self.profile_image_url.layer.cornerRadius=25;
        CGFloat profile_image_url_X = 10;
        CGFloat profile_image_url_Y = 10;
        CGFloat profile_image_url_Width = 50;
        CGFloat profile_image_url_Height = 50;
        [self.profile_image_url setFrame:CGRectMake(profile_image_url_X, profile_image_url_Y, profile_image_url_Width, profile_image_url_Height)];
        
        /**昵称Frame*/
        CGFloat screen_name_X = 70;
        CGFloat screen_name_Y = 10;
        CGFloat screen_name_Width = 150;
        CGFloat screen_name_Height = 25;
        [self.screen_name setFrame:CGRectMake(screen_name_X, screen_name_Y, screen_name_Width, screen_name_Height)];
        [self.screen_name setFont:[UIFont systemFontOfSize:18.0]];
        [self.screen_name setTextAlignment:NSTextAlignmentLeft];
        
        /**设置时间*/
        CGFloat created_at_X = screen_name_X;
        CGFloat created_at_Y = screen_name_Y + screen_name_Height + 5;
        CGFloat created_at_Width = 150;
        CGFloat created_at_Height = 15;
        [self.created_at setFrame:CGRectMake(created_at_X, created_at_Y, created_at_Width, created_at_Height)];
        [self.created_at setFont:[UIFont systemFontOfSize:11.0]];
        [self.created_at setTextAlignment:NSTextAlignmentLeft];

        /**文字内容*/
        JMSGMessage *message = item[0];
        if(message.contentType == kJMSGContentTypeText) {
            JMSGTextContent *textcontent = (JMSGTextContent *)message.content;
            _text.text = textcontent.text;
            self.text.numberOfLines = 0;
            CGSize size = [_text sizeThatFits:CGSizeMake(370, MAXFLOAT)];/**假设有多行，自适应高度*/
            CGFloat text_X = 10;
            CGFloat text_Y = 70;
            CGFloat text_Width = 370;
            _text_Height = size.height;
            [self.text setFrame:CGRectMake(text_X, text_Y, text_Width, _text_Height)];
            [self.text setTextAlignment:NSTextAlignmentLeft];
            if(item.count == 1) {
                _cell_Height = 80 + _text_Height;
            }
        }
      
    }
    
}





///加载一张图片
- (void)loadOneImage:(NSMutableArray *)item number:(NSUInteger)count {
    self.thumbnail_pic1.image = [self storageImage:item number:count].image;
    
    CGFloat Image_Y = _text_Height + 80;
    [self.thumbnail_pic1 setFrame:CGRectMake(20, Image_Y, 360, 240)];
    
    _cell_Height = Image_Y + 260;
    
    
}

///加载两张图片
- (void)loadTwoImage:(NSMutableArray *)item number:(NSUInteger)count {
    [self loadOneImage:item number:count-1];
    self.thumbnail_pic2.image = [self storageImage:item number:count].image;
    
    CGFloat Image_Y = _text_Height + 80;
    [self.thumbnail_pic1 setFrame:CGRectMake(10, Image_Y, 180, 180)];
    [self.thumbnail_pic2 setFrame:CGRectMake(200, Image_Y, 180, 180)];
    
    _cell_Height = Image_Y + 200;
 
}

///加载三张图片
- (void)loadThreeImage:(NSMutableArray *)item number:(NSUInteger)count {
    [self loadTwoImage:item number:count-1];
    self.thumbnail_pic3.image = [self storageImage:item number:count].image;
    
    CGFloat Image_Y = _text_Height + 80;
    CGFloat Image_Width = 350/3;
    [self.thumbnail_pic1 setFrame:CGRectMake(10, Image_Y, Image_Width, Image_Width)];
    [self.thumbnail_pic2 setFrame:CGRectMake(20+Image_Width, Image_Y, Image_Width, Image_Width)];
    [self.thumbnail_pic3 setFrame:CGRectMake(30+Image_Width*2, Image_Y, Image_Width, Image_Width)];

    _cell_Height = Image_Y + Image_Width + 20;
    
}

///加载四张图片
- (void)loadFourImage:(NSMutableArray *)item number:(NSUInteger)count {
    [self loadThreeImage:item number:count-1];
    self.thumbnail_pic4.image = [self storageImage:item number:count].image;
    
    CGFloat Image_Y = _text_Height + 80;
    CGFloat Image_Width = 180;
    [self.thumbnail_pic1 setFrame:CGRectMake(10, Image_Y, Image_Width, Image_Width)];
    [self.thumbnail_pic2 setFrame:CGRectMake(20+Image_Width, Image_Y, Image_Width, Image_Width)];
    [self.thumbnail_pic3 setFrame:CGRectMake(10, Image_Y+Image_Width+10, Image_Width, Image_Width)];
    [self.thumbnail_pic4 setFrame:CGRectMake(20+Image_Width, Image_Y+Image_Width+10, Image_Width, Image_Width)];

    _cell_Height = Image_Y + Image_Width*2 + 30;
}

///加载五张图片
- (void)loadFiveImage:(NSMutableArray *)item number:(NSUInteger)count {
    [self loadFourImage:item number:count-1];
    self.thumbnail_pic5.image = [self storageImage:item number:count].image;
}

///加载六张图片
- (void)loadSixImage:(NSMutableArray *)item number:(NSUInteger)count {
    [self loadFiveImage:item number:count-1];
    self.thumbnail_pic6.image = [self storageImage:item number:count].image;
}

///加载七张图片
- (void)loadSevenImage:(NSMutableArray *)item number:(NSUInteger)count {
    [self loadSixImage:item number:count-1];
    self.thumbnail_pic7.image = [self storageImage:item number:count].image;
}

///加载八张图片
- (void)loadEightImage:(NSMutableArray *)item number:(NSUInteger)count {
    [self loadSevenImage:item number:count-1];
    self.thumbnail_pic8.image = [self storageImage:item number:count].image;
}

///加载九张图片
- (void)loadNineImage:(NSMutableArray *)item number:(NSUInteger)count {
    [self loadNineImage:item number:count-1];
    self.thumbnail_pic9.image = [self storageImage:item number:count].image;
}


///存取图片
- (UIImageView *)storageImage:(NSMutableArray *)item number:(NSUInteger)count{
    JMSGMessage *message1 = item[0];
    JMSGMessage *message;
    if(message1.contentType == kJMSGContentTypeText) {
        message = item[count];
    }
    else {
        message = item[count-1];
    }
    JMSGImageContent *imagecontent = (JMSGImageContent *)message.content;
    UIImageView *imageView = [[UIImageView alloc] init];
     if([[NSUserDefaults standardUserDefaults] objectForKey:[message.timestamp stringValue]]){/**本地已经储存*/
         imageView.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:[message.timestamp stringValue]]];
     }
     else{/**本地为储存*/
         [imagecontent thumbImageData:^(NSData *data, NSString *objectId, NSError *error) {
             imageView.image = [UIImage imageWithData:data];
             /**子线程中将图片存入本地*/
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 [[NSUserDefaults standardUserDefaults] setObject:data forKey:[message.timestamp stringValue]];
                 [[NSUserDefaults standardUserDefaults] synchronize];
             });
         }];
     }
    return imageView;
}



///时间戳格式化
- (NSString *)handleDate:(NSString *)time_Stamp{

    NSMutableString *str;
    NSDate *date = [NSDate date];
    NSTimeInterval cur_time = date.timeIntervalSince1970;

    NSTimeInterval result = cur_time - [time_Stamp doubleValue]/1000.0;

    NSDateFormatter *dataFormatter1 = [NSDateFormatter new];
    [dataFormatter1 setDateFormat:@"MM-dd HH:mm"];

    NSDateFormatter *dataFormatter2 = [NSDateFormatter new];
    [dataFormatter2 setDateFormat:@"yyyy-MM-dd"];

    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:[time_Stamp doubleValue]/1000.0];

    NSString *str1 = [NSMutableString stringWithFormat:@"%@",[dataFormatter2 stringFromDate:newDate]];
    NSString *str2 = [NSMutableString stringWithFormat:@"%@",[dataFormatter2 stringFromDate:date]];

    if([[str1 substringWithRange:NSMakeRange(0,4)] isEqualToString:[str2 substringWithRange:NSMakeRange(0,4)]]){
        if(result < 60 && result > 0) {
            str = [NSMutableString stringWithFormat:@"刚刚"];
        }
        if(result >= 60 && result < 3600 ) {
            str = [NSMutableString stringWithFormat:@"%d分钟前",(int)result/60];
        }
        if(result >= 3600) {
            str = [NSMutableString stringWithFormat:@"%@",[dataFormatter1 stringFromDate:newDate]];
        }
    }
    else{
        str = [NSMutableString stringWithFormat:@"%@",[dataFormatter2 stringFromDate:newDate]];
    }
    return str;
}





///重写初始化方法 创造控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        //用户头像
        [self.contentView addSubview:({
            self.profile_image_url = [[UIImageView alloc] initWithFrame:CGRectZero];
            self.profile_image_url.contentMode=UIViewContentModeScaleAspectFit;
            self.profile_image_url;
        })];
        //昵称
        [self.contentView addSubview:({
            self.screen_name = [[UILabel alloc] init];
            self.screen_name;
        })];
        //发表时间
        [self.contentView addSubview:({
            self.created_at = [[UILabel alloc] init];
            self.created_at;
        })];
        //文字内容
        [self.contentView addSubview:({
            self.text = [[UILabel alloc] init];
            self.text;
        })];
        //图片内容
        [self.contentView addSubview:({
            self.thumbnail_pic1 = [[UIImageView alloc] initWithFrame:CGRectZero];
            self.thumbnail_pic1.contentMode=UIViewContentModeScaleAspectFit;
            self.thumbnail_pic1;
        })];
        [self.contentView addSubview:({
            self.thumbnail_pic2 = [[UIImageView alloc] initWithFrame:CGRectZero];
            self.thumbnail_pic2.contentMode=UIViewContentModeScaleAspectFit;
            self.thumbnail_pic2;
        })];
        [self.contentView addSubview:({
            self.thumbnail_pic3 = [[UIImageView alloc] initWithFrame:CGRectZero];
            self.thumbnail_pic3.contentMode=UIViewContentModeScaleAspectFit;
            self.thumbnail_pic3;
        })];
        [self.contentView addSubview:({
            self.thumbnail_pic4 = [[UIImageView alloc] initWithFrame:CGRectZero];
            self.thumbnail_pic4.contentMode=UIViewContentModeScaleAspectFit;
            self.thumbnail_pic4;
        })];
        [self.contentView addSubview:({
            self.thumbnail_pic5 = [[UIImageView alloc] initWithFrame:CGRectZero];
            self.thumbnail_pic5.contentMode=UIViewContentModeScaleAspectFit;
            self.thumbnail_pic5;
        })];
        [self.contentView addSubview:({
            self.thumbnail_pic6 = [[UIImageView alloc] initWithFrame:CGRectZero];
            self.thumbnail_pic6.contentMode=UIViewContentModeScaleAspectFit;
            self.thumbnail_pic6;
        })];
        
        //转发按钮
        [self.contentView addSubview:({
            self.btnreposts=[UIButton buttonWithType:UIButtonTypeCustom];
            self.btnreposts;
        })];
        //转发图片
        [self.contentView addSubview:({
            self.reposts=[[UIImageView alloc] init];
            self.reposts;
        })];
        //转发数
        [self.contentView addSubview:({
            self.reposts_count=[[UILabel alloc] init];
            self.reposts_count;
        })];
        //评论按钮
        [self.contentView addSubview:({
            self.btncomments=[UIButton buttonWithType:UIButtonTypeCustom];
            self.btncomments;
        })];
        //评论图片
        [self.contentView addSubview:({
            self.comments=[[UIImageView alloc] init];
            self.comments;
        })];
        //评论数
        [self.contentView addSubview:({
            self.comments_count=[[UILabel alloc] init];
            self.comments_count;
        })];
        //点赞按钮
        [self.contentView addSubview:({
            self.btnattitudes=[UIButton buttonWithType:UIButtonTypeCustom];
            self.btnattitudes;
        })];
        //点赞图片
        [self.contentView addSubview:({
            self.attitudes=[[UIImageView alloc] init];
            self.attitudes;
        })];
        //点赞数
        [self.contentView addSubview:({
            self.attitudes_count=[[UILabel alloc] init];
            self.attitudes_count;
        })];
        
    }
    return self;
}







@end
