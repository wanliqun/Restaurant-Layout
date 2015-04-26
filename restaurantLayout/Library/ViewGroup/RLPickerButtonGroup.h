//
//  RLPickerButtonGroup.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/17/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RLPickerButtonGroup : NSObject<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, weak) UIButton *pickerButton;

@property (nonatomic, weak) UIView          *actionCalloutContainer;
@property (nonatomic, weak) UIPickerView    *pickerView;
@property (nonatomic, weak) UIBarButtonItem *cancelBarButtonItem;
@property (nonatomic, weak) UIBarButtonItem *doneBarButtonItem;

@property (nonatomic, retain) NSArray  *pickerOptions;
@property (nonatomic, assign) NSInteger pickerValue;

- (id)initWithConfig:(NSDictionary *)config;

@end
