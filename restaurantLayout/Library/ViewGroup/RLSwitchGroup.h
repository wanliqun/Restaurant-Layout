//
//  RLSwitchGroup.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/24/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RLSwitchGroup : NSObject

@property (nonatomic, weak)   UISwitch *switchControl;
@property (nonatomic, assign) BOOL on;

- (id) initWithSwitchControl:(UISwitch *)switchControl;

@end
