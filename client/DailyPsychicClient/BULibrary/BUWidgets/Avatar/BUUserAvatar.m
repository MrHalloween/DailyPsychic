//
//  BUUserAvatar.m
//  pbuBaseLibrary
//
//  Created by zhanghe on 2018/1/16.
//  Copyright © 2018年 1bu2bu. All rights reserved.
//

#import "BUUserAvatar.h"
#import "BUUserDetailsController.h"

@implementation BUUserAvatar

- (instancetype)init
{
    if (self = [super init]) {
        [self addTarget:self action:@selector(enterUserDetails:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

+ (instancetype)userAvatarWithType:(UserAvatarType)userAvatarType
{
    BUUserAvatar *userAvatar = [[BUUserAvatar alloc]init];
    userAvatar.userAvatarType = userAvatarType;
    return userAvatar;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    switch (self.userAvatarType) {
        case UserAvatarTypeCircle:
        {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = bounds.size.width * 0.5;
        }
            break;
        case UserAvatarTypeSquare:
        {
            
        }
            break;
        case UserAvatarTypeRoundedRect:
        {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = 5;
        }
            break;
            
        default:
            break;
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    switch (self.userAvatarType) {
        case UserAvatarTypeCircle:
        {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = frame.size.width * 0.5;
        }
            break;
        case UserAvatarTypeSquare:
        {
            
        }
            break;
        case UserAvatarTypeRoundedRect:
        {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = 5;
        }
            break;
            
        default:
            break;
    }
}

- (void)setUserAvatarType:(UserAvatarType)userAvatarType
{
    _userAvatarType = userAvatarType;
    switch (self.userAvatarType) {
        case UserAvatarTypeCircle:
        {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = self.frame.size.width * 0.5;
        }
            break;
        case UserAvatarTypeSquare:
        {
            
        }
            break;
        case UserAvatarTypeRoundedRect:
        {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = 5;
        }
            break;
            
        default:
            break;
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    [self setBackgroundImage:placeholderImage forState:0];
    [self setBackgroundImage:placeholderImage forState:UIControlStateHighlighted];
}

- (void)setImageUrlString:(NSString *)imageUrlString
{
    _imageUrlString = imageUrlString;
    UIImage *userAvatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlString]]];
    [self setBackgroundImage:userAvatar forState:0];
    [self setBackgroundImage:userAvatar forState:UIControlStateHighlighted];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self setBackgroundImage:image forState:0];
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (void)setUserId:(NSString *)userId
{
    _userId = userId;
}

#pragma mark - 进入用户详情页
- (void)enterUserDetails:(UIButton *)argButton
{
    if (self.userId) {
        UIViewController *pSelfController = [self LocationController];
        BUUserDetailsController *pPersonController = [[BUUserDetailsController alloc] init];
        pPersonController.userId = self.userId;
        
        if([pSelfController isKindOfClass:[BUCustomViewController class]]){
            BUCustomViewController *pSelfController = (BUCustomViewController *)[self LocationController];
            [pSelfController PushChildViewController:pPersonController animated:YES];
        }else{
            [pSelfController.navigationController pushViewController:pPersonController animated:YES];
        }
        NSLog(@"进入用户%@的详情页",self.userId);
    }
}


#pragma mark - 点击换头像
- (void)setModifyAvatarEnabled:(BOOL)modifyAvatarEnabled
{
    _modifyAvatarEnabled = modifyAvatarEnabled;
    if (!modifyAvatarEnabled) {
        return;
    }
    [self addTarget:self action:@selector(changeAvatar:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)changeAvatar:(UIButton *)argButton
{
    UIViewController *pSelfController = [self LocationController];
    UIAlertController *pAlertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self.propDelegate;
        picker.allowsEditing = YES;
        [pSelfController presentViewController:picker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self.propDelegate;
        picker.allowsEditing = YES;
        [pSelfController presentViewController:picker animated:YES completion:nil];
        
    }];
    
    [pAlertVC addAction:cancelAction];
    [pAlertVC addAction:cameraAction];
    [pAlertVC addAction:photoAction];
    [pSelfController presentViewController:pAlertVC animated:YES completion:nil];
}

@end
