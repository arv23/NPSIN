#import "SecondView.h"

@implementation SecondView
- (IBAction)BackToMain {
    [self.parentViewController dismissModalViewControllerAnimated:NO];
}
@end
