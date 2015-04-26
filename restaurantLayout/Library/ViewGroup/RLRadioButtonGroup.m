//
//  RLRadioButtonGroup.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLRadioButtonGroup.h"

@implementation RLRadioButtonGroup

#pragma mark - setter & getter

- (void)setRadioButtons:(NSArray *)radioButtons {
    
    _radioButtons = radioButtons;
    
    for (RLRadioButton *btn in _radioButtons) {
        btn.delegate = self;
    }
}


# pragma mark - RLRadioButtonDelegate

- (void)radioButtonDidSelect:(RLRadioButton *)radioButton {
    
    for (RLRadioButton *rb in self.radioButtons) {
        
        if( rb != radioButton ){
            rb.selected = !radioButton.selected;
        }
    }
    
    self.selectedRadioButton = radioButton;
    
    if ([self.delegate respondsToSelector:@selector(radioButtonGroupDidChange:)]) {
        [self.delegate radioButtonGroupDidChange:self];
    }
}

@end
