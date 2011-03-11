//
//  SiteOneController.m
//  InstantNavigator
//
//  Created by dni on 2/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SiteOneController.h"
#import <AVFoundation/AVAudioPlayer.h>
//#import <QuartzCore/QuartzCore.h>

@implementation SiteOneController
@synthesize moviePlayer;
@synthesize webView;
@synthesize view1;
@synthesize button1;

// Button Dimensions
int a = 61;
int b = 15;
int c = 200;
int d = 30;

NSMutableArray *ccLoc;
NSMutableArray *fcLoc;
NSMutableArray *phLoc;
NSMutableArray *sites;
NSMutableArray *content;
NSMutableArray *files;
NSMutableArray *listSites;

NSString *siteName;
NSString *fName;

NSString *kScalingModeKey	= @"scalingMode";
NSString *kControlModeKey	= @"controlMode";
NSString *kBackgroundColorKey	= @"backgroundColor";



// NPSIN Green Color
+ (UIColor*)myColor1 {  
	return [UIColor colorWithRed:0.0f/255.0f green:76.0f/255.0f blue:29.0f/255.0f alpha:1.0f];
}

+ (UIColor*)myColor2 {  
	return [UIColor colorWithRed:175.0f/255.0f green:177.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
}

// Creates Nav Bar with default Green at top of screen with given String as title
+ (UINavigationBar*)myNavBar1: (NSString*)input {
	
	UIView *test = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, test.bounds.size.width, 45)];
	navBar.tintColor = [SiteOneController myColor1];
	
	UINavigationItem *navItem;
	navItem = [UINavigationItem alloc];
	navItem.title = input;
	[navBar pushNavigationItem:navItem animated:false];
	
	return navBar;
	
}


//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//


/*- (void)destroyStreamer -- Pretty sure all of this can be deleted. Took out what I needed to use and placed it in content check methods.
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self object:streamer];
		//[progressUpdateTimer invalidate];
		//progressUpdateTimer = nil;
		
		[streamer stop];
		[streamer release];
		streamer = nil;
	}
}

- (void)createStreamer
{
	NSLog(@"create streamer method");
	if (streamer)
	{
		return;
	}
	
	//[self destroyStreamer];
	NSLog(fName);
	NSURL *url = [NSURL URLWithString:fName];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	NSLog(fName);
	
} */ 



 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
	 
	 NSString *urlAddress = @"http://farpoint.cs.drexel.edu/testphp.php";
	 
	 //Create a URL object.
	 NSURL *url = [NSURL URLWithString:urlAddress];
	 
	 //URL Requst Object
	 NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	 
	 //Load the request in the UIWebView.
	 [webView2 loadRequest:requestObj];
	 
	 NSString *myText = [webView2 stringByEvaluatingJavaScriptFromString:@"document.documentElement.textContent"];
	 
	 NSString *string1 = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://farpoint.cs.drexel.edu/testphp.php"]];
	 
	 sites = [[NSMutableArray alloc] init];
	 content = [[NSMutableArray alloc] init];
	 files = [[NSMutableArray alloc] init];
	 listSites = [[NSMutableArray alloc] init];
	 
	 
	 int start = 0;
	 int startContent = 0;
	 int startFile = 0;
	 
	 for(int i=0;i<string1.length;i++)
	 {
		 if('^' == [string1 characterAtIndex:i])
		 {
			 NSRange siteStringRange;
			 siteStringRange.location = start;
			 siteStringRange.length = i-start-1;
			 NSString *siteString = [string1 substringWithRange:siteStringRange];
			 NSRange siteNameRange;
			 siteNameRange.location = 6;
			 siteNameRange.length = siteString.length - 6;
			 NSString *siteNameString = [siteString substringWithRange:siteNameRange];
			 startContent = i + 1;
			 [sites addObject: siteNameString];
			 if ([listSites count] == 0)
			 {
				 [listSites addObject:siteNameString];
			 }
			 
			 for (int j=0;j < [listSites count]; j++)
			 {
				 if ([[listSites objectAtIndex:j] isEqualToString:siteNameString])
				 {
					 break;
				 }
				 
				 if (j+1 == [listSites count])
				 {
					 [listSites addObject:siteNameString];
				 }
			 }
									
		 }
		 
		 if ('$' == [string1 characterAtIndex:i])
		 {
			 NSRange contentStringRange;
			 contentStringRange.location = startContent;
			 contentStringRange.length = i - startContent - 1;
			 NSString *contentString = [string1 substringWithRange:contentStringRange];
			 NSRange contentNameRange;
			 contentNameRange.location = 9;
			 contentNameRange.length = contentString.length - 9;
			 NSString *contentNameString = [contentString substringWithRange:contentNameRange];

			 startFile = i + 1;
			 [content addObject:contentNameString];
		 }
		 
		 if ('<' == [string1 characterAtIndex:i])
		 {
			 NSRange fileStringRange;
			 fileStringRange.location = startFile;
			 fileStringRange.length = i - startFile;
			 NSString *fileString = [string1 substringWithRange:fileStringRange];
			 NSRange fileNameRange;
			 fileNameRange.location = 6;
			 fileNameRange.length = fileString.length - 6;
			 NSString *fileNameString = [fileString substringWithRange:fileNameRange];
			 [files addObject:fileNameString];
			 //startFile = i + 1
		 }
		 
		 if('>' == [string1 characterAtIndex:i])
		 {
			 start = i + 1;
		 }
		 
	 }

	 
	 //allocate the view
	 UIScrollView *scrollView; //[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	 scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 45.0, 320.0, 460.0)];
	 scrollView.contentSize = CGSizeMake(320,720);
	 
	 //self.view = scrollView;
	 self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	 
	 //set the view's background color
	// self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"MainBG.jpg"]];
	 self.view.backgroundColor = [SiteOneController myColor2];
	 

	 
	 [self.view addSubview:[SiteOneController myNavBar1:@"Sites"]];

	 
	 NSString *element;
	 int j = 0;
	 for (element in listSites)
	 {
		 UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		 UIFont *myBoldFont = [UIFont boldSystemFontOfSize:20.0];
		 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, b + (j*45), c, d)];
		 [label setBackgroundColor:[UIColor clearColor]];
		 
		 label.text = element;
		 label.font = myBoldFont;
		 
		 UIImage *img = [UIImage imageNamed:@"ButtonBase.png"];
		 [button setImage:img forState:UIControlStateNormal];
		 
		 //setframe (where on screen)
		 //separation is 15px past the width (45-30)
		 button.frame = CGRectMake(a, b + (j*45), c, d);
		 
		 // [button setTitle:element forState:UIControlStateNormal];
		 
		 button.backgroundColor = [SiteOneController myColor1];
		 
		[button addTarget:self action:@selector(showCCView:)
		forControlEvents:UIControlEventTouchUpInside];
		 [button setTag:j];
		 
		 [scrollView addSubview: button];
		 [scrollView addSubview:label];
		 j++;
		 
	 }
	 [self.view addSubview:scrollView];
	 
 }

- (void) backToSites:(id) sender { //back button
	UIScrollView *scrollView; //[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 45.0, 320.0, 460.0)];
	scrollView.contentSize = CGSizeMake(320,720);
	
	//self.view = scrollView;
	self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.view.backgroundColor = [SiteOneController myColor2];
	//[self.view setBackgroundColor:myColor2];
	
	[self.view addSubview:[SiteOneController myNavBar1:@"Sites"]];

	
	NSString *element;
	int j = 0;
	for (element in listSites)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		UIFont *myBoldFont = [UIFont boldSystemFontOfSize:20.0];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, b + (j*45), 220, d)];
		[label setBackgroundColor:[UIColor clearColor]];
		
		label.text = element;
		label.font = myBoldFont;
		
		//setframe (where on screen)
		//separation is 15px past the width (45-30)
		button.frame = CGRectMake(a, b + (j*45), c, d);
		
		UIImage *img = [UIImage imageNamed:@"ButtonBase.png"];
		[button setImage:img forState:UIControlStateNormal];
		
		//[button setTitle:element forState:UIControlStateNormal];
		
		button.backgroundColor = [SiteOneController myColor1];
		
		[button addTarget:self action:@selector(showCCView:)
		 forControlEvents:UIControlEventTouchUpInside];
		[button setTag:j];
		
		[scrollView addSubview: button];
		[scrollView addSubview: label];
		j++;
	}
	
	CGRect frame3 = scrollView.frame;
	frame3.origin.x = -320;
	scrollView.frame = frame3;
	
	[self.view addSubview:scrollView];
	
	CGRect frame4 = scrollView.frame;
	[UIScrollView beginAnimations:nil context:NULL];
	[UIScrollView setAnimationDuration:0.2];
	
	frame4.origin.x = 0;
	scrollView.frame = frame4;
	[UIScrollView commitAnimations];

}

// This method show the content views for each of the sites.

- (void) showCCView:(id) sender { //content
	
	[streamer stop];
	
	
	UIButton *button = (UIButton *)sender;
    int whichButton = button.tag;
	NSString* myNewString = [NSString stringWithFormat:@"%d", whichButton];
	UIScrollView *scrollView; //[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 45.0, 320.0, 460.0)];
	scrollView.contentSize = CGSizeMake(320,420);
	
	//self.view = scrollView;
	self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	//self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"MainBG.jpg"]];
	self.view.backgroundColor = [SiteOneController myColor2];
	
	UINavigationBar *navTitle = [SiteOneController myNavBar1:[listSites objectAtIndex:whichButton]];
	
	siteName = @"cc";
	NSMutableArray *allccContent = [[NSMutableArray alloc] init];
		
	ccLoc = [[NSMutableArray alloc] init];
		
		
	for (int i=0; i < [sites count]; i++)
	{
		if ([[listSites objectAtIndex:whichButton] isEqualToString:[sites objectAtIndex:i]])
		{
			[allccContent addObject:[content objectAtIndex:i]];
			[ccLoc addObject:[files objectAtIndex:i]];
		}
	
	}
	[self.view addSubview:navTitle];
		
	NSString *element;
	int j = 0;
	int tag = 10;
	
	for (element in allccContent)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		UIFont *myBoldFont = [UIFont boldSystemFontOfSize:20.0];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, b + (j*45), 220, d)];
		[label setBackgroundColor:[UIColor clearColor]];
		
		label.text = element;
		label.font = myBoldFont;
		
		UIImage *img = [UIImage imageNamed:@"ButtonBase.png"];
		[button setImage:img forState:UIControlStateNormal];
		
		//setframe (where on screen)
		//separation is 15px past the width (45-30)
		button.frame = CGRectMake(a, b + (j*45), c, d);
		
		//[button setTitle:element forState:UIControlStateNormal];
		
		button.backgroundColor = [SiteOneController myColor1];
		//NSString *fName = [contentLoc objectAtIndex:j];
		//NSLog(fName);
		[button addTarget:self action:@selector(checkContent:)
			forControlEvents:UIControlEventTouchUpInside];
		[button setTag:tag];
		
		[scrollView addSubview: button];
		[scrollView addSubview: label];
		j++;
		tag++;
	}
	
	CGRect frame = scrollView.frame;
	frame.origin.x = 320;
	scrollView.frame = frame;
	
	[self.view addSubview:scrollView];
	
	UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	//setframe (where on screen)
	//separation is 15px past the width (45-30)
	button2.frame = CGRectMake(6, 60-52, 50, d-2);
	
	UIImage *img = [UIImage imageNamed:@"backSample.png"];
	[button2 setImage:img forState:UIControlStateNormal];
	
	//button.backgroundColor = [SiteOneController myColor1];
	
	[button2 addTarget:self action:@selector(backToSites:)
		forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: button2];
	
	CGRect frame2 = scrollView.frame;
	[UIScrollView beginAnimations:nil context:NULL];
	[UIScrollView setAnimationDuration:0.2];
	
	frame2.origin.x = 0;
	scrollView.frame = frame2;
	[UIScrollView commitAnimations];
}


-(IBAction)openEmailSend:(id)sender
{
	
	UIWebView *webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 367.0)];
	
	[webView1 setBackgroundColor:[UIColor whiteColor]];
	NSString *urlAddress = @"http://ale-jan-dro.com/files/mailform.php";
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	webView1.scalesPageToFit = NO;
	[webView1 loadRequest:requestObj];
	
	//[self.view addSubview:[[UIImageView alloc] initWithImage:image]];
	[self.view addSubview:[SiteOneController myNavBar1:@"E-Mail Content"]];
	[self.view addSubview:webView1];
	//[self.view addSubview:button];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	
	//setframe (where on screen)
	//separation is 15px past the width (45-30)
	button.frame = CGRectMake(6, 60-52, 50, d);
	
	UIImage *img = [UIImage imageNamed:@"backSample.png"];
	[button setImage:img forState:UIControlStateNormal];
	
	//button.backgroundColor = [SiteOneController myColor1];
	
	[button addTarget:self action:@selector(backToSites:)
	 forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview: button];
}

 

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	
}

-(int)getIndexOf:(char)c:(NSString*)string {
	
	for(int i=0;i<string.length;i++)
		if(c == [string characterAtIndex:i])
			return i;
	
	return -1;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)checkContent:(id) sender{
	//NSLog(sender);
	NSString *name1 , *name2, *name3, *fName;
	name1 = @"cc";
	name2 = @"fc";
	name3 = @"ph";
	
	int tag;
	
	UIButton *button = (UIButton *)sender;
	int whichButton = button.tag;
	if(siteName == name1)
	{
		tag = 0;
		fName = [ccLoc objectAtIndex:whichButton-10];
	}
	if(siteName == name2)
	{
		tag = 1;
		fName = [fcLoc objectAtIndex:whichButton-20];
	}
	if(siteName == name3)
	{
		tag = 2;
		fName = [phLoc objectAtIndex:whichButton-30];
	}
	NSLog(fName);
	if ( [fName hasSuffix:@".jpg"])
	{
		NSLog(@"PICTURE");
		NSURL *url = [NSURL URLWithString: 
					  fName];
		
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
		
		//self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		
		UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		scrollView.contentSize = CGSizeMake(320,760);
		
		UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
		backButton.frame = CGRectMake(6
									  , 60-52, 50, d);
		
		UIImage *img = [UIImage imageNamed:@"backSample.png"];
		[backButton setImage:img forState:UIControlStateNormal];
		[backButton addTarget:self action:@selector(backToSites:) forControlEvents:UIControlEventTouchUpInside];
		[backButton setTag:tag];
		
		
		
		
		
		UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];

		
		UIImage *img1 = [UIImage imageNamed:@"download_button2-1.png"];
		[downloadButton setImage:img1 forState:UIControlStateNormal];
		[downloadButton addTarget:self action:@selector(openEmailSend:) forControlEvents:UIControlEventTouchUpInside];
		[downloadButton setTag:tag];

		downloadButton.frame = CGRectMake(a+125, 345, c, d);
		
		self.view = scrollView;
		// self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"MainBG.jpg"]];
		
		[self.view addSubview:[[UIImageView alloc] initWithImage:image]];
		[self.view addSubview:[SiteOneController myNavBar1:@"Photos"]];
		[self.view addSubview:downloadButton];
		[self.view addSubview:backButton];
		
	}
	if ( [fName hasSuffix:@".mp4"])
	{
		NSLog(@"VIDEO");
		NSURL *url = [NSURL URLWithString:fName];
		NSLog(@"fName=");
		NSLog(fName);
		//NSLog(url);
		//NSString *rootPath = [[NSBundle mainBundle] resourcePath];
		//NSString *filePath = [rootPath stringByAppendingPathComponent:@"pres_topic1_vid001.mp4"];
		//NSURL *fileURL = [NSURL fileURLWithPath:filePath isDirectory:NO];

		/*
		MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:url];
		player.scalingMode=MPMovieScalingModeAspectFill;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:player];
		[url retain];
		[player play];
		*/
		MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:url];
		if (mp)
		{
			// save the movie player object
			self.moviePlayer = mp;
			[mp release];
			
			// Apply the user specified settings to the movie player object
			//[self setMoviePlayerUserSettings];
			
			// Play the movie!
			
			[self.moviePlayer play];
			NSLog(@"PLAY");
		}
		
		
		
	}
	if ( [fName hasSuffix:@".mp3"])
	{
		NSLog(@"AUDIO");
		NSURL *url = [NSURL URLWithString:fName];
		//url2 = [NSURL URLWithString:fName];
		//NSString *rootPath = [[NSBundle mainBundle] resourcePath];
		//NSString *filePath = [rootPath stringByAppendingPathComponent:@"test.mp3"];
		//NSURL *fileURL = [NSURL fileURLWithPath:filePath isDirectory:NO];
		//NSData *soundData = [NSData dataWithContentsOfURL:url];
		//AVAudioPlayer *avPlayer = [[AVAudioPlayer alloc] initWithData:soundData error: nil];
		//[avPlayer play];
		
//		[self createStreamer];
		if (streamer)
		{
			return;
		}
		streamer = [[AudioStreamer alloc] initWithURL:url];
		[streamer start];
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		
		//BACK BUTTON IMAGE
		
		//setframe (where on screen)
		//separation is 15px past the width (45-30)
		button.frame = CGRectMake(a+135, b-52, c, d);
		
		UIImage *img = [UIImage imageNamed:@"stop_button.png"];
		[button setImage:img forState:UIControlStateNormal];
		[button addTarget:self action:@selector(showCCView:) forControlEvents:UIControlEventTouchUpInside];
		[button setTag:tag];
		
		[self.view addSubview: button];
	
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
