//
//  RLScrollPagerTabView.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/14/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewBase.h"

// TabView for tabs, that provides un/selected state indicators
@interface RLScrollPagerTabView : RLViewBase

@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic) UIColor *indicatorColor;

@end
