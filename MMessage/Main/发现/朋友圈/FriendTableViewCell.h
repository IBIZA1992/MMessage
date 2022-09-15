//
//  FriendTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendTableViewCell : UITableViewCell
///用户头像
@property(nonatomic, strong, readwrite) UIImageView *profile_image_url;
///用户昵称
@property(nonatomic, strong, readwrite) UILabel *screen_name;
///发朋友圈时间
@property(nonatomic, strong, readwrite) UILabel *created_at;
///文字内容
@property(nonatomic, strong, readwrite) UILabel *text;
///网页链接按钮
@property(nonatomic, strong, readwrite) UIButton *btnURL;
///网页链接
@property(nonatomic, strong, readwrite) UILabel *URL;
///图片内容
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic1;
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic2;
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic3;
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic4;
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic5;
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic6;
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic7;
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic8;
@property(nonatomic, strong, readwrite) UIImageView *thumbnail_pic9;
///转发按钮
@property(nonatomic, strong, readwrite) UIButton *btnreposts;
///转发数
@property(nonatomic, strong, readwrite) UILabel *reposts_count;
///转发图标
@property(nonatomic, strong, readwrite) UIImageView *reposts;
///评论按钮
@property(nonatomic, strong, readwrite) UIButton *btncomments;
///评论数
@property(nonatomic, strong, readwrite) UILabel *comments_count;
///评论图标
@property(nonatomic, strong, readwrite) UIImageView *comments;
///点赞按钮
@property(nonatomic, strong, readwrite) UIButton *btnattitudes;
///点赞数
@property(nonatomic, strong, readwrite) UILabel *attitudes_count;
///点赞图标
@property(nonatomic, strong, readwrite) UIImageView *attitudes;



///cell的高度
@property(nonatomic) CGFloat cell_Height;
///text的高度
@property(nonatomic) CGFloat text_Height;


///自定义cell
- (void)loadFriendCell:(NSMutableArray *)item;


@end

NS_ASSUME_NONNULL_END
