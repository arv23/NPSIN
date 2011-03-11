#import "WebViewController.h"

@implementation WebViewController
@synthesize webButton;
@synthesize item;
@synthesize infoView;
@synthesize webView;
@synthesize websiteView;


- (IBAction) pushWebButton {
	
	
	[webView setBackgroundColor:[UIColor whiteColor]];
	NSString *urlAddress = @"http://www.independencenavigator.com/Mobile_Site/";
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	webView.scalesPageToFit = YES;
	[webView loadRequest:requestObj];
	
	CGRect frame3 = websiteView.frame;
	frame3.origin.y = -480;
	websiteView.frame = frame3;
	
	//[createNotificationView removeFromSuperview];
	[self.view addSubview:websiteView];
	
	CGRect frame4 = websiteView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 0;
	websiteView.frame = frame4;
	[UIView commitAnimations];

}

- (IBAction) pushBackButton {
	
	CGRect frame3 = websiteView.frame;
	frame3.origin.y = 0;
	websiteView.frame = frame3;
	
	//[createNotificationView removeFromSuperview];
	[self.view addSubview:websiteView];
	
	CGRect frame4 = websiteView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = -480;
	websiteView.frame = frame4;
	[UIView commitAnimations];
	
	//And then later when I want to have the back button again I restore it: 
	//self.navigationItem.hidesBackButton = YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{	
	[super viewDidLoad];

	
}

@end
