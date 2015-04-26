//
//  RLCircularRadioButton.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLCircularRadioButton.h"


@interface RLRadioButton ()

- (void)setup;

@end

@interface RLCircularRadioButton ()

@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end


@implementation RLCircularRadioButton

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
    
    CGFloat borderDiameter = CGRectGetWidth(self.frame) * 0.67;
    CGFloat borderRadius = borderDiameter / 2.0f;
    CGFloat borderThickness = 1;
    
    CGFloat circleRadius = borderRadius - borderThickness;

    // border
    
    CGRect frame = CGRectMake(borderThickness, borderThickness, circleRadius * 2.0f, circleRadius * 2.0f);
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    CGFloat x = (CGRectGetWidth(self.frame) - borderRadius * 2.0f) / 2.0f;
    
    self.borderLayer = [CAShapeLayer layer];
    self.borderLayer.path = borderPath.CGPath;
    self.borderLayer.frame = CGRectMake(x, 0, borderDiameter, borderDiameter);
    self.borderLayer.lineWidth = borderThickness;
    self.borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:self.borderLayer];
    
    // circle
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, borderDiameter, borderDiameter)];
    
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.hidden = YES;
    self.circleLayer.path = circlePath.CGPath;
    self.circleLayer.frame = CGRectMake(x, 0, borderDiameter, borderDiameter);
    self.circleLayer.lineWidth = 0;
    self.circleLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:self.circleLayer];
    
    // title label
    CGFloat y = CGRectGetMaxY(self.circleLayer.frame);
    frame = CGRectMake(0, y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.33);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:frame];
    self.titleLabel.text = @"Round";
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.frame) * 0.25];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.titleLabel];
    
    [super setup];
}

# pragma mark - setter & getter

- (void)setSelected:(BOOL)selected {

    if (selected) {
        
        self.circleLayer.hidden = NO;
        self.borderLayer.strokeColor = [UIColor whiteColor].CGColor;
        
        self.titleLabel.textColor = [UIColor whiteColor];
    } else {
        
        self.circleLayer.hidden = YES;
        self.borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }
    
    [super setSelected:selected];
}


@end
