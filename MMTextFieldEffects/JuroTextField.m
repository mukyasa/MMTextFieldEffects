//
//  JuroTextField.m
//  BWWalkthroughExample
//
//  Created by mukesh mandora on 15/07/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

#import "JuroTextField.h"
@interface JuroTextField (){
    //    UILabel *self.self.placeholder;
    CGFloat inset;
    CALayer *borderTextField;
    CGPoint textFieldInset,placeholderInset;
}
@property (strong ,nonatomic) UILabel *placeHolderLabel;
@property (nonatomic) CGFloat placeholderHeight;
@end


@implementation JuroTextField
@synthesize placeHolderLabel;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.placeHolderLabel.frame=CGRectMake(18, self.bounds.size.height/2-10, self.bounds.size.width-18, 20);
     borderTextField.frame = self.bounds;
    [self setBorderLayer];
    [self addPlaceHolderLabel];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    self.delegate = self;
    if (self) {
        self.placeHolderLabel = [[UILabel alloc] init];
        
        self.placeHolderLabel.text = @"Add comment here";
        self.placeHolderLabel.textColor = [UIColor lightGrayColor];
        self.placeHolderLabel.backgroundColor=[UIColor clearColor];
        self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:18.0];
        self.placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        
        
        placeholderInset = CGPointMake(6, 6);
        textFieldInset = CGPointMake(6, 6);
        borderTextField=[[CALayer alloc] init];
       
        
        borderTextField.backgroundColor=[UIColor whiteColor].CGColor;
        
        self.backgroundColor=[UIColor colorWithRed:0 green:0.580 blue:0.823 alpha:1.0];
        
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
    inset=50;
    
    [self addSubview:self.placeHolderLabel];
    
}

-(void)setBorderLayer{
    [self.layer addSublayer:borderTextField];
}


-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectOffset(borderTextField.bounds, textFieldInset.x*2, textFieldInset.y*2+[self placeholderHeight]);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView transitionWithView:self.placeHolderLabel duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        borderTextField.frame=CGRectMake(textFieldInset.x, textFieldInset.y+[self placeholderHeight], self.bounds.size.width-textFieldInset.x*2, self.bounds.size.height-textFieldInset.y*2-[self placeholderHeight]);
        self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14.0];
        self.placeHolderLabel.textColor = [UIColor whiteColor];
        
        
        self.placeHolderLabel.frame=CGRectMake(8, 3, self.bounds.size.width, 20);
        
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
            self.placeHolderLabel.frame=CGRectMake(18, self.bounds.size.height/2-10, self.bounds.size.width-18, 20);
            self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:18.0];
            borderTextField.frame=self.bounds;
            self.placeHolderLabel.textColor = [UIColor lightGrayColor];
            
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}
@end
