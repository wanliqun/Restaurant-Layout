//
//  RLRadioButton.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLRadioButton.h"

@interface RLRadioButton()

@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong) CAShapeLayer *rectangleLayer;

@end


@implementation RLRadioButton

#pragma mark - initialization 

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tapRecognizer];
}

# pragma mark - setter & getter

- (void)setSelected:(BOOL)selected {
    
    _selected = selected;
    
    if (selected) {
        
        if ([self.delegate respondsToSelector:@selector(radioButtonDidSelect:)]) {
            [self.delegate radioButtonDidSelect:self];
        }
    }
}

# pragma mark - event handling

- (void)tap:(UIGestureRecognizer*)recognizer {
    
    if( !self.selected ){
        self.selected = !self.selected;
    }

}



@end
