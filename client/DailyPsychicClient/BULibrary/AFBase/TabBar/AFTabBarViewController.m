//
//  MainViewController.m
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import "AFTabBarViewController.h"
CGFloat const fTabBarHeight = 49.0f;

@interface AFTabBarViewController ()
{
    UIImageView *m_pTabBarBgImageV;
    AFTabBarItem *m_pSelectedBtn;
    NSInteger m_iLastSelectedIndex;
}

@end

@implementation AFTabBarViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [self LoadTabBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self ResetTabBarItemFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private method
- (void)LoadTabBar
{
    m_pTabBarBgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - fTabBarHeight, self.view.frame.size.width, fTabBarHeight)];
    m_pTabBarBgImageV.backgroundColor = [UIColor whiteColor];
    m_pTabBarBgImageV.userInteractionEnabled = YES;
    [self.view addSubview:m_pTabBarBgImageV];
    
    UIImageView *pLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, m_pTabBarBgImageV.size.width, 0.5f)];
    pLine.backgroundColor = UIColorFromHex(0xdedede);
    [m_pTabBarBgImageV addSubview:pLine];
    
    for (NSInteger i = 0; i < 5; i ++)
    {
        AFTabBarItem *pItemBtn = [[AFTabBarItem alloc] init];
        pItemBtn.frame = CGRectZero;
        pItemBtn.fHeightScale = 1.0f;
        [pItemBtn setTitleColor:kTitleNormalColor forState:UIControlStateNormal];
        [pItemBtn setTitleColor:kTitleSelectedColor forState:UIControlStateSelected];
        pItemBtn.titleLabel.font = kTitleFont;
        pItemBtn.tag = 100 + i;
        [pItemBtn addTarget:self action:@selector(SelectViewControllerItem:) forControlEvents:UIControlEventTouchUpInside];
        [m_pTabBarBgImageV addSubview:pItemBtn];
    }
}

- (void)ResetTabBarItemFrame
{
    AFTabBarItem *pItemBtn = [m_pTabBarBgImageV viewWithTag:100];
    if (![NSStringFromCGRect(pItemBtn.frame) isEqualToString:NSStringFromCGRect(CGRectZero)])
    {
        return;
    }
    CGFloat fWidth = self.view.frame.size.width / _propViewControllerClasses.count;
    for (NSInteger i = 0; i < _propViewControllerClasses.count; i ++)
    {
        AFTabBarItem *pItemBtn = [m_pTabBarBgImageV viewWithTag:100 + i];
        pItemBtn.frame = CGRectMake(fWidth * i, 0, fWidth, fTabBarHeight);
        if (i == 0)
        {
            [self SelectViewControllerItem:pItemBtn];
        }
    }
}

#pragma mark -- property method
- (void)setPropViewControllerClasses:(NSArray *)propViewControllerClasses
{
    _propViewControllerClasses = propViewControllerClasses;
    NSMutableArray *arrViewController = [NSMutableArray array];
    for (NSInteger i = 0; i < propViewControllerClasses.count; i ++)
    {
        if ([[propViewControllerClasses[i] class] isSubclassOfClass:[UIViewController class]])
        {
            Class class = (Class)propViewControllerClasses[i];
            UIViewController *pVC = [[class alloc]init];
            UINavigationController *pNVC = [[UINavigationController alloc]initWithRootViewController:pVC];
            pNVC.navigationBarHidden = YES;
            [arrViewController addObject:pNVC];
        }
    }
    [self setViewControllers:arrViewController];
}

- (void)setPropTabBarBackGroundImage:(UIImage *)propTabBarBackGroundImage
{
    m_pTabBarBgImageV.image = propTabBarBackGroundImage;
}

- (void)setPropTabBarNormalImages:(NSArray *)propTabBarNormalImages
{
    _propTabBarNormalImages = propTabBarNormalImages;
    for (NSInteger i = 0; i < propTabBarNormalImages.count; i ++)
    {
        AFTabBarItem *pItemBtn = [m_pTabBarBgImageV viewWithTag:100 + i];
        [pItemBtn setImage:[UIImage imageNamed:propTabBarNormalImages[i]] forState:UIControlStateNormal];
    }
}

- (void)setPropTabBarSelectedImages:(NSArray *)propTabBarSelectedImages
{
    _propTabBarSelectedImages = propTabBarSelectedImages;
    for (NSInteger i = 0; i < propTabBarSelectedImages.count; i ++)
    {
        AFTabBarItem *pItemBtn = [m_pTabBarBgImageV viewWithTag:100 + i];
        [pItemBtn setImage:[UIImage imageNamed:propTabBarSelectedImages[i]] forState:UIControlStateSelected];
    }
}

- (void)setPropTabBarTitles:(NSArray *)propTabBarTitles
{
    _propTabBarTitles = propTabBarTitles;
    for (NSInteger i = 0; i < propTabBarTitles.count; i ++)
    {
        AFTabBarItem *pItemBtn = [m_pTabBarBgImageV viewWithTag:100 + i];
        if (![propTabBarTitles[i] isEqualToString:@""] && propTabBarTitles[i] != nil) {
            pItemBtn.fHeightScale = 0.5f;
        } else {
            pItemBtn.fHeightScale = 1.0f;
        }
        [pItemBtn setTitle:propTabBarTitles[i] forState:UIControlStateNormal];
        [pItemBtn setTitle:propTabBarTitles[i] forState:UIControlStateSelected];
    }
}

#pragma mark -- target method
- (void)SelectViewControllerItem:(AFTabBarItem *)argBtn
{    
    [self setSelectedIndex:argBtn.tag - 100];
    m_pSelectedBtn.selected = NO;
    m_iLastSelectedIndex = m_pSelectedBtn.tag - 100;
    argBtn.selected = YES;
    m_pSelectedBtn = argBtn;
    UINavigationController *pCurrentNVC = self.selectedViewController;
    if ([pCurrentNVC.viewControllers firstObject] != [pCurrentNVC topViewController])
    {
        [self HideTabBar];
    }
    else
    {
        [self ShowTabBar];
    }
}

#pragma mark -- public method
- (void)SelectControllerIndex:(NSInteger)argIndex
{
    AFTabBarItem *pItemBtn = [m_pTabBarBgImageV viewWithTag:argIndex + 100];
    [self SelectViewControllerItem:pItemBtn];
}

- (void)SetBadgeNum:(NSInteger)argNum withType:(AFBadgeShowType)argType andIndex:(NSInteger)argIndex
{
    AFTabBarItem *pItemBtn = [m_pTabBarBgImageV viewWithTag:argIndex + 100];
    [pItemBtn SetBadgeNum:argNum withType:argType];
}

- (void)HideTabBar
{
    UINavigationController *pCurrentNVC = self.selectedViewController;
    UIViewController *pCurrentViewController = [pCurrentNVC.viewControllers firstObject];
    if (![m_pTabBarBgImageV.superview isEqual:pCurrentViewController.view]) {
            [pCurrentViewController.view addSubview:m_pTabBarBgImageV];
    }
}

- (void)ShowTabBar
{
    if (!IS_EMPTY_STRING(m_pSelectedBtn.currentTitle)){
        [self.view addSubview:m_pTabBarBgImageV];
    }
}

- (UIView *)TabbarView
{
    return m_pTabBarBgImageV;
}

- (NSInteger)LastSelectedViewControllerIndex
{
    return m_iLastSelectedIndex;
}

@end
