//
//  AdColonyInterstitialCustomEvent.h
//  MoPubSampleApp
//
//  Created by Yuan Ren on 10/22/13.
//  Copyright (c) 2013 MoPub. All rights reserved.
//

#import "MPInterstitialCustomEvent.h"

#import <AdColony/AdColony.h>

/*
 * Certified with version 2.2.4 of the AdColony SDK.
 *
 * The AdColony SDK does not provide an ad clicked callback. As a result, this custom event will not invoke delegate methods
 * interstitialCustomEventDidReceiveTapEvent: and interstitialCustomEventWillLeaveApplication:
 */

@interface AdColonyInterstitialCustomEvent : MPInterstitialCustomEvent <AdColonyAdDelegate>

@end
