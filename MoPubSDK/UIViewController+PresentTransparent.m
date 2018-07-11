#import "UIViewController+PresentTransparent.h"

@implementation UIViewController (PresentTransparent)

- (void) presentTransparentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if([self systemVersionLessThan:@"8.0"]) {
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
    }else{
        [viewControllerToPresent setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (BOOL) systemVersionLessThan:(NSString *) version
{
    return [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending;
}

@end
