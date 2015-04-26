//
//  RLSliderGroup.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/24/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLSliderGroup.h"

@implementation RLSliderGroup


#pragma mark - initialization

- (id)initWithSlider:(UISlider *)slider {
    
    self = [super init];
    
    if (self) {
        
        _slider = slider;
        [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

#pragma mark - setter & getter

- (float)value {
    return _slider.value;
}

- (void)setValue:(float)value {
    
    if (value != _slider.value) {
        _slider.value = value;
    }
}

#pragma mark - event handling

- (void)sliderChanged:(UISlider *)sender {
    
    self.value = sender.value;
}


@end
