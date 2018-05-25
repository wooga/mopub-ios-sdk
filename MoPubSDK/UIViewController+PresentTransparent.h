#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIViewController (PresentTransparent)

- (void) presentTransparentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;

@end
