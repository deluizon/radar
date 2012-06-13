//
//  mainView.h
//  radar
//
//  Created by David Samuel on 6/12/12.
//  Copyright (c) 2012 Osaka University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface mainView : UIView
{
    
}

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, 
                        CGColorRef  endColor);

void MyDrawColoredPattern (void *info, CGContextRef context);
@end
