//
//  ViewController.h
//  radar
//
//  Created by David Samuel on 6/12/12.
//  Copyright (c) 2012 Osaka University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
void drawMovingGradient(CGContextRef context, CGRect rect, CGColorRef startColor, 
                        CGColorRef  endColor);
@end
