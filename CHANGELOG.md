## Version 1.17 (November 20, 2013)

  - AdColony Custom Event
    - Supports AdColony as a custom native ad network for interstitial videos. Note that V4VC (virtual currency reward) is currently not supported. 
  - Handle ISO Latin-1 site encoding in addition to UTF-8
  - Bug fixes

### Version 1.17.3.0 (March 20th, 2014)

  - Updated Chartboost custom event (Chartboost SDK 4.0+ only)
  - Bug fixes
    - Fixed iOS 7 bug where certain interstitial images may fail to load

### Version 1.17.2.0 (February 20th, 2014)

  - Updated InMobi custom events (InMobi SDK 4.0.3+ only)
  - Bug fixes
    - MRAID viewable property now correctly updates on app background and resume
    - MRAID command urls are no longer re-encoded for processing

### Version 1.17.1.0 (January 23rd, 2014)

  - Sample app improvements
    - Improved manual ad unit entry view
    - Save manually entered ad unit ids
    - Ability to enter keywords for each ad unit
  - Bug fixes
    - MRAID `isViewable` command now correctly returns a boolean value

## Version 1.16 (October 15, 2013)

  - Creative Controls
    - Creative Flagging 
      - **Important**: ```MPAdAlertGestureRecognizer``` and ```MPAdAlertManager``` classes as well as ```MessageUI.framework``` must be added to your project to enable flagging functionality.
      - Allows users to report certain inappropriate ad experiences directly to MoPub with a special gesture.
      - User must swipe back and forth at least four times within the ad view to flag a creative.
      - Swipes must cover more than ⅓ of the ad width and must be completely horizontal.
      - Only works for direct sold, Marketplace, and server to server ad network ads.
    - Blocked Popups
      - Javascript alert, confirm, and prompt dialogs are blocked.
    - Blocked Auto-redirects
      - Ads that automatically redirect users to another page without user interaction are automatically blocked.
  - MoPub Video Pre-caching
    - Video ads from the Marketplace will be pre-cached automatically and videos will not be shown until they can play without additional buffering.
  - Simple Ads Demo Improvements
    - 300x250 and 728x90 test spots added to the demo app.
  - Vungle Custom Event
    - Supports Vungle as a custom native ad network for interstitial videos.
  - SKStoreProductViewController iOS 7 Orientation Crash Fix
    - Fixes iOS 7 bug that causes SKStoreProductViewController to crash if the app does not list portrait as a supported orientation.
  - Log more readable message in response to the "no ads available" server error.
  - Updated mraid.getVersion() to return 2.0

### Version 1.16.0.1 (October 24, 2013)

  - MRAID commands now properly handle encoded URLs.

## Version 1.14 (September 12, 2013)

  - iOS 7 Gold Master support
  - Verified compatibility with latest Millennial iOS SDK (5.1.1)
  - Updated support for InMobi SDK version 4.0
  - Bug fixes

#### Updates to InMobi Integrations
  - **Important**: As of version 1.14.0.0, the InMobi custom events packaged with the MoPub SDK only support InMobi version 4.00 and up. Follow the instructions [here](http://www.inmobi.com/support/art/25856216/22465648/integrating-mopub-with-inmobi-ios-sdk-4-0/) to integrate InMobi version 4.00 and up. If you would like to continue to use a prior version of the InMobi SDK, do not update the custom event files and follow the instructions [here](http://developer.inmobi.com/wiki/index.php?title=MoPub_InMobi_iOS) to integrate.

### Version 1.14.1.0 (September 18, 2013)
  - Fixed an issue causing certain interstitials to be incorrectly centered or sized
  - Updated the SDK bundle to include the Millennial Media 5.1.1 SDK

## Version 1.13 (August 22, 2013)

  - Added support for creating calendar events, storing pictures, and video playback via MRAID APIs
  - Fixed a rendering issue with HTML interstitials on iOS 5
  - Fixed crashes resulting from delegate callbacks being executed on deallocated objects

## Version 1.12 (April 25, 2013)

#### Updates to Third Party Integrations
  - Third-party ad network integrations are **now implemented as custom events instead of adapters**.

    > **Please remove any old adapters from your code and use the new custom events located in the `AdNetworkSupport` folder instead.**

  - Added support for Millennial SDK 5.0
  - Updated Chartboost integration to honor the location parameter (configurable via the server)
  - Updated Custom Events API.
  
    > **If you have implemented a Custom Event, please read the Custom Events [documentation](https://github.com/mopub/mopub-ios-sdk/wiki/Custom-Events) and update your code appropriately.**

#### Updates to the MoPub SDK
  - The MoPub SDK now requires **iOS 4.3+**
  - Removed all references to `[UIDevice uniqueIdentifier]`
  - Added support for opening iTunes links in an `SKStoreProductViewController`
  - Added [session tracking](https://github.com/mopub/mopub-ios-sdk/wiki/Conversion-Tracking#session-tracking)
  - Added numerous data signals (wireless connectivity, location accuracy, bundle version, telephony information) to ad requests
  - Added test coverage to MoPub SDK

#### Distribution and Documentation Updates
  - Added .zip archive distribution options with bundled third party network SDKs.  Learn more at the updated [wiki](https://github.com/mopub/mopub-ios-sdk/wiki/Getting-Started).
  - Added appledoc style [Class Documentation](https://github.com/mopub/mopub-ios-sdk/tree/master/ClassDocumentation)
  - Updated the MoPub Sample Application

### Version 1.12.5.0 (August 1, 2013)
  - Updated to support Millennial SDK 5.1.0
  - Fixed warnings resulting from duplicate category methods
  - Fixed a crash occurring when an interstitial was tapped and dismissed immediately afterwards
  
### Version 1.12.4.0 (June 26, 2013)  
  - Fixed a memory leak when displaying MRAID ads
  
### Version 1.12.3.0 (June 18, 2013)
  - Fixed inconsistency between ad request user agent and click-handling user agent
  - Fixed crashes that occur when banners are deallocated in the process of displaying modal content

### Version 1.12.2.0 (June 7, 2013)
  - Fixed issue causing expanded MRAID banner ads to obscure modal content
  - Fixed issue in which impressions were not tracked properly for MRAID banner ads
  - Added new API methods on `MPAdView` for managing ad refresh behavior (`-startAutomaticallyRefreshingContents` and `-stopAutomaticallyRefreshingContents`)
  - Deprecated `ignoresAutorefresh` property on `MPAdView`

### Version 1.12.1.0 (May 13, 2013)
  - Fixed issue causing banners from custom HTML networks to be improperly sized
  - Updated the SDK bundle to include the Millennial Media 5.0.1 SDK

### Version 1.12.0.1 (April 26, 2013)
  - Fixed some leaks reported by the static analyzer

## Version 1.11 (March 13, 2013)
  - Fixed issue causing a crash for legacy custom event methods
  - Fixed issue causing refresh timer to not be scheduled properly on connection errors
  - Updated the sample Chartboost custom event to avoid improperly setting the Chartboost delegate to nil in -dealloc

## Version 1.10 (February 13, 2013)
  - Introduced custom event classes
  - Fixed issue causing metrics-recording URLs to be incorrect when certain ad sources fail
  - Fixed issue causing interstitials to be sized incorrectly when the status bar changes state
  - Fixed issue preventing loading indicator from being dismissed properly for HTML interstitials
  - Fixed issue that allows the browser controller to continue loading after it has been dismissed
  - Added 'testing' property on `MPAdView` and `MPInterstitialAdController`
  - Increased accuracy of iAd impression tracking

## Version 1.9.0.0 (September 27, 2012)
  - Added support for iOS 6 and the new iPhone 5 screen size
  - Added support for the Facebook ads test program
  - Added support for `ASIdentifierManager` (`UIDevice.identifierForAdvertising` replacement)
  - Re-introduced UDID as a fall-back identifier on earlier iOS ## Versions (with an opt-out mechanism)
  - Fixed issues with redirecting certain native iOS URLs (e.g. itunes.apple.com) in the in-app browser
  - Fixed an issue in which an interstitial might not dismiss properly when leaving an app via a click
  - Updated the SimpleAdsDemo sample app for iOS 6
  - Added clarity to certain console log entries
  - Added some minor visual improvements to the click progress indicator

## Version 1.8.0.0
  - Fixed a crash in `MPAdManager` due to uncanceled NSURLConnections
  - Fixed an issue with mraid://open URL decoding
  - Fixed an issue in which third-party interstitials could block the display of subsequent HTML interstitials
  - Fixed an issue in which third-party interstitials could trigger lifecycle callbacks after expiration
  - Added iOS 6 view controller auto-rotation methods to `MPInterstitialAdController`
  - Added support for iOS 6 advertising identifier
  - Removed references to `-[UIDevice uniqueIdentifier]` and OpenUDID
  - Added runtime checks for `CALayer` and `UIActionSheet` selectors to prevent crashes on iOS 3.1
  - Improved the Millennial interstitial adapter to handle all return values from `-checkForCachedAd`

## Version 1.7.0.0
  - Improved click experience to avoid blank screens when loading pages with many redirects
  - Fixed an issue in which `MPAdView` would implicitly change its 'hidden' property
  - Fixed an issue in which the in-app browser failed to dismiss properly upon `-[UIApplication openURL:]`
  - Fixed issues in which the `MRAID.isViewable` method would erroneously return true
  - Fixed a divide-by-zero exception which occurred when presenting MRAID interstitials

## Version 1.6.0.0
  - Added new API method for displaying an interstitial (`-showFromViewController:`)
  - Added new delegate property on `MPInterstitialAdController`
  - Deprecated old API method for displaying an interstitial (`-show:`)
  - Deprecated parent property on `MPInterstitialAdController`
  - Deprecated various callbacks in `MPInterstitialAdControllerDelegate`

## Version 1.5.0.0
  - Added support for Millennial Media SDK 4.5.5
  - Modified Millennial Media interstitial adapter to be more robust to ad display failures

## Version 1.4.0.0
  - Reduced the amount of logging messages regarding autorefresh
  - Modified JSON deserializer to avoid getting NSNull objects
  - Fixed issue in which interstitials could appear blank upon repeated show: calls
  - Removed call to deprecated `SKMutablePayment` class method
  - Added APIs for enabling and disabling the in-app purchase transaction observer
  - Fixed a memory leak in `MPInterstitialAdController`
  - Added support for OpenUDID as a optional replacement for `UIDevice's -uniqueIdentifier`

## Version 1.2.0.0
  - Fixed a bug in which landscape interstitials appeared off-center on iOS 5.0+
  - Fixed some static analyzer warnings in `MPAdManager` and `MPAdBrowserController`
  - Fixed a memory leak in `MPAdConversionTracker`
  - Changed '\*\*\*CLEAR\*\*\*' message to 'No ad available' for clarity
  - Added support for Millennial Media leaderboard ads
  - Changed behavior of `-setIgnoresAutorefresh:` to pause (rather than cancel) existing timers
  - Added support for interstitial custom events
