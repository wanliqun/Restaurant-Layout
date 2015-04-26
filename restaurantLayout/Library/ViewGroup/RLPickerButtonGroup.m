//
//  RLPickerButtonGroup.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/17/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLPickerButtonGroup.h"

@interface RLPickerButtonGroup()

@property (nonatomic, assign) NSInteger tempPickerValue;

@end

@implementation RLPickerButtonGroup

#pragma mark - initializer

- (id)initWithConfig:(NSDictionary *)config {
    
    self = [super init];
    if (self) {
        
        // parse config variables
        
        self.pickerButton = config[@"pickerButton"];
        
        self.actionCalloutContainer = config[@"actionCalloutContainer"];
        
        self.pickerView = config[@"pickerView"];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
        self.cancelBarButtonItem = config[@"cancelBarButtonItem"];
        self.doneBarButtonItem = config[@"doneBarButtonItem"];
        
        // set events handler
        
        [self.pickerButton addTarget:self action:@selector(pick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.cancelBarButtonItem.target = self;
        self.cancelBarButtonItem.action = @selector(cancel:);
        
        self.doneBarButtonItem.target = self;
        self.doneBarButtonItem.action = @selector(done:);
    }
    
    return self;
}

#pragma mark - event handling

- (void)pick:(id)sender {
    
    self.actionCalloutContainer.hidden = !self.actionCalloutContainer.hidden;
    
    [self animatePickerButton];
}

- (void)cancel:(id)sender {
    
    self.actionCalloutContainer.hidden = YES;
    
    [self animatePickerButton];
}

- (void)done:(id)sender {
    
    self.pickerValue = self.tempPickerValue;
    
    [self cancel:sender];
}

#pragma mark - setter & getter

- (void)setPickerValue:(NSInteger)value {
    [_pickerButton setTitle:[@(value) stringValue] forState:UIControlStateNormal];
}

- (NSInteger)pickerValue {
    return [_pickerButton.titleLabel.text integerValue];
}

- (void)setPickerOptions:(NSArray *)pickerOptions {
    
    _pickerOptions = pickerOptions;
    
    [_pickerView reloadAllComponents];
}

#pragma mark -  UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerOptions count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerOptions[row] stringValue];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.tempPickerValue = [_pickerOptions[row] integerValue];
}

#pragma mark - private 

- (void)animatePickerButton {
    
    if (!self.actionCalloutContainer.hidden) {
        self.pickerButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        self.pickerButton.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}


@end
