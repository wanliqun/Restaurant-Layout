//
//  RLSliderGroup.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/18/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RLStepperGroup : NSObject

@property (nonatomic, weak) UILabel   *valueLabel;
@property (nonatomic, weak) UIStepper *stepper;

@property (nonatomic, assign) NSUInteger value;

- (id) initWithStepper:(UIStepper *)stepper valueLabel:(UILabel *)valueLabel;

@end
