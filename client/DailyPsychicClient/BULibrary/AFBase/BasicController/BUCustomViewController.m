//
//  BUCustomViewController.m
//  DaoTingTuShuo
//
//  Created by -3 on 14-7-17.
//  Copyright (c) 2014年  MultiMedia Lab. All rights reserved.
//

#import "BUCustomViewController.h"

// This category (i.e. class extension) is a workaround to get the
// Image PickerController to appear in landscape mode.
@interface UIImagePickerController(Nonrotating)
- (BOOL)shouldAutorotate;
@end

@implementation UIImagePickerController(Nonrotating)

- (BOOL)shouldAutorotate
{
    return NO;
}
@end


@interface BUCustomViewController ()<UIGestureRecognizerDelegate>
{
    BOOL m_bIsMainPageViewController;    ///是否是分栏项主页面控制器
}

@end

@implementation BUCustomViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        m_bIsMainPageViewController = NO;
    }
    return self;
}

-(void)dealloc
{
    [AlertManager HideProgressHUD];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     NSLog(@"释放");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加一个全屏的滑动返回手势（系统导航控制器默认的滑动返回是边缘滑动返回）
    //handleNavigationTransition:是ios的私有方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.navigationController.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    pan.delegate = self;
//    [self.view addGestureRecognizer:pan];
    //禁用系统的手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    m_pTopBar =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAVIGATION_HEIGHT)];
    m_pTopBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:m_pTopBar];
    
    //Name Lable
    m_pNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65,NAVIGATION_BAR_Y, SCREEN_WIDTH-130, 45)];
    m_pNameLabel.backgroundColor = [UIColor clearColor];
    m_pNameLabel.textAlignment = NSTextAlignmentCenter;
    m_pNameLabel.textColor = [TextManager Color333];
    [m_pNameLabel setFont:[UIFont fontWithName:[TextManager RegularFont] size:19]];
    [m_pTopBar addSubview:m_pNameLabel];
    
    //Back button
    m_pBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0,NAVIGATION_BAR_Y,44.0f + 15 * [AppConfigure GetLengthAdaptRate], 44)];
    [m_pBackButton setExclusiveTouch:YES];
    [m_pBackButton setImage:[UIImage imageNamed:@"topbar_back.png"] forState:0];
    [m_pBackButton setImage:[UIImage imageNamed:@"topbar_back.png"] forState:UIControlStateHighlighted];
    [m_pBackButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [m_pBackButton setImageEdgeInsets:UIEdgeInsetsMake(0, 15 * [AppConfigure GetLengthAdaptRate], 0, 0)];
    [m_pBackButton addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [m_pTopBar addSubview:m_pBackButton];
    
    m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(m_pTopBar.frame) - 1, self.view.frame.size.width, 1)];
    m_pLineView.backgroundColor = UIColorFromHex(0xececec);
    [m_pTopBar addSubview:m_pLineView];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return YES;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (m_bIsMainPageViewController)
    {
        m_bIsMainPageViewController = NO;
//        [(AFTabBarViewController *)self.tabBarController ShowTabBar];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- target method
-(void)Back
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.propBackAction) {
        self.propBackAction(nil);
    }
}

#pragma mark -- public method
-(void)PushChildViewController:(UIViewController*)pController animated:(BOOL)animated
{
    m_bIsMainPageViewController = self.navigationController.viewControllers.count == 1;
//    [(AFTabBarViewController *)self.tabBarController HideTabBar];
    [self.navigationController pushViewController:pController animated:animated];
}
@end
