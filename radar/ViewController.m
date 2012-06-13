//
//  ViewController.m
//  radar
//
//  Created by David Samuel on 6/12/12.
//  Copyright (c) 2012 Osaka University. All rights reserved.
//

#import "ViewController.h"
#import "mainView.h"
#import <QuartzCore/QuartzCore.h>
@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"view did load");
	// Do any additional setup after loading the view, typically from a nib.
    mainView *main = [[mainView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view=main;
    [main release];
    
    CALayer *movingLayer =[CALayer layer];
    movingLayer.delegate=self;
    //movingLayer.backgroundColor=[UIColor redColor].CGColor;
    
    
    movingLayer.frame=CGRectMake(self.view.center.x-160, self.view.center.y-150, 320, 320);
    //movingLayer.frame=self.view.frame;
    
    [self.view.layer addSublayer:movingLayer];
    [movingLayer setNeedsDisplay];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    CATransform3D transform = CATransform3DMakeRotation (180*M_PI/180, 0, 0, 1);
    animation.toValue = [NSValue valueWithCATransform3D: transform];
    animation.duration = 2.0 ;
    animation.cumulative = YES;
    animation.repeatCount = 10000;
    animation.removedOnCompletion = YES;
    [movingLayer addAnimation:animation forKey:@"transform"];
    
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOutAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    fadeOutAnimation.toValue = [NSNumber numberWithFloat:0.0];

    fadeOutAnimation.duration = 2.0;
    fadeOutAnimation.cumulative = NO;
    fadeOutAnimation.repeatCount = 10000;
    fadeOutAnimation.removedOnCompletion = YES;
    [movingLayer addAnimation:fadeOutAnimation forKey:@"opacity"];

    movingLayer.shouldRasterize=YES;
    
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    NSLog(@"drawLayer");
    //CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    //CGContextSetFillColorWithColor(context, bgColor);
    //NSLog(@"drawLayer terpanggil");
    
    
    CGContextSetLineWidth(context, 2.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.0, 0.8, 0.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    
    //CGMutablePathRef path = CGPathCreateMutable();
    //CGPathAddArc(path, NULL, self.view.center.x, self.view.center.y, 160, 0, 30*M_PI/180, 0);
    //CGPathAddLineToPoint(path, NULL, <#CGFloat x#>, <#CGFloat y#>)
    
    CGRect rects = CGRectMake(160, 160, 320, 320);
    
    CGColorRef greenColor = [UIColor colorWithRed:0.0 green:0.7 
                                             blue:0.0 alpha:1.0].CGColor; 
    CGColorRef blackColor = [UIColor colorWithRed:0.0 green:0.0 
                                             blue:0.0 alpha:1.0].CGColor;
    
    //drawLinearGradient(context, rects, greenColor, blackColor);
    
    
    CGContextMoveToPoint(context, 160, 160);
    CGContextAddLineToPoint(context, 320, 160);
    CGContextAddArc(context, 160,160, 160, 0, 30*M_PI/180, 0);
    //CGContextAddLineToPoint(context, self.view.center.x, self.view.center.y);
    //CGContextAddLineToPoint(context, 160 ,160);
    CGContextStrokePath(context);
    
    
    NSArray *colors = [NSArray arrayWithObjects:(id)greenColor, (id)blackColor, nil];
    CGFloat locations[] = { 0.0, 1.0 };
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, 
                                                        (CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rects), CGRectGetMinY(rects));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rects), CGRectGetMaxY(rects));
    
    CGContextSaveGState(context);
    //CGContextAddRect(context, rect);
    //CGContextAddEllipseInRect(context, rect);
    
    //draw the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL,  160, 160, 160, 0, 30*M_PI/180, 0);
    CGPathAddLineToPoint(path, NULL, 160, 160);
    CGPathAddLineToPoint(path, NULL, 320, 160);
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    
    
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}

void drawMovingGradient(CGContextRef context, CGRect rect, CGColorRef startColor, 
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
    //CGContextAddEllipseInRect(context, rect);
    
    
    
    
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace); 
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
