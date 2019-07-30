//
//  EZPageView.h
//  EZPageView_Example
//
//  Created by 陈诚 on 2019/7/30.
//  Copyright © 2019 melo30. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectAtIndexBlock)(NSInteger index);

@interface EZPageView : UIView

/**
 全能初始化方法1
 
 @param dataArray 标题数组
 @param selectedIndex 当前选中的角标
 @return self
 */
- (instancetype)initWithDataArray:(NSArray *)dataArray andSelectedIndex:(NSInteger)selectedIndex andSelectItem:(SelectAtIndexBlock)selectBlock;

/**
 全能初始化方法2
 
 @param dataArray 标题数组
 @param selectedIndex 当前选中的角标
 @param titleFont 字体大小
 @param titleDefaultColor 字体默认颜色
 @param titleSelectColor 字体选中颜色
 @param isShowBottomSlider 需不需要加下滑块，默认NO
 @return self
 */
- (instancetype)initWithDataArray:(NSArray *)dataArray andSelectedIndex:(NSInteger)selectedIndex andTitleFont:(UIFont *)titleFont andTitleDefaultColor:(UIColor *)titleDefaultColor andTitleSelectColor:(UIColor *)titleSelectColor andIsShowBottomSlider:(BOOL)isShowBottomSlider andSelectItem:(SelectAtIndexBlock)selectBlock;

@end

NS_ASSUME_NONNULL_END
