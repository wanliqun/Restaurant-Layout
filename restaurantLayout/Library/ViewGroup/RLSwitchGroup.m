//
//  RLSwitchGroup.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/24/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLSwitchGroup.h"

@implementation RLSwitchGroup

#pragma mark - initialization

- (id) initWithSwitchControl:(UISwitch *)switchControl {
    
    self = [super init];
    
    if (self) {
        
        self.switchControl = switchControl;
        [switchControl addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

#pragma mark - setter & getter 

- (BOOL)on {
    
    return self.switchControl.on;
}

- (void)setOn:(BOOL)on {
    
    if (on != self.switchControl.on) {
        self.switchControl.on = on;
    }
}


#pragma mark - event handling

- (void)switchChanged:(UISwitch *)sender {
   
    self.on = sender.on;
}

@end
