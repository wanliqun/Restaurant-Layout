//
//  RoomModel.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RoomModel.h"
#import "TableModel.h"


@implementation RoomModel

@dynamic length;
@dynamic name;
@dynamic width;
@dynamic tables;

+ (NSString *)entityName {
    return @"Room";
}

@end
