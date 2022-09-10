//
//  GroupDataViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/9/1.
//

#import "GroupDataViewController.h"
#import "GroupDataView.h"
#import "MMScreen.h"
#import "JMessage/JMessage.h"
#import "DJSingleton.h"
#import "GroupMemberTableViewCell.h"


@interface GroupDataViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, strong) GroupDataView *groupView;
@property(nonatomic, strong) DJSingleton *single;
@property(nonatomic, strong) UIImagePickerController *imageVC;
@property(nonatomic, strong) NSMutableArray *memberUserDataListArray;

@end

@implementation GroupDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _single = [DJSingleton sharedManager];

    _groupView = [[GroupDataView alloc] init];
    [_groupView loadGroupDataView];
    [_groupView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_groupView];
    
    _groupView.tableView.delegate = self;
    _groupView.tableView.dataSource = self;
    
    [_groupView.btngroupImage addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    [_groupView.btngroupName addTarget:self action:@selector(changeName) forControlEvents:UIControlEventTouchUpInside];
    
    /**图片选择器*/
    _imageVC = [[UIImagePickerController alloc] init];
    _imageVC.delegate = self;
    _imageVC.allowsEditing = YES;
    
    [JMSGGroup groupInfoWithGroupId:_single.groupID completionHandler:^(id resultObject, NSError *error) {
        JMSGGroup *group = resultObject;
        self.groupView.groupName.text = group.name;
        [group thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
            [self.groupView.btngroupImage setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        }];
     
    }];
    
    [self getGroupMemberList];
    
  
}


///更改群头像
- (void)changeImage {
    
    _single = [DJSingleton sharedManager];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        /**设置数据来源*/
        _imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        /**打开相机/相册/图库*/
        [self presentViewController:_imageVC animated:YES completion:nil];
    }
}

///修改群昵称
- (void)changeName {
    _single = [DJSingleton sharedManager];

//    [JMSGGroup updateGroupInfoWithGroupId:_single.groupID name:@"" desc:@"123" completionHandler:^(id resultObject, NSError *error) {
//
//    }];
    
}


/// 图片代理方法取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    /**退出当前界面  */
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/// 图片代理方法选择完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *str = [self contentTypeForImageData:imageData];
    [JMSGGroup updateGroupAvatarWithGroupId:_single.groupID avatarData:imageData avatarFormat:str completionHandler:^(id resultObject, NSError *error) {
        [self.groupView.btngroupImage setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
      
}

///判断图片格式
- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return @"未判断出来";
    }
    return @"未判断出来";
}


///获得成员列表
- (void)getGroupMemberList {
    
    _memberUserDataListArray = @[].mutableCopy;
    
    [JMSGGroup groupInfoWithGroupId:_single.groupID completionHandler:^(id resultObject, NSError *error) {
        JMSGGroup *group = resultObject;
        [group memberInfoList:^(id resultObject, NSError *error) {
            
            for(JMSGGroupMemberInfo *info in resultObject){
                JMSGUser *user = info.user;
                [self.memberUserDataListArray addObject:user];
            }
            [self.groupView.tableView reloadData];
        }];
    }];
    
    
}


//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _memberUserDataListArray.count;
}

//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

//tabelview内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GroupMemberTableViewCell *cell = [[GroupMemberTableViewCell alloc] init];
    JMSGUser *user = _memberUserDataListArray[indexPath.row];
    [cell loadGroupMemberCell:user];
    
    return cell;
    
}


@end
