//
//  BUUserAvatar.h
//  pbuBaseLibrary
//
//  Created by zhanghe on 2018/1/16.
//  Copyright © 2018年 1bu2bu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BUUserAvatarModifyDelegate <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end;

typedef NS_ENUM(NSInteger, UserAvatarType) {
    UserAvatarTypeSquare = 0,
    UserAvatarTypeCircle = 1,
    UserAvatarTypeRoundedRect = 2
};

@interface BUUserAvatar : UIButton

+ (instancetype)userAvatarWithType:(UserAvatarType)userAvatarType;

@property (nonatomic,weak)id <BUUserAvatarModifyDelegate>propDelegate;

@property(nonatomic)                UserAvatarType userAvatarType;

///默认头像
@property(nonatomic,strong) UIImage             *placeholderImage;

///头像url
@property(nonatomic,copy) NSString                *imageUrlString;

///头像
@property(nonatomic,strong) UIImage                       *image;

///用户id
@property(nonatomic,copy) NSString                       *userId;

/*
 *是否允许修改头像
 *！！！！！！！请在info.plist里面增加以下key
 *！！！！！！！请设置propDelegate
 <key>NSCameraUsageDescription</key>
 <string>访问照相机</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>访问相册</string>
 */
@property(nonatomic) BOOL                     modifyAvatarEnabled;

@end
