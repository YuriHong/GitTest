//
//  UIView+Util.h
//  iosapp
//
//  Created by chenhaoxiang on 14-10-17.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)
/**
 *  设置view的圆角
 *
 *  @param cornerRadius 圆角的半径
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;
/**
 *  设置边框
 *
 *  @param width 线宽
 *  @param color 颜色
 */
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

/**
 *  截屏
 *
 *  @return view的截图
 */
- (UIImage *)convertViewToImage;
/**
 *  模糊处理View
 *
 *  @return void
 */
//- (UIImage *)updateBlur;

@end
