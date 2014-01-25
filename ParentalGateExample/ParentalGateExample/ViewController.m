//
//  ViewController.m
//  ParentalGateExample
//
//  Created by Pawel Maczewski on 25/01/14.
//  Copyright (c) 2014 OwlCoding. All rights reserved.
//

#import "ViewController.h"
#import "PMParentalGateQuestion.h"

@interface ViewController ()
- (IBAction)parentsAreaTap:(UIButton *)sender;

@end

@implementation ViewController

- (IBAction)parentsAreaTap:(UIButton *)sender {
    [[PMParentalGateQuestion sharedGate] presentGateWithText:@"You're trying to access a parents and therapits-only area. Prove you're not a kiddo." timeout:8.0f finishedBlock:^(BOOL allowPass, GateResult result) {
        if (allowPass) {
            NSLog(@"It's not a kid");
        } else {
            NSLog(@"Something's not right!");
        }
        NSString *reason;
        switch (result) {
            case GR_CANCEL:
                reason = @"Cancel Pressed";
                break;
            case GR_TIMEOUT:
                reason = @"Timed Out";
                break;
            case GR_WRONG:
                reason = @"Wrong Answer Given";
                break;
            case GR_GOOD:
                reason = @"Answer Was Good";
                break;
                
            default:
                break;
        }
        [[[UIAlertView alloc] initWithTitle:@"ParentalGate Results"
                                    message:[NSString stringWithFormat:@"You are %@allowed to enter.\nYour authorization result was %@", allowPass ? @"" : @"not ", reason]
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles: nil] show];
    }];
}
@end
