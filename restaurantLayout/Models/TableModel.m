//
//  TableModel.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "TableModel.h"
#import "RoomModel.h"


@implementation TableModel

@dynamic number;
@dynamic opposing;
@dynamic seats;
@dynamic size;
@dynamic type;
@dynamic room;
@dynamic x;
@dynamic y;

+ (NSString *)entityName {
    return @"Table";
}

@end
