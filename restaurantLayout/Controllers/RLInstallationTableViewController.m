//
//  RLInstallationTableViewController.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLInstallationTableViewController.h"
#import "RLDragDropManager.h"
#import "RLPickerButtonGroup.h"
#import "RLStepperGroup.h"
#import "RLSwitchGroup.h"
#import "RLSliderGroup.h"
#import "RLConstants.h"
#import "RLDragContext.h"
#import "RLTableSettings.h"
#import "RLRoomTableViewBase.h"
#import "RLRectangularTableView.h"
#import "TableModel.h"

@interface RLInstallationTableViewController()

@property (nonatomic, retain) RLRadioButtonGroup  *radioButtonGroup;
@property (nonatomic, retain) RLPickerButtonGroup *pickerButtonGroup;
@property (nonatomic, retain) RLStepperGroup      *stepperGroup;
@property (nonatomic, retain) RLSwitchGroup       *switchGroup;
@property (nonatomic, retain) RLSliderGroup       *sliderGroup;

@property (nonatomic, weak)   RLRoomTableViewBase *selectedTable;

@end

@implementation RLInstallationTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // radio button groups.
    
    _radioButtonGroup = [[RLRadioButtonGroup alloc] init];
    _radioButtonGroup.delegate = self;
    _radioButtonGroup.radioButtons = @[_squareRadioButton, _circleRadioButton];
    
    _squareRadioButton.selected = YES;
    
    [[RLDragDropManager sharedInstance] registerDraggableView:_squareRadioButton];
    [[RLDragDropManager sharedInstance] registerDraggableView:_circleRadioButton];
    
    // picker button group.
    NSDictionary *config = @{@"pickerButton":_tableNoPickerButton,
                            @"actionCalloutContainer":_actionCalloutContainer,
                            @"pickerView":_tableNoPickerView,
                            @"cancelBarButtonItem":_cancelBarButtonItem,
                            @"doneBarButtonItem":_doneBarButtonItem};
    _pickerButtonGroup = [[RLPickerButtonGroup alloc] initWithConfig:config];
    _pickerButtonGroup.pickerOptions = [RLTableSettings sharedInstance].avaliableTableNumbers;
    
    // stepper group
    _stepperGroup = [[RLStepperGroup alloc] initWithStepper:_seatsStepper valueLabel:_seatsLabel];
    
    // switch group
    _switchGroup = [[RLSwitchGroup alloc] initWithSwitchControl:_opposingSeatsSwitch];
    
    // slider group
    _sliderGroup = [[RLSliderGroup alloc] initWithSlider:_tableSizeSlider];
    
    // notification observing
    
    NSArray *noteNames = @[kRLNotificationTypeDragBegan, kRLNotificationTypeDragMoved,
                           kRLNotificationTypeDragEnded, kRLNotificationTypeDragCanceled];
    for (NSString *noteName in noteNames) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDragDrop:)
                                                     name:noteName object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roomTableSelected:)
                                                 name:kRLNotificationTypeTableSelected object:nil];
    
    // KVO
    [_pickerButtonGroup addObserver:self forKeyPath:@"pickerValue" options:NSKeyValueObservingOptionNew context:nil];
    [_sliderGroup addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    [_stepperGroup addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    [_switchGroup addObserver:self forKeyPath:@"on" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
 
    [_pickerButtonGroup removeObserver:self forKeyPath:@"pickerValue"];
    [_sliderGroup removeObserver:self forKeyPath:@"value"];
    [_stepperGroup removeObserver:self forKeyPath:@"value"];
    [_switchGroup removeObserver:self forKeyPath:@"on"];
}

# pragma mark - RLRadioButtonGroupDelegate

- (void)radioButtonGroupDidChange:(RLRadioButtonGroup *)radioButtonGroup {
   
    RLRadioButton *selectedRadioBtn = radioButtonGroup.selectedRadioButton;
    [self animateOpposingSeatsSwitchGroup:selectedRadioBtn == _squareRadioButton];
    
    [self loadTableSettings];
    
    if (self.selectedTable) {
        
        TableModel *tableModel = self.selectedTable.tableModel;
        
        if ((selectedRadioBtn == _squareRadioButton && tableModel.type != SquareTable)
            || (selectedRadioBtn == _circleRadioButton && tableModel.type != CircleTable)) {
            [self resetSettingsUI];
        }
    }
}

#pragma mark - utils

- (void)animateOpposingSeatsSwitchGroup:(BOOL)visible {
    _opposingSeatsLabel.hidden = _opposingSeatsSwitch.hidden = !visible;
}

- (void)animateInitialActionGroupPannel:(BOOL)visible {
    _initialActionGroupPannel.hidden = !visible;
}

- (void)animateActiveActionGroupPannel:(BOOL)visible {
    _activeActionGroupPannel.hidden = !visible;
}

- (void)loadTableSettings {
    
    [RLTableSettings sharedInstance].tableType = _squareRadioButton.selected ? SquareTable : CircleTable;
    [RLTableSettings sharedInstance].tableNumber = _pickerButtonGroup.pickerValue;
    [RLTableSettings sharedInstance].tableSeats = _stepperGroup.value;
    [RLTableSettings sharedInstance].tableSize = _sliderGroup.value;
    [RLTableSettings sharedInstance].opposingSeats = _switchGroup.on;
}

- (void)refreshSettingsUIWithTableModel:(TableModel *)tableModel {
    
    if (_pickerButtonGroup.pickerValue != tableModel.number) {
        _pickerButtonGroup.pickerValue = tableModel.number;
    }
    
    if (_stepperGroup.value != tableModel.seats) {
        _stepperGroup.value = tableModel.seats;
    }
    
    if (_sliderGroup.value != tableModel.size) {
        _sliderGroup.value = tableModel.size;
    }
    
    if (tableModel.type == SquareTable && tableModel.opposing != _switchGroup.on) {
        _switchGroup.on = tableModel.opposing;
    }
}

- (void)resetSettingsUI {
    
    if (self.selectedTable) {
        
        self.selectedTable.selected = NO;
        self.selectedTable = nil;
        
        [self animateActiveActionGroupPannel:NO];
    }
    
    _pickerButtonGroup.pickerValue = 1;
    _sliderGroup.value = 0;
    _stepperGroup.value = 1;
    _switchGroup.on = NO;
}
 
#pragma mark - event handling

- (void)handleDragDrop:(NSNotification *)note {
     //NSLog(@"%@", [note description]);
    
    RLDragContext *dragContext = note.object;
    
    if ([_radioButtonGroup.radioButtons containsObject:dragContext.draggedView]) {
        
        RLRadioButton *radioButton = (RLRadioButton *)dragContext.draggedView;
        
        if (dragContext.dragState == DragMoved && !radioButton.selected) {
            radioButton.selected = YES;
        } else if (dragContext.dragState == DragBegan) {
            [self loadTableSettings];
        }
    }
}

- (void)roomTableSelected:(NSNotification *)note {
    
    RLRoomTableViewBase *tableView = (RLRoomTableViewBase *)note.object;
    self.selectedTable = tableView;
    
    if (tableView) {
        
        TableModel *tableModel = tableView.tableModel;
        
        if (tableModel.type == SquareTable && !_squareRadioButton.selected) {
            _squareRadioButton.selected = YES;
        } else if(tableModel.type == CircleTable &&!_circleRadioButton.selected) {
            _circleRadioButton.selected = YES;
        }
        
        [self refreshSettingsUIWithTableModel:tableModel];
    } else {
        [self resetSettingsUI];
    }
    
    [self animateActiveActionGroupPannel:self.selectedTable ? YES : NO];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (self.selectedTable) {
        
        TableModel *tableModel = self.selectedTable.tableModel;
        
        if ((tableModel.type == SquareTable && _squareRadioButton.selected)
            || (tableModel.type == CircleTable && _circleRadioButton.selected)) {
            
            if (object == _pickerButtonGroup) {
                self.selectedTable.tableNumber = _pickerButtonGroup.pickerValue;
            } else if (object == _sliderGroup) {
                NSLog(@"%lf", _sliderGroup.value);
                self.selectedTable.tableSize = _sliderGroup.value;
            } else if (object == _stepperGroup) {
                self.selectedTable.tableSeats = _stepperGroup.value;
            } else if (object == _switchGroup && tableModel.type == SquareTable) {
                ((RLRectangularTableView *)self.selectedTable).opposingSeats = _switchGroup.on;
            }
        }
    }
}

- (IBAction)duplicate:(id)sender {
    
    if (self.selectedTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kRLNotificationTypeDuplicateTable
                                                            object:self.selectedTable];
    }
}

- (IBAction)remove:(id)sender {
    
    if (self.selectedTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kRLNotificationTypeRemoveTable
                                                            object:self.selectedTable];
    }
}

@end
