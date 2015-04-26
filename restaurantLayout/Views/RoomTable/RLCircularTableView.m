//
//  RLCircularTableView.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/19/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLCircularTableView.h"

static const CGFloat kBaseCircularTableRadius = 16;
static const CGFloat kCircularTableSeatHeight = 6;
static const CGFloat kCircularTableSeatInset = 10;
static const CGFloat kCircularTableSeatStrokeLineWidth = 1;

#define kCircularTableBackgroundColor    [UIColor whiteColor]
#define kCircularSeatStrokeColor         [UIColor whiteColor]
#define kCircularSeatFillColor           [UIColor greenColor]
#define kCircularTableNumberTextColor    [UIColor blackColor]

@interface RLCircularTableView()

@property (nonatomic, assign) CGFloat circleRadius;

@end


@implementation RLCircularTableView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context,rect);
    
    // fill background rect
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    // fill the circle
    
    CGPoint center = CGPointMake(CGRectGetWidth(rect) / 2.0f, CGRectGetHeight(rect) / 2.0f);
    
    CGContextAddArc(context, center.x, center.y, _circleRadius, 0, M_PI * 2, 0);
    //set the fill color
    CGContextSetFillColorWithColor(context, kCircularTableBackgroundColor.CGColor);
    //CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    //fill or draw the path
    CGContextDrawPath(context, kCGPathFill);
    
    // draw table number
    
    NSString *tableNumberString = [@(self.tableNumber) stringValue];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName:kCircularTableNumberTextColor};
    
    CGSize drawTextSize = [tableNumberString sizeWithAttributes:attributes];
    CGRect drawTextFrame = CGRectMake((CGRectGetWidth(rect) - drawTextSize.width) / 2.0f,
                                      (CGRectGetHeight(rect) - drawTextSize.height) / 2.0f,
                                      drawTextSize.width, drawTextSize.height);
    
    [tableNumberString drawInRect:drawTextFrame withAttributes:attributes];

    // draw table seats.
    
    // clip the circle area.
    CGContextAddRect(context, rect);
    CGContextAddArc(context, center.x, center.y, _circleRadius, 0, M_PI * 2, 0);
    CGContextEOClip(context);
    
    NSInteger circleShares = MAX(self.tableSeats, 6);
    CGFloat avgShareDegree = 360.0f / circleShares;
    //CGFloat angleInset = kCircularTableSeatInset * 6.0 / circleShares;
    CGFloat angleInset = kCircularTableSeatInset * 6.0 / circleShares / 2.0;
    
    for (int i = 0; i < self.tableSeats; i++) {
        
        CGFloat midAngle = 270 - i * avgShareDegree;
        CGFloat startAngle = midAngle - avgShareDegree / 2.0f + angleInset;
        CGFloat endAngle = midAngle + avgShareDegree / 2.0f - angleInset;
        
        CGFloat startAngleRad = startAngle * M_PI / 180;
        CGFloat endAngleRad = endAngle * M_PI / 180;
     
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, nil, center.x, center.y, _circleRadius + kCircularTableSeatHeight, startAngleRad, endAngleRad, 0);
        CGPathAddLineToPoint(path, nil, center.x, center.y);
        CGContextAddPath(context, path);
        CGContextClosePath(context);
        
        if (!self.selected) {
            
            CGContextSetStrokeColorWithColor(context, kCircularSeatStrokeColor.CGColor);
            CGContextSetLineWidth(context, kCircularTableSeatStrokeLineWidth);
            
            CGContextDrawPath(context, kCGPathStroke);
            
        } else {
            
            CGContextSetFillColorWithColor(context, kCircularSeatFillColor.CGColor);
            
            CGContextDrawPath(context, kCGPathFill);
        }

    }
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGFloat baseRadius = kBaseCircularTableRadius;
    
    if (self.tableSeats > 6) {
        baseRadius *= self.tableSeats / 6.0f;
    }
    
    _circleRadius = baseRadius;
    
    CGFloat squareLength = _circleRadius * 2 + 2 * kCircularTableSeatHeight;
    
    return CGSizeMake(squareLength, squareLength);
}

@end
