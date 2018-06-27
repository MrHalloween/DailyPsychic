//
//  DPSplashController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/6/24.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPSplashController.h"
#import "AppDelegate.h"

@interface DPSplashController ()

@end

@implementation DPSplashController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bg.image = [UIImage imageNamed:@"launch.png"];
    [self.view addSubview:bg];
    
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= 36; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"splash_%.2d",i]]];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //imageView的动画图片是数组images
    imageView.animationImages = images;
    //按照原始比例缩放图片，保持纵横比
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //切换动作的时间3秒，来控制图像显示的速度有多快，
    imageView.animationDuration = 2;
    //动画的重复次数，想让它无限循环就赋成0
    imageView.animationRepeatCount = 1;
    //开始动画
    [imageView startAnimating];
    //添加控件
    [bg addSubview:imageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [mAppDelegate EnterMainPage];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
