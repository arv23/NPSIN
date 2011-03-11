#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIWebView.h>

@interface WebViewController : UIViewController {
	IBOutlet UIButton *webButton;
	IBOutlet UIBarButtonItem *item;
	IBOutlet UIView *infoView;
	IBOutlet UIWebView *webView;
	IBOutlet UIView *websiteView;
	
}

@property (nonatomic, retain) IBOutlet UIButton *webButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *item;
@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIView *websiteView;


- (IBAction) pushWebButton;

- (IBAction) pushBackButton;

+ (UINavigationBar*)myNavBar1: (NSString*)input;
+ (UIColor*)myColor1;

@end
