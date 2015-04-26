//
//  RLScrollerPagerView.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/14/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewBase.h"

typedef NS_ENUM(NSUInteger, ScrollPagerOption) {
    ScrollPagerOptionTabHeight,
    ScrollPagerOptionTabOffset,
    ScrollPagerOptionTabWidth,
    ScrollPagerOptionStartFromSecondTab,
    ScrollPagerOptionCenterCurrentTab
};

typedef NS_ENUM(NSUInteger, ScrollPagerComponent) {
    ScrollPagerIndicator,
    ScrollPagerTabsView,
};

@protocol RLScrollPagerDataSource;
@protocol RLScrollPagerDelegate;


#pragma mark - RLScrollerPagerView

@interface RLScrollPagerView : RLViewBase

@property id<RLScrollPagerDataSource> dataSource;
@property id<RLScrollPagerDelegate> delegate;

#pragma mark - ScrollPagerOptions

// Tab bar's height, defaults to 49.0
@property CGFloat tabHeight;

// Tab bar's offset from left, defaults to 56.0
@property CGFloat tabOffset;

// Any tab item's width, defaults to 128.0. To-do: make this dynamic
@property CGFloat tabWidth;

// 1.0: YES, 0.0: NO, defines if view should appear with the second or the first tab
// Defaults to NO
@property CGFloat startFromSecondTab;

// 1.0: YES, 0.0: NO, defines if tabs should be centered, with the given tabWidth
// Defaults to NO
@property CGFloat centerCurrentTab;

#pragma mark - Colors

// Colors for several parts
@property UIColor *indicatorColor;
@property UIColor *tabsViewBackgroundColor;
@property UIColor *contentViewBackgroundColor;

#pragma mark - Methods

// Reload all tabs and contents
- (void)reloadData;

@end


#pragma mark - dataSource
@protocol RLScrollPagerDataSource <NSObject>

// Asks dataSource how many tabs will be
- (NSUInteger)numberOfTabsForScrollPager:(RLScrollPagerView *)scrollPager;

// Asks dataSource to give a view to display as a tab item
// It is suggested to return a view with a clearColor background
// So that un/selected states can be clearly seen
- (UIView *)scrollPager:(RLScrollPagerView *)scrollPager viewForTabAtIndex:(NSUInteger)index;

@end


#pragma mark - delegate
@protocol RLScrollPagerDelegate <NSObject>

@optional

// delegate object must implement this method if wants to be informed when a tab changes
- (void)scrollPager:(RLScrollPagerView *)viewPager didChangeTabToIndex:(NSUInteger)index;

// Every time - reloadData called, ScrollPager will ask its delegate for option values
// So you don't have to set options from ScrollPager itself
- (CGFloat)scrollPager:(RLScrollPagerView *)viewPager valueForOption:(ScrollPagerOption)option withDefault:(CGFloat)value;

/*
 * Use this method to customize the look and feel.
 * ScrollPager will ask its delegate for colors for its components.
 * And if they are provided, it will use them, otherwise it will use default colors.
 * Also not that, colors for tab and content views will change the tabView's and contentView's background
 * (you should provide these views with a clearColor to see the colors),
 * and indicator will change its own color.
 */
- (UIColor *)scrollPager:(RLScrollPagerView *)viewPager colorForComponent:(ScrollPagerComponent)component withDefault:(UIColor *)color;

@end
