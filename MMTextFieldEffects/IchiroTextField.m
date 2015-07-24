//
//  IchiroTextField.m
//  BWWalkthroughExample
//
//  Created by mukesh mandora on 15/07/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

#import "IchiroTextField.h"

@interface IchiroTextField (){
    //    UILabel *self.self.placeholder;
    CGFloat inset;
    CALayer *borderTextField,*contentTextfield;
    CGPoint textFieldInset,placeholderInset;
}
@property (strong ,nonatomic) UILabel *placeHolderLabel;
@property (nonatomic) CGFloat placeholderHeight;
@end
@implementation IchiroTextField
@synthesize placeHolderLabel;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //Setframes
    contentTextfield.frame = CGRectMake(placeholderInset.x, self.bounds.size.height, self.bounds.size.width-placeholderInset.x*2, 0);
    contentTextfield.backgroundColor=[UIColor whiteColor].CGColor;
    borderTextField.frame = CGRectMake(0, 25, self.bounds.size.width, self.bounds.size.height-25);
    
    self.placeHolderLabel.frame=CGRectMake(placeholderInset.x, borderTextField.frame.size.height/2+10+placeholderInset.x, self.bounds.size.width, 20);
    self.backgroundColor=[UIColor clearColor];


    [self setBorderLayer];
    [self addPlaceHolderLabel];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    self.delegate = self;
    if (self) {
        self.placeHolderLabel = [[UILabel alloc] init];
        
        self.placeHolderLabel.text = @"First Name";
        self.placeHolderLabel.textColor = [UIColor lightGrayColor];
        self.placeHolderLabel.backgroundColor=[UIColor clearColor];
        self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:18.0];
        
        self.placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        
        //Inset
        placeholderInset = CGPointMake(6, 3);
        textFieldInset = CGPointMake(6, 6);
        
        //Init
        contentTextfield=[[CALayer alloc] init];
        borderTextField=[[CALayer alloc] init];
       
        
        borderTextField.backgroundColor=[UIColor whiteColor].CGColor;
        
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
    [self.layer addSublayer:contentTextfield];
}


-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectOffset(contentTextfield.bounds, textFieldInset.x*2, textFieldInset.y*2+[self placeholderHeight]);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    [UIView transitionWithView:self.placeHolderLabel duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        borderTextField.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14.0];
        self.placeHolderLabel.frame=CGRectMake(placeholderInset.x, placeholderInset.y, self.bounds.size.width, 20);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            contentTextfield.frame = CGRectMake(placeholderInset.x, 25, self.bounds.size.width-placeholderInset.x*2, self.bounds.size.height-25-placeholderInset.x);
            contentTextfield.backgroundColor=[UIColor lightGrayColor].CGColor;
            
        }];
    }];
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if([textField.text isEqual:@""]){
        
        
        [UIView animateWithDuration:0.2 animations:^{
            contentTextfield.frame = CGRectMake(placeholderInset.x, self.bounds.size.height, self.bounds.size.width-placeholderInset.x*2, 0);
            contentTextfield.backgroundColor=[UIColor whiteColor].CGColor;

        } completion:^(BOOL finished) {
            [UIView transitionWithView:self.placeHolderLabel duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                borderTextField.frame = CGRectMake(0, 25, self.bounds.size.width, self.bounds.size.height-25);
                
                self.placeHolderLabel.frame=CGRectMake(placeholderInset.x, borderTextField.frame.size.height/2+10+placeholderInset.x, self.bounds.size.width, 20);
                self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:18.0];
                
                
            } completion:nil];

        }];


    }
    
}
@end

