//
//  RLTableSettings.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/19/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLTableSettings.h"

static const NSUInteger kMaxTableSeats = 100;

@implementation RLTableSettings

+ (RLTableSettings *)sharedInstance {
    
    static RLTableSettings *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RLTableSettings alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        _tableType = SquareTable;
        _tableNumber = 1;
        _tableSeats = 1;
        _tableSize = 0;
        _opposingSeats = NO;
        
        NSMutableArray *availableTableNumbers = [NSMutableArray array];
        for (NSUInteger i = 1; i <= kMaxTableSeats; i++) {
            [availableTableNumbers addObject:@(i)];
        }
        _avaliableTableNumbers = availableTableNumbers;
    }
    
    return self;
}

- (NSString *)description {
    
    NSMutableString *description = [NSMutableString stringWithString:@"RLTableSettings description: "];
    [description appendFormat:@"table type: %ld, table number: %ld, ", _tableType, (unsigned long)_tableNumber];
    [description appendFormat:@"table seats: %uld, table size: %lf, ", _tableSeats, _tableSize];
    [description appendFormat:@"opposing seats: %d, ", _opposingSeats];
    [description appendFormat:@"avaliable table numbers: [%@]", [_avaliableTableNumbers componentsJoinedByString:@","]];
    
    return description;
}

@end
