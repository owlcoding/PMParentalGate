PMParentalGate
==============

A drop-in class for iOS applications that allow to add a parental-gate to the app

Installation
============

You can use CocoaPods to install the PMParentalGate. Add the following line to your Podfile:

     pod 'PMParentalGate'

Or you can just drop the content of the Classes/ directory into your Xcode project. 

Usage
=====

An example use of the gate to restrict the In-App purchase: 

    [[PMParentalGateQuestion sharedGate] presentGateWithText:nil timeout:10 finishedBlock:^(BOOL allowPass, GateResult result) {
        if (allowPass) {
            [Flurry logEvent:@"unlockAllPressed" withParameters:@{@"moduleId": self.quiz.purchaseID}];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[InAppPurchaseHelper sharedInstance] buyProductWithId:@"fullpro"];
        }
    }];
