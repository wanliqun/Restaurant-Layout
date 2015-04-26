//
//  RLTableSettings.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/19/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TableType) {
    SquareTable, CircleTable,
};

@interface RLTableSettings : NSObject

+ (RLTableSettings *)sharedInstance;

@property (nonatomic, assign) TableType  tableType;

@property (nonatomic, assign) NSUInteger tableNumber;
@property (nonatomic, assign) NSUInteger tableSeats;

@property (nonatomic, assign) CGFloat    tableSize;

@property (nonatomic, assign) BOOL       opposingSeats;

@property (nonatomic, retain) NSArray    *avaliableTableNumbers;

@end
