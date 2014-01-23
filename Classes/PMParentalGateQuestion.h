//
//  PMParentalGateQuestion.h
//  LanguageSkillBuilder
//
//  Created by Pawel Maczewski on 23/01/14.
//  Copyright (c) 2014 OwlCoding. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    GR_GOOD,
    GR_WRONG,
    GR_TIMEOUT,
    GR_CANCEL,
} GateResult;

typedef void (^FinishedBlock)(BOOL allowPass, GateResult result);

@interface PMParentalGateQuestion : NSObject <UIAlertViewDelegate>

@property (nonatomic, strong) NSArray * equations;


- (void) presentGateWithText:(NSString *) textQuestion timeout:(CGFloat) timeout finishedBlock:(FinishedBlock) finished;
+ (id) sharedGate;

@end
