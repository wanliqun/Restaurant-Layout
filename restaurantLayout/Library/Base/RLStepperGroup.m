//
//  RLSliderGroup.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/18/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLStepperGroup.h"

@implementation RLStepperGroup

#pragma mark - initialization

- (id) initWithStepper:(UIStepper *)stepper valueLabel:(UILabel *)valueLabel {
    
    self = [super init];
    if (self) {
        
        self.stepper = stepper;
        [self.stepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        
        self.valueLabel = valueLabel;
        self.valueLabel.text = [@(self.stepper.value) stringValue];
    }
    
    return self;
}

#pragma mark - setter & getter

- (NSUInteger) value {
    return _stepper.value;
}

- (void)setValue:(NSUInteger)value {
    
    if (_stepper.value != value) {
        _stepper.value = value;
    }
    
    self.valueLabel.text = [@(self.stepper.value) stringValue];
}

#pragma mark - event

- (void)valueChanged:(UIStepper *)stepper {
    
    NSUInteger value = stepper.value;
    
    self.value = value;
    self.valueLabel.text = [@(value) stringValue];
}

@end
