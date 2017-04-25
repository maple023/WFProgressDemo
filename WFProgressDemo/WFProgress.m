//
//  WFProgress.m
//  WFProgressDemo
//
//  Created by happi on 2017/4/21.
//  Copyright © 2017年 xishan. All rights reserved.
//

#import "WFProgress.h"

@implementation WFProgress

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Use a horizontal gradient
        layer = [CAGradientLayer layer];
        layer.frame = frame;
        //layer.position = self.center;
        [self.layer addSublayer:layer];
        
        [layer setStartPoint:CGPointMake(0.0, 0.0)];
        [layer setEndPoint:CGPointMake(1.0, 0.0)];
        
        // 颜色分配
//        layer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                         (__bridge id)[UIColor greenColor].CGColor,
//                         (__bridge id)[UIColor blueColor].CGColor,];
        
        // Create colors using hues in +5 increments
        NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:100];
        for (NSInteger hue = 0; hue<=255; hue += 5) {
            UIColor *color = [UIColor colorWithHue:hue / 255.0
                               saturation:1.0
                               brightness:1.0
                                    alpha:1.0];
            [colors addObject:(id)color.CGColor];
        }
        [layer setColors:colors];
        

        _maskLayer = [CALayer layer];
        [_maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
        [_maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [layer setMask:_maskLayer];
        
        [self performAnimation];
    }
    return self;
}


- (void)performAnimation {
    // Move the last color in the array to the front
    // shifting all the other colors.
    NSMutableArray *mutable = [[layer colors] mutableCopy];
    id lastColor = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:lastColor atIndex:0];
    
    NSArray *shiftedColors = [NSArray arrayWithArray:mutable];
    
    
    // Update the colors on the model layer
    [layer setColors:shiftedColors];
    
    // Create an animation to slowly move the gradient left to right.
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    [self performAnimation];
} 


- (void)setProgress:(CGFloat)value {
    if (_progress != value) {
        _progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    // Resize our mask layer based on the current progress
    CGRect maskRect = [_maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * _progress;
    [_maskLayer setFrame:maskRect];
}


@end
