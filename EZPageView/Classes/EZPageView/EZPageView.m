//
//  EZPageView.m
//  EZPageView_Example
//
//  Created by 陈诚 on 2019/7/30.
//  Copyright © 2019 melo30. All rights reserved.
//

#import "EZPageView.h"
#import <Masonry/Masonry.h>

#define kButtonWidth 80

@interface EZPageView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *dataArray;//title数组

@property (nonatomic, assign) NSInteger selectedIndex;//当前选中的角标

@property (nonatomic, strong) UIFont *titleFont;//字体大小

@property (nonatomic, strong) UIColor *titleDefaultColor;//字体默认颜色

@property (nonatomic, strong) UIColor *titleSelectColor;//字体选中颜色

@property (nonatomic, assign) BOOL isShowBottomSlider;//是否需要加下滑块

@property (nonatomic, strong) UIButton *selectedBtn;//当前选中的button

@property (nonatomic, strong) UIView *slider;

@property (nonatomic, copy) SelectAtIndexBlock selectBlock;

@end

@implementation EZPageView

- (instancetype)initWithDataArray:(NSArray *)dataArray andSelectedIndex:(NSInteger)selectedIndex andSelectItem:(nonnull SelectAtIndexBlock)selectBlock{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
        
        _dataArray = dataArray;
        _selectedIndex = selectedIndex;
        _selectBlock = selectBlock;
        _titleFont = [UIFont systemFontOfSize:12];
        _titleDefaultColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0f];
        _titleSelectColor = [UIColor colorWithRed:0.0/255.0 green:160.0/255.0 blue:255.0/255.0 alpha:1.0f];
        _isShowBottomSlider = NO;
        
        [self initSubViews];
        
    }
    return self;
}

- (instancetype)initWithDataArray:(NSArray *)dataArray andSelectedIndex:(NSInteger)selectedIndex andTitleFont:(UIFont *)titleFont andTitleDefaultColor:(UIColor *)titleDefaultColor andTitleSelectColor:(UIColor *)titleSelectColor andIsShowBottomSlider:(BOOL)isShowBottomSlider andSelectItem:(SelectAtIndexBlock)selectBlock{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
        
        _dataArray = dataArray;
        _selectedIndex = selectedIndex;
        _titleFont = titleFont;
        _titleDefaultColor = titleDefaultColor;
        _titleSelectColor = titleSelectColor;
        _isShowBottomSlider = isShowBottomSlider;
        _selectBlock = selectBlock;
        
        [self initSubViews];
    }
    return self;
}

#pragma mark - private
- (void)initSubViews {
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    __weak typeof(self)wself = self;
    if (self.dataArray.count > 0) {
        if (self.dataArray.count < 5) {//小于5个，不加scrollView，直接平分
            [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *btn = [UIButton new];
                btn.tag = idx;
                btn.titleLabel.font = wself.titleFont;
                [btn setTitle:wself.dataArray[idx] forState:UIControlStateNormal];
                [btn setTitleColor:wself.titleDefaultColor forState:UIControlStateNormal];
                [btn setTitleColor:wself.titleSelectColor forState:UIControlStateSelected];
                [btn addTarget:wself action:@selector(btnClickedEvent:) forControlEvents:UIControlEventTouchUpInside];
                btn.frame = CGRectMake(idx * [UIScreen mainScreen].bounds.size.width / wself.dataArray.count, 0, [UIScreen mainScreen].bounds.size.width / wself.dataArray.count, wself.frame.size.height);
                [wself addSubview:btn];
                if (idx == wself.selectedIndex) {
                    btn.selected = YES;
                    wself.selectedBtn = btn;
                    
                    if (wself.isShowBottomSlider) {
                        wself.slider = [UIView new];
                        wself.slider.backgroundColor = wself.titleSelectColor;
                        [wself addSubview:wself.slider];
                        [wself.slider mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.mas_equalTo(btn.mas_centerX);
                            make.bottom.mas_equalTo(wself);
                            make.width.mas_equalTo(50);
                            make.height.mas_equalTo(2);
                        }];
                    }
                }
            }];
        }else {//大于5个，加scrollView滑动
            [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *btn = [UIButton new];
                btn.tag = idx;
                btn.titleLabel.font = wself.titleFont;
                [btn setTitle:wself.dataArray[idx] forState:UIControlStateNormal];
                [btn setTitleColor:wself.titleDefaultColor forState:UIControlStateNormal];
                [btn setTitleColor:wself.titleSelectColor forState:UIControlStateSelected];
                [btn addTarget:wself action:@selector(btnClickedEvent:) forControlEvents:UIControlEventTouchUpInside];
                btn.frame = CGRectMake(idx * kButtonWidth, 0, kButtonWidth, wself.frame.size.height);
                [wself.scrollView addSubview:btn];
                if (idx == wself.selectedIndex) {
                    btn.selected = YES;
                    wself.selectedBtn = btn;
                    
                    if (wself.isShowBottomSlider) {
                        wself.slider = [UIView new];
                        wself.slider.backgroundColor = wself.titleSelectColor;
                        [wself addSubview:wself.slider];
                        [wself.slider mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.mas_equalTo(btn.mas_centerX);
                            make.bottom.mas_equalTo(wself);
                            make.width.mas_equalTo(50);
                            make.height.mas_equalTo(2);
                        }];
                    }
                    
                    
                    if ((idx + 1) * kButtonWidth >= [UIScreen mainScreen].bounds.size.width) {//选中的按钮超过屏幕范围
                        wself.scrollView.contentOffset = CGPointMake(kButtonWidth * idx, 0);
                    }
                }
            }];
        }
    }else {
        return;
    }
    self.scrollView.contentSize = CGSizeMake(self.dataArray.count * kButtonWidth, 0);
}

#pragma mark - HandleEvent
- (void)btnClickedEvent:(UIButton *)sender {
    if ([sender isEqual:_selectedBtn]) {
        return;
    }
    sender.selected = YES;
    _selectedBtn.selected = NO;
    _selectedBtn = sender;
    _selectedIndex = sender.tag;
    
    if (self.selectBlock) {
        self.selectBlock(sender.tag);
    }
    
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {//这里不能用mas_updateConstraints要用mas_remakeConstraints，先删除以前的布局再更新
        make.centerX.mas_equalTo(sender.mas_centerX);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
    }];
}


#pragma mark - LazyLoad
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

@end
