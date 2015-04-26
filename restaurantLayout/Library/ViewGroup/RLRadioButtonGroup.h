//
//  RLRadioButtonGroup.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewBase.h"
#import "RLRadioButton.h"

@class RLRadioButtonGroup;

# pragma mark - RLRadioButtonGroupDelegate

@protocol RLRadioButtonGroupDelegate <NSObject>

@required
- (void)radioButtonGroupDidChange:(RLRadioButtonGroup *)radioButtonGroup;

@end


@interface RLRadioButtonGroup : NSObject <RLRadioButtonDelegate>

@property (nonatomic, retain) NSArray *radioButtons;

@property (nonatomic, weak) RLRadioButton *selectedRadioButton;

@property (nonatomic, weak) id<RLRadioButtonGroupDelegate> delegate;

@end