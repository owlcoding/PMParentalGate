//
//  PMParentalGateQuestion.m
//  LanguageSkillBuilder
//
//  Created by Pawel Maczewski on 23/01/14.
//  Copyright (c) 2014 OwlCoding. All rights reserved.
//

#import "PMParentalGateQuestion.h"

@interface PMParentalGateQuestion ()
@property (nonatomic, assign) NSInteger selectedEquationIdx;
@property (nonatomic, copy) FinishedBlock finished;
@end

@implementation PMParentalGateQuestion


static PMParentalGateQuestion* __gate = nil;

+ (id) sharedGate
{
    @synchronized ( self ) {
        if (__gate == nil) {
            __gate = [[PMParentalGateQuestion alloc] init];
            
            __gate.equations = @[
                               @[@"2 x 9", @18],
                               @[@"8 x 5", @40],
                               @[@"6 x 6", @36],
                               @[@"5 x 9", @45],
                               @[@"7 x 3", @21],
                               @[@"7 x 6", @42],
                               ];

        }
    }
    return __gate;
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        self.finished ( NO, GR_CANCEL );
        return;
    }
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
        // check result
        int a = [[[alertView textFieldAtIndex:0] text] intValue];
        if (a == [self.equations[self.selectedEquationIdx][1] intValue]) {
            self.finished ( YES, GR_GOOD );
        } else {
            self.finished ( NO, GR_WRONG );
        }
    }
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.finished ( NO, GR_TIMEOUT );
}
- (void) presentGateWithText:(NSString *) textQuestion timeout:(CGFloat) timeout finishedBlock:(FinishedBlock) finished
{
    self.finished = finished;
    self.selectedEquationIdx = arc4random() % self.equations.count;
    if (0 == timeout) {
        timeout = 10;
    }
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:[NSString stringWithFormat:
                                                          @"Parental Gate: %@ = ?\n%@",
                                                          self.equations[self.selectedEquationIdx][0],
                                                          (nil == textQuestion ? @"Reaching an area restricted to parents" : textQuestion)]
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"Ok", nil];
    
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[av textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [av show];
    [av performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:[NSNumber numberWithInt:0] afterDelay:timeout];

}

@end
