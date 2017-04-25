//
//  WFProgress.h
//  WFProgressDemo
//
//  Created by happi on 2017/4/21.
//  Copyright © 2017年 xishan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFProgress : UIView<CAAnimationDelegate> {
    CAGradientLayer *layer;
}

@property (nonatomic, readonly) CALayer *maskLayer;
@property (nonatomic, assign) CGFloat progress;

@end
