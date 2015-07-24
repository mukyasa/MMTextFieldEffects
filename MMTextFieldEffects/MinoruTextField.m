//
//  MinoruTextField.m
//  BWWalkthroughExample
//
//  Created by mukesh mandora on 17/07/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

#import "MinoruTextField.h"

#import "PulsingHaloLayer.h"
@interface MinoruTextField (){
    //    UILabel *self.self.placeholder;
    CGFloat inset;
    CALayer *borderTextField;
    CGPoint textFieldInset,placeholderInset;
}
@property (strong ,nonatomic) UILabel *placeHolderLabel;
@property (nonatomic) CGFloat placeholderHeight;
@property (nonatomic, weak) PulsingHaloLayer *halo;
@end
@implementation MinoruTextField
@synthesize placeHolderLabel;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
   

    borderTextField.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-20);
    
    self.placeHolderLabel.frame=CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20);
    
     ;
    [self setBorderLayer];
    [self addPlaceHolderLabel];
    
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    self.delegate = self;
    if (self) {
        self.placeHolderLabel = [[UILabel alloc] init];
        
        self.placeHolderLabel.text = @"Description";
        self.placeHolderLabel.textColor = [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1];
        self.placeHolderLabel.backgroundColor=[UIColor clearColor];
        self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14.0];
        self.placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        
        
        placeholderInset = CGPointMake(6, 6);
        textFieldInset = CGPointMake(6, 6);
        borderTextField=[[CALayer alloc] init];
        
        
        CGRect frame = [self convertRect:self.frame fromView:self.superview];
        
       
        borderTextField.backgroundColor=[UIColor whiteColor].CGColor;
        borderTextField.borderColor=[UIColor whiteColor].CGColor;
        
        borderTextField.borderWidth=1.5f;
        self.backgroundColor=[UIColor clearColor];
        
        ///setup single halo layer
        PulsingHaloLayer *layer = [PulsingHaloLayer layer];
        self.halo = layer;
        self.halo.frame=CGRectMake(0, frame.origin.y, self.bounds.size.width, self.bounds.size.height-30);
       
    
    }
    
    return self;
}

-(void)setPlaceholderHeight:(CGFloat)placeholderHeight{
    
}

-(CGFloat)placeholderHeight{
    
    
    
    UIFont *fontOfText=[UIFont fontWithName:@"HelveticaNeue" size:self.font.pointSize*0.7];
    return placeholderInset.y+fontOfText.lineHeight;
}
- (void)addPlaceHolderLabel
{
    inset=50;
    
    [self addSubview:self.placeHolderLabel];
    
}

-(void)setBorderLayer{
    
    
    //     [self.layer addSublayer:self.halo];
    
//    [self.superview.layer addSublayer:self.halo];
    [self.layer addSublayer:borderTextField];
    [self.superview.layer insertSublayer:self.halo below:self.layer];
}


-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectOffset(borderTextField.bounds, textFieldInset.x*2,[self placeholderHeight]-textFieldInset.y);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
        [UIView transitionWithView:self.placeHolderLabel duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            borderTextField.borderColor=[UIColor colorWithRed:0 green:0.580 blue:0.823 alpha:1.0].CGColor;
            [self.halo startAnimation];

        } completion:^(BOOL finished) {
    
        }];
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if([textField.text isEqual:@""]){
        [UIView transitionWithView:self.placeHolderLabel duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            borderTextField.borderColor=[UIColor clearColor].CGColor;
            [self.halo stopAnimation];
            
        } completion:^(BOOL finished) {
            
        }];
       
    }
    
}

//
@end

