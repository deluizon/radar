//
//  mainView.m
//  radar
//
//  Created by David Samuel on 6/12/12.
//  Copyright (c) 2012 Osaka University. All rights reserved.
//

#import "mainView.h"

@implementation mainView

-(id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        //[self.layer addSublayer:movingLayer];
        //[movingLayer setNeedsDisplay];
        NSLog(@"initiated");
    }
    return self;
} 

-(void)drawRect:(CGRect)rect{
    //NSLog(@"drawRect called");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.0, 1.0, 0.0, 1.0};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    //start drawing base of the radar
    CGPoint centerPoint = self.center;
    CGFloat radius = 160;
    
    CGRect rects = CGRectMake(centerPoint.x-radius, centerPoint.y-radius, 2*radius, 2*radius);
    
    CGColorRef greenColor = [UIColor colorWithRed:0.0 green:0.7 
                                             blue:0.0 alpha:1.0].CGColor; 
    CGColorRef blackColor = [UIColor colorWithRed:0.0 green:0.0 
                                             blue:0.0 alpha:1.0].CGColor;
    
    //drawLinearGradient(context, rects, greenColor, blackColor);
    
    
    CGContextMoveToPoint(context, centerPoint.x, centerPoint.y-radius);
    CGContextAddLineToPoint(context, centerPoint.x, centerPoint.y+radius);
    
    CGContextMoveToPoint(context, centerPoint.x-radius, centerPoint.y);
    CGContextAddLineToPoint(context, centerPoint.x+radius, centerPoint.y);
    
    CGContextSetRGBFillColor(context, 0, 180, 0, 0.25);
    CGContextFillEllipseInRect(context, rects);
    CGContextAddEllipseInRect(context, rects);
    
    radius = 110;
    CGRect rects2 = CGRectMake(centerPoint.x-radius, centerPoint.y-radius, 2*radius, 2*radius);
    CGContextAddEllipseInRect(context, rects2);
    
    radius = 60;
    CGRect rects3 = CGRectMake(centerPoint.x-radius, centerPoint.y-radius, 2*radius, 2*radius);
    CGContextAddEllipseInRect(context, rects3);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, 
                        CGColorRef  endColor) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, 
                                                        (CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    //CGContextAddRect(context, rect);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace); 
}

/*- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(context, bgColor);
    //NSLog(@"drawLayer terpanggil");
}

void MyDrawColoredPattern (void *info, CGContextRef context) {
    
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    
    //CGContextAddArc(context, 3, 3, 4, 0, radians(360), 0);
    CGContextFillPath(context);
    
    //CGContextAddArc(context, 16, 16, 4, 0, radians(360), 0);
    CGContextFillPath(context);
    
}*/


@end
