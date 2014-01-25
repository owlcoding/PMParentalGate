PMParentalGate
==============

Since the introduction of special 'Kids' category in the App Store, Apple has enforced developers to perform a good practice - guarding anything that's not targeted for the kids by the 'Parental Gate'. This means that any links to other apps, or to App Store ratings or any In-App purchases should be guarded from the kid's access. 

One of the ways to perform this task is to ask the user to perform some kind of operation that, in general, the kid can not do (we're talking about quite small kids here) - like triple-tapping the button instead of a single tap, or solving a simple math equation... 

This control allows for a simple, one-line "equation" gate. 

This is released as-is under the terms of [MIT License](https://github.com/owlcoding/PMParentalGate/blob/master/LICENSE).

Installation
------------

You can use CocoaPods to install the PMParentalGate. Add the following line to your Podfile:

     pod 'PMParentalGate'

Or you can just drop the content of the Classes/ directory into your Xcode project. 

Usage
-----

An example use of the gate to restrict the In-App purchase: 

    [[PMParentalGateQuestion sharedGate] presentGateWithText:nil timeout:10 finishedBlock:^(BOOL allowPass, GateResult result) {
        if (allowPass) {
            [Flurry logEvent:@"unlockAllPressed" withParameters:@{@"moduleId": self.quiz.purchaseID}];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[InAppPurchaseHelper sharedInstance] buyProductWithId:@"fullpro"];
        }
    }];

Screenshots
-----------
![Parental Gate question](https://raw2.github.com/owlcoding/PMParentalGate/master/ScreenShot1.png)

![Parental Gate Result](https://raw2.github.com/owlcoding/PMParentalGate/master/ScreenShot2.png)

Author
------

If you wish to contact me, email at: kender@codingslut.com
