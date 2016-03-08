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
- (void) timedoutForAlertView:(UIAlertView *) alertView
{
    self.finished ( NO, GR_TIMEOUT );
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timedoutForAlertView:) object:alertView];
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

- (void) presentGateWithText:(NSString *) textQuestion timeout:(CGFloat) timeout finishedBlock:(FinishedBlock) finished
{
    self.finished = finished;
    self.selectedEquationIdx = arc4random() % self.equations.count;
    if (0 == timeout) {
        timeout = 10;
    }
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:[NSString stringWithFormat:
                                                          @"%@ = ?\n%@",
                                                          self.equations[self.selectedEquationIdx][0],
                                                          (nil == textQuestion ? NSLocalizedText(@"Reaching an area restricted to parents", @"") : textQuestion)]
                                                delegate:self
                                       cancelButtonTitle:NSLocalizedText(@"Cancel", @"Cancel button title")
                                       otherButtonTitles:NSLocalizedText(@"Ok", @"OK button title"), nil];
    
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[av textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [av show];
    [self performSelector:@selector(timedoutForAlertView:) withObject:av afterDelay:timeout];

}

@end
