//
//  NarikoTextField.m
//  BWWalkthroughExample
//
//  Created by mukesh mandora on 15/07/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

#import "NarikoTextField.h"

@interface NarikoTextField (){
    //    UILabel *self.self.placeholder;
    CGFloat inset;
    CALayer *borderTextField,*contentTextfield;
    CGPoint textFieldInset,placeholderInset;
}
@property (strong ,nonatomic) UILabel *placeHolderLabel;
@property (nonatomic) CGFloat placeholderHeight;
@end
@implementation NarikoTextField
@synthesize placeHolderLabel;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     contentTextfield.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0);
    borderTextField.frame = CGRectMake(0, self.bounds.size.height-3, self.bounds.size.width, 3);
     self.placeHolderLabel.frame=CGRectMake(placeholderInset.x, self.bounds.size.height-28, self.bounds.size.width, 20);
    [self setBorderLayer];
    [self addPlaceHolderLabel];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    self.delegate = self;
    if (self) {
        self.placeHolderLabel = [[UILabel alloc] init];
        
        self.placeHolderLabel.text = @"Add comment here";
        self.placeHolderLabel.textColor = [UIColor whiteColor];
        self.placeHolderLabel.backgroundColor=[UIColor clearColor];
        self.placeHolderLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14.0];
        self.placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        
        
        placeholderInset = CGPointMake(6, 3);
        textFieldInset = CGPointMake(6, 6);
        
        
        contentTextfield=[[CALayer alloc] init];
       
        contentTextfield.backgroundColor=[UIColor whiteColor].CGColor;
        
        
        borderTextField=[[CALayer alloc] init];
        
        borderTextField.borderColor=[UIColor colorWithRed:0.901 green:0.3176  blue:0. alpha:1.0].CGColor;
        borderTextField.borderWidth=3.0f;
        borderTextField.backgroundColor=[UIColor whiteColor].CGColor;
       
        self.backgroundColor=[UIColor clearColor];
        
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
    [self.layer addSublayer:borderTextField];
    [self.layer addSublayer:contentTextfield];
}


-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectOffset(contentTextfield.bounds, textFieldInset.x, textFieldInset.y*2+[self placeholderHeight]);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.placeHolderLabel.frame=CGRectMake(placeholderInset.x, placeholderInset.y, self.bounds.size.width, 20);
        borderTextField.frame = CGRectMake(0, 25, self.bounds.size.width, 3);
        contentTextfield.frame = CGRectMake(0, 25+3, self.bounds.size.width, self.bounds.size.height-25);
        contentTextfield.backgroundColor=[UIColor whiteColor].CGColor;
        
    }];
    
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if([textField.text isEqual:@""]){
        
        
        [UIView transitionWithView:self.placeHolderLabel duration:0.3 options:0 animations:^{
            
            borderTextField.frame = CGRectMake(0, self.bounds.size.height-3, self.bounds.size.width, 3);
            self.placeHolderLabel.frame=CGRectMake(placeholderInset.x, self.bounds.size.height-28, self.bounds.size.width, 20);
            contentTextfield.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0);
            contentTextfield.backgroundColor=[UIColor whiteColor].CGColor;
            
        } completion:nil];
        
        
    }
    
}
@end


