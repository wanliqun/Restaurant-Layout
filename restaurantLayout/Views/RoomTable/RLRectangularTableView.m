//
//  RLRectangularTableView.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/19/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLRectangularTableView.h"
#import "TableModel.h"

static const CGFloat kBaseRectangularTableSize   = 32;
static const CGFloat kRectangularTableSeatWidth  = 16;
static const CGFloat kRectangularTableSeatHeight = 6;
static const CGFloat kRectangularTableSeatInset = (kBaseRectangularTableSize - kRectangularTableSeatWidth) / 2.0f;
static const CGFloat kRectangularTableSeatStrokeLineWidth = 1;

#define kRectangularTableBackgroundColor [UIColor whiteColor]
#define kRectangularSeatStrokeColor      [UIColor whiteColor]
#define kRectangularSeatFillColor        [UIColor greenColor]
#define kRectangularTableNumberTextColor [UIColor blackColor]


@interface RLRoomTableViewBase()

- (void)parseModel:(TableModel *)table;
- (void)prepareForDrawing;

@end


@interface RLRectangularTableView()

@property (nonatomic, assign) CGSize tableRectSize;

@property (nonatomic, assign) NSInteger rowSeats;
@property (nonatomic, assign) NSInteger colSeats;

@end


@implementation RLRectangularTableView

#pragma mark - override

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context,rect);
    
    // fill background rect
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    
    if (!self.opposingSeats) {
        
        // fill table rect.
        
        CGFloat x = self.tableSeats > 1 ? kRectangularTableSeatHeight : 0;
        CGFloat y = kRectangularTableSeatHeight;
        CGRect tableRect = CGRectMake(x, y, _tableRectSize.width, _tableRectSize.height);
        
        CGContextSetFillColorWithColor(context, kRectangularTableBackgroundColor.CGColor);
        CGContextFillRect(context, tableRect);
        
        // draw table seats.
        
        if (self.selected) {
            CGContextSetFillColorWithColor(context, kRectangularSeatFillColor.CGColor);
        } else {
            CGContextSetStrokeColorWithColor(context, kRectangularSeatStrokeColor.CGColor);
            CGContextSetLineWidth(context, kRectangularTableSeatStrokeLineWidth);
        }
        
        NSInteger seatIndex = 1;
        
        // The first seat starts here.
        CGRect seatRect = CGRectMake(x + kRectangularTableSeatInset, 0,
                                     kRectangularTableSeatWidth, kRectangularTableSeatHeight);
        if (self.selected) {
            CGContextFillRect(context, seatRect);
        } else {
            CGContextStrokeRect(context, seatRect);
        }
        
        
        // The left column seats start here.
        for (int i = 0; i < _colSeats; i++) {
            
            if (++seatIndex > self.tableSeats) break;
            
            y = CGRectGetMinY(tableRect) + kRectangularTableSeatInset + i * (kRectangularTableSeatWidth + kRectangularTableSeatInset);
            seatRect = CGRectMake(0, y, kRectangularTableSeatHeight, kRectangularTableSeatWidth);
            
            if (self.selected) {
                CGContextFillRect(context, seatRect);
            } else {
                CGContextStrokeRect(context, seatRect);
            }
        }
        
        // The bottom row seats start here
        for (int i = 0; i < _rowSeats; i++) {
        
            if (++seatIndex > self.tableSeats) break;
            
            x = CGRectGetMinX(tableRect) + kRectangularTableSeatInset + i * (kRectangularTableSeatWidth + kRectangularTableSeatInset);
            y = CGRectGetMaxY(tableRect);
            seatRect = CGRectMake(x, y, kRectangularTableSeatWidth, kRectangularTableSeatHeight);
           
            if (self.selected) {
                CGContextFillRect(context, seatRect);
            } else {
                CGContextStrokeRect(context, seatRect);
            }
        }
        
        // The right col seats start here.
        for (int i = 0; i < _colSeats; i++) {
            
            if (++seatIndex > self.tableSeats) break;
            
            x = CGRectGetMaxX(tableRect);
            y = CGRectGetMaxY(tableRect) - (i + 1) * (kRectangularTableSeatInset + kRectangularTableSeatWidth);
            seatRect = CGRectMake(x, y, kRectangularTableSeatHeight, kRectangularTableSeatWidth);
            
            if (self.selected) {
                CGContextFillRect(context, seatRect);
            } else {
                CGContextStrokeRect(context, seatRect);
            }
        }
        
        // The top row remaining seats start here.
        for (int i = 0; i < _rowSeats - 1; i++) {
            
            if (++seatIndex > self.tableSeats) break;
            
            x = CGRectGetMaxX(tableRect) - (i + 1) * (kRectangularTableSeatInset + kRectangularTableSeatWidth);
            seatRect = CGRectMake(x, 0, kRectangularTableSeatWidth, kRectangularTableSeatHeight);
            
            if (self.selected) {
                CGContextFillRect(context, seatRect);
            } else {
                CGContextStrokeRect(context, seatRect);
            }
        }
    } else {
        
        // fill table rect.
        
        CGFloat x = 0;
        CGFloat y = kRectangularTableSeatHeight;
        CGRect tableRect = CGRectMake(x, y, _tableRectSize.width, _tableRectSize.height);
        
        CGContextSetFillColorWithColor(context, kRectangularTableBackgroundColor.CGColor);
        CGContextFillRect(context, tableRect);

        // draw table seats.
        
        if (self.selected) {
            CGContextSetFillColorWithColor(context, kRectangularSeatFillColor.CGColor);
        } else {
            CGContextSetStrokeColorWithColor(context, kRectangularSeatStrokeColor.CGColor);
            CGContextSetLineWidth(context, kRectangularTableSeatStrokeLineWidth);
        }
        
        for (int i = 0; i < self.tableSeats; i++) {
            
            x = CGRectGetMinX(tableRect) + kRectangularTableSeatInset + (i / 2) * (kRectangularTableSeatInset + kRectangularTableSeatWidth);
            y = (i % 2) ? (CGRectGetHeight(tableRect) + kRectangularTableSeatHeight) : 0;
            
            CGRect seatRect = CGRectMake(x, y, kRectangularTableSeatWidth, kRectangularTableSeatHeight);
            if (self.selected) {
                CGContextFillRect(context, seatRect);
            } else {
                CGContextStrokeRect(context, seatRect);
            }
        }
    }
    
    // draw table number
    
    NSString *tableNumberString = [@(self.tableNumber) stringValue];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName:kRectangularTableNumberTextColor};
    
    CGSize drawTextSize = [tableNumberString sizeWithAttributes:attributes];
    CGRect drawTextFrame = CGRectMake((CGRectGetWidth(rect) - drawTextSize.width) / 2.0f,
                                      (CGRectGetHeight(rect) - drawTextSize.height) / 2.0f,
                                      drawTextSize.width, drawTextSize.height);
    
    [tableNumberString drawInRect:drawTextFrame withAttributes:attributes];
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGFloat baseSize = kBaseRectangularTableSize;
    CGFloat sizeStretchUnit = kRectangularTableSeatWidth + kRectangularTableSeatInset;
    
    _tableRectSize = CGSizeMake(baseSize, baseSize);
    CGSize  frameSize = _tableRectSize;
    
    if (!self.opposingSeats) {
        
        NSInteger baseTimes   = self.tableSeats / 4;
        NSInteger remainSeats = self.tableSeats % 4;
        
        if (baseTimes > 0) {
            
            _rowSeats = _colSeats = baseTimes;
            
            if (remainSeats > 2) {
                _rowSeats++; _colSeats++;
            } else if (remainSeats != 0) {
                _rowSeats++;
            }
            
            _tableRectSize.width  += (_rowSeats - 1) * sizeStretchUnit;
            _tableRectSize.height += (_colSeats - 1) * sizeStretchUnit;
            
            frameSize = _tableRectSize;
            frameSize.height += 2 * kRectangularTableSeatHeight;
            frameSize.width  += 2 * kRectangularTableSeatHeight;
            
        } else {
            
            _rowSeats = _colSeats = 1;
            
            switch (remainSeats) {
                case 1: {
                    frameSize.height += kRectangularTableSeatHeight;
                }
                    break;
                case 2: {
                    frameSize.height += kRectangularTableSeatHeight;
                    frameSize.width  += kRectangularTableSeatHeight;
                }
                    break;
                case 3: {
                    frameSize.height += 2 * kRectangularTableSeatHeight;
                    frameSize.width  += kRectangularTableSeatHeight;
                }
                    break;
            }
        }
    } else {
        
        NSInteger baseTimes = (NSInteger)(self.tableSeats / 2.0 + 0.5);
        
        _tableRectSize.width += (baseTimes - 1) * sizeStretchUnit;
        frameSize = _tableRectSize;
        
        if (self.tableSeats > 1) {
            frameSize.height += 2 * kRectangularTableSeatHeight;
        } else {
            frameSize.height += kRectangularTableSeatHeight;
        }
        
    }
    
    return frameSize;
}

#pragma mark - setter & getter

- (BOOL)opposingSeats {
    return self.tableModel.opposing;
}

- (void)setOpposingSeats:(BOOL)opposingSeats {
    
    self.tableModel.opposing = opposingSeats;
    
    [self prepareForDrawing];
}

@end
