//
//  DPTakePhotoController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTakePhotoController.h"
#import "DPTakePhotoView.h"

@interface DPTakePhotoController ()<AFBaseTableViewDelegate,DPTakePhotoViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    DPTakePhotoView *m_pTakePhotoView;
}
@end

@implementation DPTakePhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTopBar.hidden = YES;
    m_pTakePhotoView = [[DPTakePhotoView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pTakePhotoView.proDelegate = self;
    m_pTakePhotoView.takePhotoDelegate = self;
    [self.view addSubview:m_pTakePhotoView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AFBaseTableViewDelegate
- (void)PopPreviousPage
{
    [self Back];
}

#pragma mark - DPTakePhotoViewDelegate
- (void)TakePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        m_pTakePhotoView.righthand = 1;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
