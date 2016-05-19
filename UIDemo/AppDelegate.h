//
//  AppDelegate.h
//  UIDemo
//
//  Created by YU on 16/4/19.
//  Copyright © 2016年 YU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CommonViewBGColor) {
    
    CommonViewBGColorwhiteColor = 0,
    CommonViewBGColorBlackColor = 1
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

