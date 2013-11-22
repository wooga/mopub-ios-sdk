//
//  MPInterstitialAdManagerDelegate.h
//  MoPub
//
//  Copyright (c) 2013 MoPub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPInterstitialAdManager;
@class MPInterstitialAdController;
@class CLLocation;

@protocol MPInterstitialAdManagerDelegate <NSObject>

- (MPInterstitialAdController *)interstitialAdController;
- (CLLocation *)location;
- (id)interstitialDelegate;
- (void)managerDidLoadInterstitial:(MPInterstitialAdManager *)manager;
- (void)manager:(MPInterstitialAdManager *)manager
didFailToLoadInterstitialWithError:(NSError *)error;
- (void)managerWillPresentInterstitial:(MPInterstitialAdManager *)manager withCustomEvent:(MPInterstitialCustomEvent *)customEvent;
- (void)managerDidPresentInterstitial:(MPInterstitialAdManager *)manager;
- (void)managerWillDismissInterstitial:(MPInterstitialAdManager *)manager;
- (void)managerDidDismissInterstitial:(MPInterstitialAdManager *)manager withCustomEvent:(MPInterstitialCustomEvent *)customEvent;
- (void)managerDidExpireInterstitial:(MPInterstitialAdManager *)manager;
- (void)managerWasClickedInterstitial:(MPInterstitialAdManager *)manager andCustomEvent:(MPInterstitialCustomEvent *)customEvent;


@end
