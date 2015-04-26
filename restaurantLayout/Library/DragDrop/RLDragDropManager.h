//
//  RLDragDropManager.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/18/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RLDragDropManager : NSObject

+ (RLDragDropManager *)sharedInstance;

- (void)registerDraggableView:(UIView *)view;

@end
