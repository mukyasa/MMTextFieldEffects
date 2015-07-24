//
//  KuroTextField.m
//  BWWalkthroughExample
//
//  Created by mukesh mandora on 15/07/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

#import "KuroTextField.h"

@interface KuroTextField (){
   
    CAShapeLayer *leftLayer,*rightLayer;
    CGPoint textFieldInset,placeholderInset;
}
@property (strong ,nonatomic) UILabel *placeHolderLabel;
@property (nonatomic) CGFloat placeholderHeight;


@end
@implementation KuroTextField
@synthesize placeHolderLabel;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //    [self setBorderLayer];
    
    
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    // Set the starting point of the shape.
    [leftPath moveToPoint:CGPointMake(self.bounds.size.width/2,3)];
    // Draw the lines.
    [leftPath addLineToPoint:CGPointMake(textFieldInset.x*3,3)];
    [leftPath addLineToPoint:CGPointMake(textFieldInset.x*3,self.bounds.size.height-textFieldInset.y*4)];
    [leftPath addLineToPoint:CGPointMake(self.bounds.size.width/2,self.bounds.size.height-textFieldInset.y*4)];
    
    
    leftLayer.path = leftPath.CGPath;
    leftLayer.strokeColor = [[UIColor whiteColor] CGColor];
    leftLayer.fillColor = nil;
    leftLayer.borderWidth = 3.0f;
    leftLayer.lineCap = kCALineCapRound;
    leftLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:leftLayer];
    
    
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    // Set the starting point of the shape.
    [rightPath moveToPoint:CGPointMake(self.bounds.size.width/2,3)];
    // Draw the lines.
    [rightPath addLineToPoint:CGPointMake(self.bounds.size.width-textFieldInset.x*3,3)];
    [rightPath addLineToPoint:CGPointMake(self.bounds.size.width-textFieldInset.x*3,self.bounds.size.height-textFieldInset.y*4)];
    [rightPath addLineToPoint:CGPointMake(self.bounds.size.width/2,self.bounds.size.height-textFieldInset.y*4)];
    
    
    
    rightLayer.path = rightPath.CGPath;
    rightLayer.strokeColor = [[UIColor whiteColor] CGColor];
    rightLayer.fillColor = nil;
    rightLayer.borderWidth = 3.0f;
    rightLayer.lineCap = kCALineCapRound;
    rightLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:rightLayer];
     [self addPlaceHolderLabel];
    
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    self.delegate = self;
    if (self) {
        placeholderInset = CGPointMake(6, 6);
        textFieldInset = CGPointMake(6, 6);

        self.placeHolderLabel = [[UILabel alloc] init];
        
        
        NSLog(@"%f",self.bounds.size.width-50);
        self.placeHolderLabel.text = @"Username";
        self.placeHolderLabel.textColor = [UIColor whiteColor];
        self.placeHolderLabel.backgroundColor=[UIColor clearColor];
        self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0];
        self.placeHolderLabel.textAlignment = NSTextAlignmentCenter;
        //        self.placeHolderLabel.frame=CGRectOffset(self.placeHolderLabel.frame, 0, 10*textFieldInset.y);
        
        
        leftLayer = [CAShapeLayer layer];
        rightLayer = [CAShapeLayer layer];
        
        self.backgroundColor=[UIColor clearColor];
        
        
        
        
    }
    
    return self;
}

-(void)setPlaceholderHeight:(CGFloat)placeholderHeight{
    
}

-(CGFloat)placeholderHeight{
    
    
    
    UIFont *fontOfText=[UIFont fontWithName:@"AvenirNext-Medium" size:self.font.pointSize*0.7];
    return placeholderInset.y+fontOfText.lineHeight;
}
- (void)addPlaceHolderLabel
{
    self.placeHolderLabel.frame=CGRectMake(textFieldInset.x*3, self.bounds.size.height/2-24, self.bounds.size.width-textFieldInset.x*6, 24);

    
    [self addSubview:self.placeHolderLabel];
    
}

-(void)setBorderLayer{
    
}


-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectOffset(self.bounds, 0,0);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if([textField.text isEqual:@""]){
        [UIView transitionWithView:self.placeHolderLabel duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
            leftLayer.frame=CGRectOffset(leftLayer.frame, -textFieldInset.x*2, 0);
            rightLayer.frame=CGRectOffset(rightLayer.frame, textFieldInset.x*2, 0);
            self.placeHolderLabel.transform = CGAffineTransformMakeScale(0.0, 0.0);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.placeHolderLabel.transform = CGAffineTransformIdentity;
                self.placeHolderLabel.frame=CGRectMake(textFieldInset.x*3, self.bounds.size.height-textFieldInset.y*3, self.bounds.size.width-textFieldInset.x*6, 24);
            }];
            
        }];
    }
    
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if([textField.text isEqual:@""]){
        [UIView transitionWithView:self.placeHolderLabel duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
            leftLayer.frame=CGRectOffset(leftLayer.frame, textFieldInset.x*2, 0);
            rightLayer.frame=CGRectOffset(rightLayer.frame, -textFieldInset.x*2, 0);
            self.placeHolderLabel.transform = CGAffineTransformMakeScale(0.0, 0.0);
            
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                
                self.placeHolderLabel.transform = CGAffineTransformIdentity;
                self.placeHolderLabel.frame=CGRectMake(textFieldInset.x*3, self.bounds.size.height/2-24, self.bounds.size.width-textFieldInset.x*6, 24);
            }];
        }];
    }
    
}

@end
