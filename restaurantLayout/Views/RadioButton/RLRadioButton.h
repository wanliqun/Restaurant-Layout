//
//  RLRadioButton.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewBase.h"

@class RLRadioButton;

# pragma mark - RLRadioButtonDelegate

@protocol RLRadioButtonDelegate <NSObject>

@required
- (void)radioButtonDidSelect:(RLRadioButton *)radioButton;

@end


# pragma mark - RLRadioButton

@interface RLRadioButton : RLViewBase

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, weak) id<RLRadioButtonDelegate> delegate;

@end
