//
//  RLInstallationTableViewController.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewControllerBase.h"
#import "RLRadioButtonGroup.h"
#import "RLRectangularRadioButton.h"
#import "RLCircularRadioButton.h"

@interface RLInstallationTableViewController : RLViewControllerBase<RLRadioButtonGroupDelegate>

#pragma mark - radio button group
@property (weak, nonatomic) IBOutlet RLRectangularRadioButton *squareRadioButton;
@property (weak, nonatomic) IBOutlet RLCircularRadioButton *circleRadioButton;

# pragma mark - picker button group

@property (weak, nonatomic) IBOutlet UIButton *tableNoPickerButton;

@property (weak, nonatomic) IBOutlet UIView *actionCalloutContainer;
@property (weak, nonatomic) IBOutlet UIPickerView *tableNoPickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

#pragma mark - slider
@property (weak, nonatomic) IBOutlet UISlider *tableSizeSlider;

#pragma mark - stepper
@property (weak, nonatomic) IBOutlet UILabel *seatsLabel;
@property (weak, nonatomic) IBOutlet UIStepper *seatsStepper;

#pragma mark - opposing seats.
@property (weak, nonatomic) IBOutlet UILabel *opposingSeatsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *opposingSeatsSwitch;

#pragma mark - action panels

@property (weak, nonatomic) IBOutlet UIView *initialActionGroupPannel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIView *activeActionGroupPannel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton2;
@property (weak, nonatomic) IBOutlet UIButton *duplicateButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

@end
