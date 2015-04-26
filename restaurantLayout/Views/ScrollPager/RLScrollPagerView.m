//
//  RLScrollerPagerView.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/14/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLScrollPagerView.h"
#import "RLScrollPagerTabView.h"

#pragma mark - constants

#define kDefaultTabHeight 44.0 // Default tab height
#define kDefaultTabOffset 56.0 // Offset of the second and further tabs' from left
#define kDefaultTabWidth 128.0

#define kDefaultStartFromSecondTab 0.0 // 1.0: YES, 0.0: NO
#define kDefaultCenterCurrentTab 0.0 // 1.0: YES, 0.0: NO

#define kDefaultIndicatorColor [UIColor colorWithRed:178.0/255.0 green:203.0/255.0 blue:57.0/255.0 alpha:0.75]
#define kDefaultTabsViewBackgroundColor [UIColor clearColor] //[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:0.75]
#define kDefaultContentViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:0.75]


#pragma mark - RLScrollerPagerView

@interface RLScrollPagerView () <UIScrollViewDelegate>

@property UIScrollView *tabsView;
@property NSMutableArray *tabs;

@property NSUInteger tabCount;
@property (getter = isAnimatingToTab, assign) BOOL animatingToTab;
@property (nonatomic) NSUInteger activeTabIndex;

@end

@implementation RLScrollPagerView

#pragma mark - initializer

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSettings];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSettings];
    }
    
    return self;
}

# pragma mark - event handler

- (IBAction)handleTapGesture:(id)sender {
    
    self.animatingToTab = YES;
    
    // Get the desired page's index
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIView *tabView = tapGestureRecognizer.view;
    __block NSUInteger index = [_tabs indexOfObject:tabView];
    
    // Set activeTabIndex
    self.activeTabIndex = index;
}

#pragma mark - Setter/Getter

- (void)setActiveTabIndex:(NSUInteger)activeTabIndex {
    
    RLScrollPagerTabView *activeTabView;
    
    // Set to-be-inactive tab unselected
    activeTabView = [self tabViewAtIndex:self.activeTabIndex];
    activeTabView.selected = NO;
    
    // Set to-be-active tab selected
    activeTabView = [self tabViewAtIndex:activeTabIndex];
    activeTabView.selected = YES;
    
    // Set current activeTabIndex
    _activeTabIndex = activeTabIndex;
    
    // Inform delegate about the change
    if ([self.delegate respondsToSelector:@selector(scrollPager:didChangeTabToIndex:)]) {
        [self.delegate scrollPager:self didChangeTabToIndex:self.activeTabIndex];
    }
    
    // Bring tab to active position
    // Position the tab in center if centerCurrentTab option provided as YES
    
    UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
    CGRect frame = tabView.frame;
    
    if (self.centerCurrentTab) {
        
        frame.origin.x += (frame.size.width / 2);
        frame.origin.x -= _tabsView.frame.size.width / 2;
        frame.size.width = _tabsView.frame.size.width;
        
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        
        if ((frame.origin.x + frame.size.width) > _tabsView.contentSize.width) {
            frame.origin.x = (_tabsView.contentSize.width - _tabsView.frame.size.width);
        }
    } else {
        
        frame.origin.x -= self.tabOffset;
        frame.size.width = self.tabsView.frame.size.width;
    }
    
    [_tabsView scrollRectToVisible:frame animated:YES];
}

#pragma mark - settings

- (void)defaultSettings {
    
    // Default settings
    _tabHeight = kDefaultTabHeight;
    _tabOffset = kDefaultTabOffset;
    _tabWidth = kDefaultTabWidth;
    
    _startFromSecondTab = kDefaultStartFromSecondTab;
    _centerCurrentTab = kDefaultCenterCurrentTab;
    
    // Default colors
    _indicatorColor = kDefaultIndicatorColor;
    _tabsViewBackgroundColor = kDefaultTabsViewBackgroundColor;
    _contentViewBackgroundColor = kDefaultContentViewBackgroundColor;
    
    self.animatingToTab = NO;
}

# pragma mark - action

- (void)reloadData {
    
    // Get settings if provided
    if ([self.delegate respondsToSelector:@selector(scrollPager:valueForOption:withDefault:)]) {
        
        _tabHeight = [self.delegate scrollPager:self valueForOption:ScrollPagerOptionTabHeight withDefault:kDefaultTabHeight];
        _tabOffset = [self.delegate scrollPager:self valueForOption:ScrollPagerOptionTabOffset withDefault:kDefaultTabOffset];
        _tabWidth = [self.delegate scrollPager:self valueForOption:ScrollPagerOptionTabWidth withDefault:kDefaultTabWidth];
        
        _startFromSecondTab = [self.delegate scrollPager:self valueForOption:ScrollPagerOptionStartFromSecondTab withDefault:kDefaultStartFromSecondTab];
        _centerCurrentTab = [self.delegate scrollPager:self valueForOption:ScrollPagerOptionCenterCurrentTab withDefault:kDefaultCenterCurrentTab];
    }
    
    // Get colors if provided
    if ([self.delegate respondsToSelector:@selector(scrollPager:colorForComponent:withDefault:)]) {
        _indicatorColor = [self.delegate scrollPager:self colorForComponent:ScrollPagerIndicator withDefault:kDefaultIndicatorColor];
        _tabsViewBackgroundColor = [self.delegate scrollPager:self colorForComponent:ScrollPagerTabsView withDefault:kDefaultTabsViewBackgroundColor];
    }
    
    // remove all tab views.
    [_tabsView removeFromSuperview];
    
    // Empty tabs and contents
    [_tabs removeAllObjects];
    
    _tabCount = [self.dataSource numberOfTabsForScrollPager:self];
    
    // Populate arrays with [NSNull null];
    _tabs = [NSMutableArray arrayWithCapacity:_tabCount];
    for (int i = 0; i < _tabCount; i++) {
        [_tabs addObject:[NSNull null]];
    }
    
    // Add tabsView
    float y = (self.frame.size.height - self.tabHeight) / 2.0f;
    _tabsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, y, self.frame.size.width, self.tabHeight)];
    _tabsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tabsView.backgroundColor = self.tabsViewBackgroundColor;
    _tabsView.showsHorizontalScrollIndicator = NO;
    _tabsView.showsVerticalScrollIndicator = NO;
    
    [self insertSubview:_tabsView atIndex:0];
    
    // Add tab views to _tabsView
    CGFloat contentSizeWidth = 0;
    for (int i = 0; i < _tabCount; i++) {
        
        UIView *tabView = [self tabViewAtIndex:i];
        CGRect frame = tabView.frame;
        frame.origin.x = contentSizeWidth;
        frame.size.width = self.tabWidth;
        tabView.frame = frame;
        
        [_tabsView addSubview:tabView];
        
        contentSizeWidth += tabView.frame.size.width;
        
        // To capture tap events
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [tabView addGestureRecognizer:tapGestureRecognizer];
    }
    
    _tabsView.contentSize = CGSizeMake(contentSizeWidth, self.tabHeight);
    
    // Set activeTabIndex
    self.activeTabIndex = self.startFromSecondTab;
}

#pragma mark - helper

- (RLScrollPagerTabView *)tabViewAtIndex:(NSUInteger)index {
    
    if (index >= _tabCount) return nil;
    
    if ([[_tabs objectAtIndex:index] isEqual:[NSNull null]]) {
        
        // Get view from dataSource
        UIView *tabViewContent = [self.dataSource scrollPager:self viewForTabAtIndex:index];
        
        // Create TabView and subview the content
        RLScrollPagerTabView *tabView = [[RLScrollPagerTabView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tabWidth, self.tabHeight)];
        [tabView addSubview:tabViewContent];
        [tabView setClipsToBounds:YES];
        [tabView setIndicatorColor:self.indicatorColor];
        
        tabViewContent.center = tabView.center;
        
        // Replace the null object with tabView
        [_tabs replaceObjectAtIndex:index withObject:tabView];
    }
    
    return [_tabs objectAtIndex:index];
}

- (NSUInteger)indexForTabView:(UIView *)tabView {
    
    return [_tabs indexOfObject:tabView];
}

#pragma mark - UIScrollViewDelegate, Responding to Scrolling and Dragging

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (![self isAnimatingToTab]) {
        UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
        
        // Get the related tab view position
        CGRect frame = tabView.frame;
        
        CGFloat movedRatio = (scrollView.contentOffset.x / scrollView.frame.size.width) - 1;
        frame.origin.x += movedRatio * frame.size.width;
        
        if (self.centerCurrentTab) {
            
            frame.origin.x += (frame.size.width / 2);
            frame.origin.x -= _tabsView.frame.size.width / 2;
            frame.size.width = _tabsView.frame.size.width;
            
            if (frame.origin.x < 0) {
                frame.origin.x = 0;
            }
            
            if ((frame.origin.x + frame.size.width) > _tabsView.contentSize.width) {
                frame.origin.x = (_tabsView.contentSize.width - _tabsView.frame.size.width);
            }
        } else {
            
            frame.origin.x -= self.tabOffset;
            frame.size.width = self.tabsView.frame.size.width;
        }
        
        [_tabsView scrollRectToVisible:frame animated:NO];
    }
}

@end
