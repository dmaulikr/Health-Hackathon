//
//  UIView+AOAnimation.m
//
//  Created by Sznur on 23.12.2012.
//  Copyright (c) 2012. All rights reserved.
//

#import "UIView+AOAnimation.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (AOAnimation)

- (void)hide:(UITapGestureRecognizer*)sender
{
    UIView *vie = sender.view;
    if (vie.tag != 1) {
        
    vie.tag = 1;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        vie.alpha = 0;
    } completion:^(BOOL finished) {
        [vie removeFromSuperview];
    }];
    }
}

- (void)aoAnimationCurtine:(AnimationCurtineStyle)animationStyle option:(UIViewAnimationOptions)options duration:(float)duration delay:(float)delay startScale:(float)startScale startAlpha:(float)startAlpha startValue:(float)startValue stopValue:(float)stopValue
{
    float endAlpha = 0.99;
    if (animationStyle == AOAnimationCurtineCurtineChange) {
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.superview.frame = CGRectMake(self.superview.frame.origin.x, self.superview.frame.origin.y, self.frame.size.width, self.frame.size.height);
            self.alpha = endAlpha;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (animationStyle > 20 && animationStyle < 30) {
        UIView *curtineView = [[UIView alloc] initWithFrame:self.frame];
        curtineView.userInteractionEnabled = NO;
        curtineView.clipsToBounds = YES;
        curtineView.backgroundColor = [UIColor clearColor];
        [self.superview addSubview:curtineView];
        [self.superview insertSubview:curtineView belowSubview:self];
        [curtineView addSubview:self];
        
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        CGAffineTransform saveTrans = curtineView.transform;
        curtineView.transform = CGAffineTransformMakeScale(startScale, startScale);
        self.alpha = startAlpha;
        
        CGRect save = curtineView.frame;
        if (animationStyle == AOAnimationCurtineCurtineRight) {
            curtineView.frame = CGRectMake(save.origin.x, save.origin.y, startValue, save.size.height);
        } else if (animationStyle == AOAnimationCurtineCurtineBottom) {
            curtineView.frame = CGRectMake(save.origin.x, save.origin.y, save.size.width, startValue);
        } 
        
        [UIView animateWithDuration:duration*2.0/3.0 delay:delay options:options animations:^{
            if (animationStyle == AOAnimationCurtineCurtineRight) {
                curtineView.frame = CGRectMake(save.origin.x, save.origin.y, stopValue, save.size.height);
            } else if (animationStyle == AOAnimationCurtineCurtineBottom) {
                curtineView.frame = CGRectMake(save.origin.x, save.origin.y, save.size.width, stopValue);
            }
            curtineView.transform = saveTrans;
            self.alpha = endAlpha;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)aoAnimation:(AnimationStyle)animationStyle option:(UIViewAnimationOptions)options duration:(float)duration delay:(float)delay startScale:(float)startScale startAlpha:(float)startAlpha angle:(float)startAngle valueOne:(float)valueOne valueTwo:(float)valueTwo
{
    CGAffineTransform save = self.transform;
    float endAlpha = 0.99;
    if (animationStyle == AOAnimationPop) {
        self.alpha = startAlpha;
        self.transform = CGAffineTransformScale(self.transform, startScale, startScale);
    
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.transform = save;
            self.alpha = endAlpha;
        } completion:^(BOOL finished) {
        
        }];
    }
    
    if (animationStyle == AOAnimationPopAndBack) {
        self.alpha = startAlpha;
        self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        [UIView animateWithDuration:duration*2.0/3.0 delay:delay options:options animations:^{
            self.transform = CGAffineTransformMakeScale(1.10, 1.10);
            self.alpha = endAlpha;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration*1.0/3.0 delay:0 options:options animations:^{
                self.transform = save;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    
    if (animationStyle > 20 && animationStyle < 30) {
        UIView *curtineView = [[UIView alloc] initWithFrame:self.frame];
        curtineView.userInteractionEnabled = NO;
        curtineView.clipsToBounds = YES;
        curtineView.backgroundColor = [UIColor clearColor];
        [self.superview addSubview:curtineView];
        [self.superview insertSubview:curtineView belowSubview:self];
        [curtineView addSubview:self];
        
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        CGAffineTransform saveTrans = curtineView.transform;
        curtineView.transform = CGAffineTransformMakeScale(startScale, startScale);
        self.alpha = startAlpha;
        
        CGRect save = curtineView.frame;
        if (animationStyle == AOAnimationCurtineTop) {
            curtineView.frame = CGRectMake(save.origin.x, save.origin.y+save.size.height, save.size.width, 0);
        } else if (animationStyle == AOAnimationCurtineRight) {
            curtineView.frame = CGRectMake(save.origin.x, save.origin.y, 0, save.size.height);
        } else if (animationStyle == AOAnimationCurtineBottom) {
            curtineView.frame = CGRectMake(save.origin.x, save.origin.y, save.size.width, 0);
        } else if (animationStyle == AOAnimationCurtineLeft) {
            curtineView.frame = CGRectMake(save.origin.x+save.size.width, save.origin.y, 0, save.size.height);
        }
        
        [UIView animateWithDuration:duration*2.0/3.0 delay:delay options:options animations:^{
            curtineView.frame = save;
            curtineView.transform = saveTrans;
            self.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (animationStyle > 30 && animationStyle < 40) {
        
        float endAlpha = 0.99;
        CGAffineTransform saveTrans = self.transform;
        
        if (animationStyle == AOAnimationFlyInTop) {
            self.transform = CGAffineTransformMakeTranslation(0, -self.frame.origin.y-self.frame.size.height);
        } else if (animationStyle == AOAnimationFlyInRight) {
            self.transform = CGAffineTransformMakeTranslation(1024-self.frame.origin.x, 0);
        } else if (animationStyle == AOAnimationFlyInBottom) {
            self.transform = CGAffineTransformMakeTranslation(0, 768-self.frame.origin.y);
        } else if (animationStyle == AOAnimationFlyInLeft) {
            self.transform = CGAffineTransformMakeTranslation(-self.frame.size.width-self.frame.origin.x, 0);
        }
        
        self.transform = CGAffineTransformScale(self.transform, startScale, startScale);
        self.alpha = startAlpha;
        
        [UIView animateWithDuration:duration*2.0/3.0 delay:delay options:options animations:^{
            self.transform = saveTrans;
            self.alpha = endAlpha;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (animationStyle == AOAnimationPushUp) {
        
        [UIView animateWithDuration:duration*2.0/3.0 delay:delay options:options animations:^{
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
            self.alpha = endAlpha;
            //self.layer.shadowColor = [[UIColor blackColor] CGColor];
            //self.layer.shadowOpacity = 0.5;
            
            
        } completion:^(BOOL finished) {
            //self.layer.shadowRadius = 5.5;
            //self.layer.shadowOffset = CGSizeMake(10, 10);
        }];
    }
    
    if (animationStyle == AOAnimationInfinitePulse) {
        float endAlpha = 0.99;
       // self.alpha = 1;
        self.alpha = 0.1;
        //self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        self.transform = CGAffineTransformMakeScale(1, 1);
        
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.transform = save;
           // self.alpha = startAlpha;
        } completion:^(BOOL finished) {
            CABasicAnimation *theAnimation;
            theAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            theAnimation.duration = duration;
            theAnimation.repeatCount = HUGE_VALF;
            theAnimation.autoreverses = YES;
            //theAnimation.fromValue = [NSNumber numberWithFloat:1.0];
            theAnimation.fromValue = [NSNumber numberWithFloat:0.0];

            theAnimation.toValue = [NSNumber numberWithFloat:startAlpha];
            theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [self.layer addAnimation:theAnimation forKey:@"animateOpacity"];
            
            CABasicAnimation *scale;
            scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scale.duration = duration;
            scale.repeatCount = HUGE_VALF;
            scale.autoreverses = YES;
            scale.fromValue = [NSNumber numberWithFloat:1.0];
            scale.toValue = [NSNumber numberWithFloat:startScale];
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [self.layer addAnimation:scale forKey:@"animateScale"];
        }];
    }
    
    if (animationStyle == AOAnimationInfiniteHustawka) {
        
        UIView *vieww = [[UIView alloc] initWithFrame:self.frame];
        vieww.backgroundColor = [UIColor clearColor];
        vieww.alpha = 0;
        [self.superview addSubview:vieww];
        [vieww addSubview:self];
        self.frame = self.bounds;
        
        [self setAnchorPoint:CGPointMake(1, 0) forView:self];
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            vieww.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
        self.transform = CGAffineTransformIdentity;
        CABasicAnimation *theAnimation1;
        theAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        theAnimation1.duration = duration;
        theAnimation1.repeatCount = HUGE_VALF;
        theAnimation1.autoreverses = YES;
        theAnimation1.fromValue = [NSNumber numberWithFloat:startAlpha];
        theAnimation1.toValue = [NSNumber numberWithFloat:1];
        theAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:theAnimation1 forKey:@"animateOpacity"];
        
        CABasicAnimation *theAnimation;
        theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        theAnimation.duration = duration;
        theAnimation.repeatCount = HUGE_VALF;
        theAnimation.autoreverses = YES;
        theAnimation.fromValue = [NSNumber numberWithFloat:startAngle*M_PI/180];
        theAnimation.toValue = [NSNumber numberWithFloat:-startAngle*M_PI/180];
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:theAnimation forKey:@"animateRotation"];
        
        CABasicAnimation *scale;
        scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scale.duration = duration;
        scale.repeatCount = HUGE_VALF;
        scale.autoreverses = YES;
        scale.fromValue = [NSNumber numberWithFloat:startScale];
        scale.toValue = [NSNumber numberWithFloat:2-startScale];
        scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:scale forKey:@"animateScale"];
    }
    
    if (animationStyle == AOAnimationInfiniteKiwanie) {
        
        UIView *vieww = self;
        
        [self setAnchorPoint:CGPointMake(valueOne, valueTwo) forView:self];
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            vieww.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
        CABasicAnimation *theAnimation;
        theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        theAnimation.duration = duration;
        theAnimation.repeatCount = HUGE_VALF;
        theAnimation.autoreverses = YES;
        theAnimation.fromValue = [NSNumber numberWithFloat:startAngle*M_PI/180];
        theAnimation.toValue = [NSNumber numberWithFloat:-startAngle*M_PI/180];
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:theAnimation forKey:@"animateRotation"];
    }
    
    if (animationStyle > 60 && animationStyle < 70) {
           float endAlpha = 0.99;
        CGRect save = self.frame;
        
        if (animationStyle == AOAnimationSlideTop) {
            self.frame = CGRectMake(save.origin.x, save.origin.y+save.size.height, save.size.width, 0);
        } else if (animationStyle == AOAnimationSlideRight) {
            self.frame = CGRectMake(save.origin.x, save.origin.y, 0, save.size.height);
        } else if (animationStyle == AOAnimationSlideBottom) {
            self.frame = CGRectMake(save.origin.x, save.origin.y, save.size.width, 0);
        } else if (animationStyle == AOAnimationSlideLeft) {
            self.frame = CGRectMake(save.origin.x+save.size.width, save.origin.y, 0, save.size.height);
        }
        
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.frame = save;
            self.alpha = endAlpha;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (animationStyle == AOAnimationRotate) {
        
        CGAffineTransform saveTrans = self.transform;
        
        [self setAnchorPoint:CGPointMake(1, 0) forView:self];
        self.transform = CGAffineTransformRotate(self.transform, startAngle*M_PI/180);
        self.transform = CGAffineTransformScale(self.transform, startScale, startScale);
        
        self.alpha = startAlpha;
        
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.transform = saveTrans;
            self.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    if (animationStyle == AOAnimationRotationAdd) {
        
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.transform = CGAffineTransformRotate(self.transform, startScale*M_PI/180);
            self.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    if (animationStyle == AOAnimationLoopBlink) {
    
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            CABasicAnimation *theAnimation;
            theAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            theAnimation.duration = duration;
            theAnimation.repeatCount = (int)startScale;
            theAnimation.autoreverses = YES;
            theAnimation.fromValue = [NSNumber numberWithFloat:1.0];
            theAnimation.toValue = [NSNumber numberWithFloat:startAlpha];
            theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            [self.layer addAnimation:theAnimation forKey:@"animateOpacity"];
        }];
    }
    if (animationStyle == AOAnimationAutoHide) {
        
        [self.superview bringSubviewToFront:self];
        
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration delay:startScale options:options animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    if (animationStyle == AOAnimationTransformMakePre) {
        
        CGAffineTransform saveTrans = self.transform;
        self.transform = CGAffineTransformMake(0, 0.1, 0, 0, 0, 0);
        
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.transform = saveTrans;
            self.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    if (animationStyle == AOAnimation3DFlipLeft) {
        
        self.alpha = 1;
        UIView *transView = [[UIView alloc] initWithFrame:self.frame];
        transView.userInteractionEnabled = NO;
        transView.clipsToBounds = YES;
        transView.backgroundColor = [UIColor redColor];
        [self.superview addSubview:transView];
        [self.superview insertSubview:transView belowSubview:self];
        [transView addSubview:self];
    }
    if (animationStyle == AOAnimation3DPaper) {
        
        [UIView animateWithDuration:0.1 delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            self.alpha = 0.001;
        } completion:^(BOOL finished) {
            self.alpha = startAlpha;
            [UIView transitionWithView:self duration:duration options:options animations:^{
                self.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        }];
        
    }
    if (animationStyle == AOAnimationSpecialBalon) {
        
        self.transform = CGAffineTransformMakeScale(0.2, 0.2);
        [UIView animateWithDuration:duration delay:delay options:options animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
                self.transform = CGAffineTransformMakeScale(startScale, startScale);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
                    self.transform = CGAffineTransformMakeScale((1-startScale)*0.5+startScale, (1-startScale)*0.5+startScale);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
                        self.transform = CGAffineTransformMakeScale(1, 1);
                    } completion:^(BOOL finished) {
                        
                    }];
                }];
            }];
        }];
        
    }
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

- (void)aoAnimationFrame:(int)num interval:(float)inter preName:(NSString*)prename format:(NSString*)format duration:(float)dur delay:(float)del {

    NSString *nname = [NSString stringWithFormat:@"%@%03d.%@", prename, 1, format];
    
    UIImageView *me = (UIImageView*)self;
    me.image = [UIImage imageNamed:nname];
    
    [UIView animateWithDuration:dur delay:del options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        for (int i = 1; i <= num; i++) {
            NSString *name = [NSString stringWithFormat:@"%@%03d.%@", prename, i, format];
            [self performSelector:@selector(changeFrame:) withObject:name afterDelay:i*inter];
        }
    }];
}

- (void)changeFrame:(NSString*)name {
    UIImageView *me = (UIImageView*)self;
    me.image = [UIImage imageNamed:name];
}

@end
