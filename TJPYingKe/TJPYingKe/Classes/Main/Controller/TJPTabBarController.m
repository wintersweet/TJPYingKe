//
//  TJPTabBarController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPTabBarController.h"
#import "TJPCameraLivingController.h"
#import "TJPNavigationController.h"

#import "UIImage+TJPImage.h"
#import "TJPTabBar.h"

@interface TJPTabBarController ()

@end

@implementation TJPTabBarController

+ (instancetype)shareInstance
{
    static TJPTabBarController *tabBarC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarC = [[TJPTabBarController alloc] init];
    });
    return tabBarC;
}

+ (instancetype)tabBarControllerWitnAddChildVCBlock:(void (^)(TJPTabBarController *))addVCBlock
{
    TJPTabBarController *tabBarVC = [[TJPTabBarController alloc] init];
    if (addVCBlock) {
        addVCBlock(tabBarVC);
    }
    return tabBarVC;
}


- (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired
{
    if (isRequired) {
        TJPNavigationController *nav = [[TJPNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

        [self addChildViewController:nav];
    }else {
        [self addChildViewController:vc];
    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
    
}

- (void)setupTabBar
{
    TJPTabBar *tabbar = [[TJPTabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    [tabbar setCenterBtnClickBlock:^{
        [self presentViewController:[TJPCameraLivingController new] animated:YES completion:nil];
    }];
    
}

@end
