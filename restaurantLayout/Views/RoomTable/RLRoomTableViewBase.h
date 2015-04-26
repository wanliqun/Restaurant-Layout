//
//  RLRoomTableViewBase.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/21/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewBase.h"

@class TableModel;

@interface RLRoomTableViewBase : RLViewBase

@property (nonatomic, assign) NSUInteger tableNumber;
@property (nonatomic, assign) NSUInteger tableSeats;

@property (nonatomic, assign) CGFloat    tableSize;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) CGPoint position;

@property (nonatomic, retain) TableModel *tableModel;

- (id)initWithTableModel:(TableModel*)table;

@end
