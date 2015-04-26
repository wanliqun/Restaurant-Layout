//
//  RLRectangularRadioButton.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLRectangularRadioButton.h"

@interface RLRadioButton ()

- (void)setup;

@end

@interface RLRectangularRadioButton ()

@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong) CAShapeLayer *rectangleLayer;

@end


@implementation RLRectangularRadioButton

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

# pragma mark - utils

- (void)setup {
    
    CGFloat borderWidth = CGRectGetWidth(self.frame) * 0.67;
    CGFloat borderHeight = CGRectGetHeight(self.frame) * 0.67;
    CGFloat borderThickness = 1;
    
    CGFloat pathWidth = borderWidth - 2 * borderThickness;
    CGFloat pathHeight = borderHeight - 2 * borderThickness;
    
    // border
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:CGRectMake(borderThickness, borderThickness, pathWidth, pathHeight)];
    
    CGFloat x = (CGRectGetWidth(self.frame) - borderWidth) / 2.0f;
    
    self.borderLayer = [CAShapeLayer layer];
    self.borderLayer.path = borderPath.CGPath;
    self.borderLayer.frame = CGRectMake(x, 0, borderWidth, borderHeight);
    self.borderLayer.lineWidth = borderThickness;
    self.borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:self.borderLayer];
    
    // rectangle
    
    UIBezierPath *rectangularPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, borderWidth, borderWidth)];
    
    self.rectangleLayer = [CAShapeLayer layer];
    self.rectangleLayer.hidden = YES;
    self.rectangleLayer.path = rectangularPath.CGPath;
    self.rectangleLayer.frame = CGRectMake(x, 0, borderWidth, borderWidth);
    self.rectangleLayer.lineWidth = 0;
    self.rectangleLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:self.rectangleLayer];
    
    // title label
    
    CGFloat y = CGRectGetMaxY(self.rectangleLayer.frame);
    CGRect frame = CGRectMake(0, y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.33);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:frame];
    self.titleLabel.text = @"Square";
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.frame) * 0.25];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.titleLabel];
    
    [super setup];
}

# pragma mark - setter & getter

- (void)setSelected:(BOOL)selected {
    
    if (selected) {
        
        self.rectangleLayer.hidden = NO;
        self.borderLayer.strokeColor = [UIColor whiteColor].CGColor;
        
        self.titleLabel.textColor = [UIColor whiteColor];
    } else {
        
        self.rectangleLayer.hidden = YES;
        self.borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }
    
    [super setSelected:selected];
}


@end
