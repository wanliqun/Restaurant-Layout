//
//  RLSliderGroup.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/24/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RLSliderGroup : NSObject

@property (nonatomic, weak)   UISlider *slider;

@property (nonatomic, assign) float    value;

- (id)initWithSlider:(UISlider *)slider;

@end
