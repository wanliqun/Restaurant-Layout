//
//  RLRoomTableViewBase.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/21/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLRoomTableViewBase.h"
#import "RLRoomsManager.h"
#import "TableModel.h"

@implementation RLRoomTableViewBase

#pragma mark - initialization

- (id)initWithTableModel:(TableModel*)table {
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.tableModel = table;
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, (1 + table.size), (1 + table.size));
        
        [self prepareForDrawing];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    
    TableModel *copyTable = [[RLRoomsManager sharedInstance] duplicateTable:self.tableModel];
    
    return [[[self class] alloc] initWithTableModel:copyTable];
}

#pragma mark - setter & getter

- (CGPoint)position {
    return CGPointMake(self.center.x, self.center.y);
}

- (void)setPosition:(CGPoint)position {
    self.center = position;
    
    _tableModel.x = position.x;
    _tableModel.y = position.y;
}

- (NSUInteger)tableNumber {
    return _tableModel.number;
}

- (void)setTableNumber:(NSUInteger)tableNumber {
    _tableModel.number = tableNumber;
    
    [self setNeedsDisplay];
}

- (NSUInteger)tableSeats {
    return _tableModel.seats;
}

- (void)setTableSeats:(NSUInteger)tableSeats {
    
    _tableModel.seats = tableSeats;
    
    [self prepareForDrawing];
}

- (CGFloat)tableSize {
    return _tableModel.size;
}

- (void)setTableSize:(CGFloat)tableSize {
    
    _tableModel.size = tableSize;
    
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, (1 + tableSize), (1 + tableSize));
    
    [self prepareForDrawing];
}

- (void)setSelected:(BOOL)selected {
    
    _selected = selected;
    
    [self setNeedsDisplay];
}

#pragma mark - utils

- (void)prepareForDrawing {
    
    [self sizeToFit];
    
    [self setNeedsDisplay];
}

@end
