//
//  DJListItem.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/29.
//

#import "DJListItem.h"

@implementation DJListItem


- (void)LoadUserDataModel:(JMSGUser *)user{
    
    _isFriend = user.isFriend;
    _isDisturb = user.isNoDisturb;
    _isInBlacklist = user.isInBlacklist;
   // _uid = (NSString *)user.uid;
    _username = user.username;
    _avater = user.avatar;
    _birthday = user.birthday;
    _region = user.region;
    //_password = user.password;
    _address = user.address;
    _noteName = user.noteName;
    _noteText = user.noteText;
    _appKey = user.appKey;
    
    //_avatarData = user.thumbAvatarLocalPath;
    
    
    
}



@end
