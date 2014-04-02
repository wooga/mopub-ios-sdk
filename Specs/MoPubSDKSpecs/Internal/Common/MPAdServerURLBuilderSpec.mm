#import "MPAdServerURLBuilder.h"
#import "MPConstants.h"
#import "MPIdentityProvider.h"
#import "MPGlobal.h"
#import "TWTweetComposeViewController+MPSpecs.h"
#import <CoreLocation/CoreLocation.h>

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

static BOOL advertisingTrackingEnabled = YES;

@implementation MPAdServerURLBuilder (Spec)

+ (BOOL)advertisingTrackingEnabled
{
    return advertisingTrackingEnabled;
}

@end


SPEC_BEGIN(MPAdServerURLBuilderSpec)

describe(@"MPAdServerURLBuilder", ^{
    __block NSURL *URL;
    __block NSString *expected;

    describe(@"base case", ^{
        it(@"should have the right things", ^{
            URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                               keywords:nil
                                               location:nil
                                                testing:YES];
            expected = [NSString stringWithFormat:@"http://testing.ads.mopub.com/m/ad?v=8&udid=%@&id=guy&nv=%@",
                        [MPIdentityProvider identifier],
                        MP_SDK_VERSION];
            URL.absoluteString should contain(expected);

            URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                               keywords:nil
                                               location:nil
                                                testing:NO];
            expected = [NSString stringWithFormat:@"http://ads.mopub.com/m/ad?v=8&udid=%@&id=guy&nv=%@",
                        [MPIdentityProvider identifier],
                        MP_SDK_VERSION];
            URL.absoluteString should contain(expected);
        });
    });

    it(@"should process keywords", ^{
        [UIPasteboard removePasteboardWithName:@"fb_app_attribution"];
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:@"  something with whitespace,another  "
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&q=something%20with%20whitespace,another");

        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should_not contain(@"&q=");

        UIPasteboard *pb = [UIPasteboard pasteboardWithName:@"fb_app_attribution" create:YES];
        pb.string = @"from zuckerberg with love";
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:@"a=1"
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&q=a=1,FBATTRID:from%20zuckerberg%20with%20love");
        [UIPasteboard removePasteboardWithName:@"fb_app_attribution"];
    });

    it(@"should process orientation", ^{
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&o=p");

        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&o=l");
    });

    it(@"should process scale factor", ^{
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];

        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"&sc=\\d\\.0"
                                                                               options:0
                                                                                 error:NULL];
        [regex numberOfMatchesInString:URL.absoluteString options:0 range:NSMakeRange(0, URL.absoluteString.length)] should equal(1);
    });

    it(@"should process time zone", ^{
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];

        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"&z=[-+]\\d{4}"
                                                                               options:0
                                                                                 error:NULL];
        [regex numberOfMatchesInString:URL.absoluteString options:0 range:NSMakeRange(0, URL.absoluteString.length)] should equal(1);
    });

    it(@"should process location", ^{
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should_not contain(@"&ll=");

        CLLocation *validLocationNoAccuracy = [[[CLLocation alloc] initWithLatitude:10.1 longitude:-40.23] autorelease];
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:validLocationNoAccuracy
                                            testing:YES];
        URL.absoluteString should contain(@"&ll=10.1,-40.23");
        URL.absoluteString should_not contain(@"&lla=");

        CLLocation *validLocationWithAccuracy = [[[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(10.1, -40.23)
                                                                               altitude:30.4
                                                                     horizontalAccuracy:500.1
                                                                       verticalAccuracy:60
                                                                              timestamp:[NSDate date]] autorelease];
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:validLocationWithAccuracy
                                            testing:YES];
        URL.absoluteString should contain(@"&ll=10.1,-40.23");
        URL.absoluteString should contain(@"&lla=500.1");

        CLLocation *invalidLocation = [[[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(10.1, -40.23)
                                                                     altitude:30.4
                                                           horizontalAccuracy:-1
                                                             verticalAccuracy:60
                                                                    timestamp:[NSDate date]] autorelease];
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:invalidLocation
                                            testing:YES];
        URL.absoluteString should_not contain(@"&ll=");
        URL.absoluteString should_not contain(@"&lla=");
    });

    it(@"should have mraid", ^{
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&mr=1");
    });

    it(@"should turn advertisingTrackingEnabled into DNT", ^{
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should_not contain(@"&dnt=");

        advertisingTrackingEnabled = NO;
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&dnt=1");

        advertisingTrackingEnabled = YES;
    });

    it(@"should provide connectivity information", ^{
        fakeProvider.fakeMPReachability = [[[FakeMPReachability alloc] init] autorelease];
        FakeMPReachability *fakeMPReachability = fakeProvider.fakeMPReachability;
        fakeMPReachability.hasWifi = YES;

        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&ct=2");

        fakeMPReachability.hasWifi = NO;

        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&ct=3");
    });

    it(@"should provide application version", ^{
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&av=1.0");
    });

    it(@"should provide carrier info", ^{
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should_not contain(@"&cn=");
        URL.absoluteString should_not contain(@"&iso=");
        URL.absoluteString should_not contain(@"&mnc=");
        URL.absoluteString should_not contain(@"&mcc=");

        NSDictionary *fakeCarrierInfo = @{
            @"carrierName" : @"AT&T",
            @"isoCountryCode" : @"us",
            @"mobileNetworkCode" : @"310",
            @"mobileCountryCode" : @"410"
        };
        fakeProvider.fakeCarrierInfo = fakeCarrierInfo;

        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain(@"&cn=AT%26T");
        URL.absoluteString should contain(@"&iso=us");
        URL.absoluteString should contain(@"&mnc=310");
        URL.absoluteString should contain(@"&mcc=410");
    });

    it(@"should provide the device name identifier", ^{
        URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                           keywords:nil
                                           location:nil
                                            testing:YES];
        URL.absoluteString should contain([NSString stringWithFormat:@"&dn=%@", [[[UIDevice currentDevice] hardwareDeviceName] URLEncodedString]]);
    });

    describe(@"Twitter Availability", ^{
        beforeEach(^{
            [fakeProvider resetTwitterAppInstallCheck];
            [[UIApplication sharedApplication] setTwitterInstalled:NO];
            [TWTweetComposeViewController setNativeTwitterAvailable:NO];
        });

        it(@"should not pass a query if no twitter is available", ^{
            URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                               keywords:nil
                                               location:nil
                                                testing:YES];
            URL.absoluteString should_not contain([NSString stringWithFormat:@"&ts="]);
        });

        it(@"should create query for only having twitter app installed", ^{
            [[UIApplication sharedApplication] setTwitterInstalled:YES];
            URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                               keywords:nil
                                               location:nil
                                                testing:YES];
            URL.absoluteString should contain([NSString stringWithFormat:@"&ts=1"]);
        });

        it(@"should create query for only having native twitter account(s)", ^{
            [TWTweetComposeViewController setNativeTwitterAvailable:YES];
            URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                               keywords:nil
                                               location:nil
                                                testing:YES];
            URL.absoluteString should contain([NSString stringWithFormat:@"&ts=2"]);

        });

        it(@"should create query for having both twitter app and native account(s)", ^{
            [[UIApplication sharedApplication] setTwitterInstalled:YES];
            [TWTweetComposeViewController setNativeTwitterAvailable:YES];
            URL = [MPAdServerURLBuilder URLWithAdUnitID:@"guy"
                                               keywords:nil
                                               location:nil
                                                testing:YES];
            URL.absoluteString should contain([NSString stringWithFormat:@"&ts=3"]);
        });
    });
});

SPEC_END
