//
//  RlDragGestureRecognizer.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/18/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RlDragGestureRecognizer.h"

@interface UIPanGestureRecognizer()

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end


@implementation RlDragGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action {
    
    self = [super initWithTarget:target action:action];
    if (self) {
        
    }
 
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //NSLog(@"Touch began: %@", [event description]);
    
    if (self.touchBeganHandler && self.touchBeganHandler(touches, event)) {
        
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //NSLog(@"Touch moved: %@", [event description]);
    
    if (self.touchMovedHandler && self.touchMovedHandler(touches, event)) {
        
    } else {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //NSLog(@"Touch ended: %@", [event description]);
    
    if (self.touchEndedHandler && self.touchEndedHandler(touches, event)) {
        
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //NSLog(@"Touch canceled: %@", [event description]);
    
    if (self.touchCancelledHandler && self.touchCancelledHandler(touches, event)) {
        
    } else {
        [super touchesCancelled:touches withEvent:event];
    }
}

@end

