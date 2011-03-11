//
//  HomeViewController.m
//  InstantNavigatore
//
//  Created by dni on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"



@implementation HomeViewController
@synthesize enterButton;
@synthesize cNotificationButton;
@synthesize navBar; 
@synthesize postNotificationButton;
@synthesize webView;
@synthesize webView2;
@synthesize createNotificationView;
@synthesize view2;
@synthesize scrollView;
@synthesize displayNotificationView;
@synthesize editNotificationView;
@synthesize siteLabel;
@synthesize typeLabel;
@synthesize messageBox;
@synthesize	editButton;
@synthesize deleteButton;
BOOL enterViewed = NO;

NSMutableArray *notificationsType;
NSMutableArray *notificationsSites;
NSMutableArray *notificationsMessage;
NSString *notifType;
//int d = 30;
int j=0;
int selectedIndex = 0;


- (IBAction) pushEnter {
	[self.view addSubview:view2];
	self.tabBarController.selectedIndex = 1;
	
}

+ (UIColor*)myColor1 {  
	return [UIColor colorWithRed:175.0f/255.0f green:177.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
}


+ (void) loadNotifications
{
		notificationsSites = [[NSMutableArray alloc] init];
		notificationsType = [[NSMutableArray alloc] init];
		notificationsMessage = [[NSMutableArray alloc] init];
	
		// for now setup some dummy ones
		NSString *notification=@"";
	
	
	
		notification=@"Hazard";
		[notificationsType insertObject:notification atIndex:0];
		notification=@"Presidents House";
		[notificationsSites insertObject:notification atIndex:0];
		notification=@"Spill";
		[notificationsMessage insertObject:notification atIndex:0];
	
		[notification release];
	
		
}

-(void) displayNotifications:(id)sender
{
	
	UIButton* button1 = sender;
	int selectedIndex = button1.tag;
	
	[deleteButton setTag:selectedIndex];
	[editButton setTag:selectedIndex];
	
	siteLabel.text = [notificationsSites objectAtIndex:selectedIndex];
	typeLabel.text = [notificationsType objectAtIndex:selectedIndex];
	messageBox.text = [notificationsMessage objectAtIndex:selectedIndex];
	
	
	notifType = @"dn";
	CGRect frame3 = displayNotificationView.frame;
	frame3.origin.y = -480;
	displayNotificationView.frame = frame3;
	
	[self.view addSubview:displayNotificationView];
	
	CGRect frame4 = displayNotificationView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 0;
	displayNotificationView.frame = frame4;
	[UIView commitAnimations];
	

}

-(void) deleteNotification:(id) sender
{
	notifType = @"dn";
	UIButton* button1 = sender;
	int selectedIndex = button1.tag;
	
	[notificationsSites removeObjectAtIndex:selectedIndex];
	[notificationsType removeObjectAtIndex:selectedIndex];
	[notificationsMessage removeObjectAtIndex:selectedIndex];
	
	[scrollView removeFromSuperview];
	
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,44,320,416)];
	
	scrollView.backgroundColor = [HomeViewController myColor1];
	
	
	[self.view addSubview:scrollView];
	
	int count = [notificationsSites count];
	
	j = 0;
	
	for (int i = 0; i < count; i++)
	{
		
		// Creates buttons for each notification
		UIButton *notifButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		notifButton.frame = CGRectMake(60, 20 + (j*55), 200, 70);
		
		UIImage *img = [UIImage imageNamed:@"blankbutton.png"];
		[notifButton setImage:img forState:UIControlStateNormal];
		
		[notifButton setTag:i];
		
		[notifButton addTarget:self action:@selector(displayNotifications:)
			  forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview: notifButton];
		
		
		// Create button for updating notifications
		UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		updateButton.frame = CGRectMake(215, 45 + (j*55), 60, 20);
		
		UIImage *img2 = [UIImage imageNamed:@"UpdateButtonSmall.png"];
		[updateButton setImage:img2 forState:UIControlStateNormal];
		
		[updateButton setTag:i];
		
		[updateButton addTarget:self action:@selector(openEditNotification:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:updateButton];
		
		/*
		// Creates button to delete notifications
		UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		deleteButton.frame = CGRectMake(230, 60 + (j*55), 60, 20);
		
		UIImage *img3 = [UIImage imageNamed:@"DeleteButton.png"];
		[deleteButton setImage:img3 forState:UIControlStateNormal];
		
		[deleteButton setTag:i];
		
		[deleteButton addTarget:self action:@selector(deleteNotification:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:deleteButton];*/
		
		
		// Displays each notification
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *sitesFont = [UIFont boldSystemFontOfSize:17.0];
		label.text=[notificationsSites objectAtIndex:i];
		label.font = sitesFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 42+(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *typeFont = [UIFont italicSystemFontOfSize:16.0];
		label.text=[notificationsType objectAtIndex:i];
		label.font = typeFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 64 +(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *messageFont = [UIFont systemFontOfSize:16];
		label.text=[notificationsMessage objectAtIndex:i];
		label.font = messageFont;
		[self.scrollView addSubview:label];
		
		j = j+2;
		
		[label release];
		[messageFont release];
		[sitesFont release];
		[typeFont release];
		
	}
	
	scrollView.contentSize = CGSizeMake(320, 51 + (j*55));
	
	CGRect frame3 = displayNotificationView.frame;
	frame3.origin.y = 0;
	displayNotificationView.frame = frame3;
	
	//[createNotificationView removeFromSuperview];
	[self.view addSubview:displayNotificationView];
	
	CGRect frame4 = displayNotificationView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = -480;
	displayNotificationView.frame = frame4;
	[UIView commitAnimations];
	
}



- (IBAction) updateNotification;
{
	
	NSString *message = [webView2 stringByEvaluatingJavaScriptFromString: @"document.formNotification.messageArea.value"];
	NSString *site = [webView2 stringByEvaluatingJavaScriptFromString: @"document.formNotification.siteSelector.value"];
	NSString *type = [webView2 stringByEvaluatingJavaScriptFromString: @"document.formNotification.typeNotification.value"];
	NSString *notification=@"";
	
	notification=type;
	[notificationsType replaceObjectAtIndex:selectedIndex withObject:notification];
	notification=site;
	[notificationsSites replaceObjectAtIndex:selectedIndex withObject:notification];
	notification=message;
	[notificationsMessage replaceObjectAtIndex:selectedIndex withObject:notification];
	
	[notification release];
	
	j = 0;
	
	int count = [notificationsSites count];
	
	for (int i = 0; i < count; i++)
	{
		
		// Creates buttons for each notification
		UIButton *notifButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		notifButton.frame = CGRectMake(60, 20 + (j*55), 200, 70);
		
		UIImage *img = [UIImage imageNamed:@"blankbutton.png"];
		[notifButton setImage:img forState:UIControlStateNormal];
		
		[notifButton setTag:i];
		
		[notifButton addTarget:self action:@selector(displayNotifications:)
			  forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview: notifButton];
		
		
		// Create button for updating notifications
		UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		updateButton.frame = CGRectMake(215, 45 + (j*55), 60, 20);
		
		UIImage *img2 = [UIImage imageNamed:@"UpdateButtonSmall.png"];
		[updateButton setImage:img2 forState:UIControlStateNormal];
		
		[updateButton setTag:i];
		
		[updateButton addTarget:self action:@selector(openEditNotification:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:updateButton];
		
		/*
		// Creates button to delete notifications
		UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		deleteButton.frame = CGRectMake(230, 60 + (j*55), 60, 20);
		
		UIImage *img3 = [UIImage imageNamed:@"DeleteButton.png"];
		[deleteButton setImage:img3 forState:UIControlStateNormal];
		
		[deleteButton setTag:i];
		
		[deleteButton addTarget:self action:@selector(deleteNotification:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:deleteButton];*/
		
		
		// Displays each notification
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *sitesFont = [UIFont boldSystemFontOfSize:17.0];
		label.text=[notificationsSites objectAtIndex:i];
		label.font = sitesFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 42+(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *typeFont = [UIFont italicSystemFontOfSize:16.0];
		label.text=[notificationsType objectAtIndex:i];
		label.font = typeFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 64 +(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *messageFont = [UIFont systemFontOfSize:16];
		label.text=[notificationsMessage objectAtIndex:i];
		label.font = messageFont;
		[self.scrollView addSubview:label];
		
		j = j+2;
		
		[label release];
		[messageFont release];
		[sitesFont release];
		[typeFont release];
		
	}
	
	[editNotificationView removeFromSuperview];
	[displayNotificationView removeFromSuperview];
	CGRect frame3 = editNotificationView.frame;
	frame3.origin.y = 0;
	editNotificationView.frame = frame3;
	
	//[createNotificationView removeFromSuperview];
	[self.view addSubview:editNotificationView];
	
	CGRect frame4 = editNotificationView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 480;
	editNotificationView.frame = frame4;
	[UIView commitAnimations];
	
	
}



- (IBAction) submitNotification
{
	
	NSString *message = [webView stringByEvaluatingJavaScriptFromString: @"document.formNotification.messageArea.value"];
	NSString *site = [webView stringByEvaluatingJavaScriptFromString: @"document.formNotification.siteSelector.value"];
	NSString *type = [webView stringByEvaluatingJavaScriptFromString: @"document.formNotification.typeNotification.value"];
	NSString *notification=@"";
	
	
	notification=type;
	[notificationsType insertObject:notification atIndex:0];
	notification=site;
	[notificationsSites insertObject:notification atIndex:0];
	notification=message;
	[notificationsMessage insertObject:notification atIndex:0];
	
	[notification release];
	
	j = 0;
	
	int count = [notificationsSites count];
	
	
	for (int i = 0; i < count; i++)
	{
		
		// Creates buttons for each notification
		UIButton *notifButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		notifButton.frame = CGRectMake(60, 20 + (j*55), 200, 70);
		
		UIImage *img = [UIImage imageNamed:@"blankbutton.png"];
		[notifButton setImage:img forState:UIControlStateNormal];
		
		[notifButton setTag:i];
		
		[notifButton addTarget:self action:@selector(displayNotifications:)
			  forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview: notifButton];
		
		
		// Create button for updating notifications
		UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		updateButton.frame = CGRectMake(215, 45 + (j*55), 60, 20);
		
		UIImage *img2 = [UIImage imageNamed:@"UpdateButtonSmall.png"];
		[updateButton setImage:img2 forState:UIControlStateNormal];
		
		[updateButton setTag:i];
		
		[updateButton addTarget:self action:@selector(openEditNotification:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:updateButton];
		
		
		// Displays each notification
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *sitesFont = [UIFont boldSystemFontOfSize:17.0];
		label.text=[notificationsSites objectAtIndex:i];
		label.font = sitesFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 42+(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *typeFont = [UIFont italicSystemFontOfSize:16.0];
		label.text=[notificationsType objectAtIndex:i];
		label.font = typeFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 64 +(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *messageFont = [UIFont systemFontOfSize:16];
		label.text=[notificationsMessage objectAtIndex:i];
		label.font = messageFont;
		[self.scrollView addSubview:label];
		
		j = j+2;
		
		[label release];
		[messageFont release];
		[sitesFont release];
		[typeFont release];
		
	}
	
	
	
	scrollView.contentSize = CGSizeMake(320, 51 + (j*55));
	
	//[createNotificationView removeFromSuperview];
	
	//[self.view addSubview:view2];
	//[self.view addSubview:scrollView];
	
	CGRect frame3 = createNotificationView.frame;
	frame3.origin.y = 0;
	createNotificationView.frame = frame3;
	
	//[createNotificationView removeFromSuperview];
	[self.view addSubview:createNotificationView];
	
	CGRect frame4 = createNotificationView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 480;
	createNotificationView.frame = frame4;
	[UIView commitAnimations];

	

}
	


- (IBAction) openCreateNotification {
	//[self.view addSubview:createNotificationView];
	notifType = @"cn";
	CGRect frame3 = createNotificationView.frame;
	frame3.origin.y = 480;
	createNotificationView.frame = frame3;
	
	[self.view addSubview:createNotificationView];
	
	CGRect frame4 = createNotificationView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 0;
	createNotificationView.frame = frame4;
	[UIView commitAnimations];
	
	[[[webView subviews] lastObject] setScrollingEnabled:NO]; 
	self.tabBarController.selectedIndex = 0;
	
	NSString *jsCommand = [NSString stringWithFormat:@"resetFields();"];
	[webView stringByEvaluatingJavaScriptFromString:jsCommand];
	
	
	
	
}


- (IBAction) openEditNotification:(id)sender{
	
	if ([notifType isEqualToString:@"dn"])
	{
		notifType = @"dn2";
	}
	else{
		notifType = @"en";
	}
	CGRect frame3 = editNotificationView.frame;
	frame3.origin.y = 480;
	editNotificationView.frame = frame3;
	
	[self.view addSubview:editNotificationView];
	
	CGRect frame4 = editNotificationView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 0;
	editNotificationView.frame = frame4;
	[UIView commitAnimations];
	
	[[[webView2 subviews] lastObject] setScrollingEnabled:NO]; 
	self.tabBarController.selectedIndex = 0;
	
	UIButton* button1 = sender;
	selectedIndex = button1.tag;

	NSString * siteCommand = @"setSiteField('";
	siteCommand = [siteCommand stringByAppendingString:[notificationsSites objectAtIndex:selectedIndex]];
	siteCommand = [siteCommand stringByAppendingString:@"');"];
	
	NSString * messageCommand = @"setMessageField('";
	messageCommand = [messageCommand stringByAppendingString:[notificationsMessage objectAtIndex:selectedIndex]];
	messageCommand = [messageCommand stringByAppendingString:@"');"];
	
	NSString * typeCommand = @"setTypeField('";
	typeCommand = [typeCommand stringByAppendingString:[notificationsType objectAtIndex:selectedIndex]];
	typeCommand = [typeCommand stringByAppendingString:@"');"];
	
	[webView2 stringByEvaluatingJavaScriptFromString:messageCommand];
	[webView2 stringByEvaluatingJavaScriptFromString:typeCommand];
	[webView2 stringByEvaluatingJavaScriptFromString:siteCommand];
	
}



-(IBAction) backToNotifications{
	
	if ([notifType isEqualToString:@"cn"])
	{
		CGRect frame3 = createNotificationView.frame;
		frame3.origin.y = 0;
		createNotificationView.frame = frame3;
	
		//[createNotificationView removeFromSuperview];
		[self.view addSubview:createNotificationView];
	
		CGRect frame4 = createNotificationView.frame;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
	
		frame4.origin.y = 480;
		createNotificationView.frame = frame4;
		[UIView commitAnimations];
	}
	
	if ([notifType isEqualToString:@"en"])
	{
		CGRect frame3 = editNotificationView.frame;
		frame3.origin.y = 0;
		editNotificationView.frame = frame3;
		
		//[createNotificationView removeFromSuperview];
		[self.view addSubview:editNotificationView];
		
		CGRect frame4 = editNotificationView.frame;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		frame4.origin.y = 480;
		editNotificationView.frame = frame4;
		[UIView commitAnimations];
	}
	
	if ([notifType isEqualToString:@"dn"])
	{
		CGRect frame3 = displayNotificationView.frame;
		frame3.origin.y = 0;
		displayNotificationView.frame = frame3;
		
		//[createNotificationView removeFromSuperview];
		[self.view addSubview:displayNotificationView];
		
		CGRect frame4 = displayNotificationView.frame;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		frame4.origin.y = -480;
		displayNotificationView.frame = frame4;
		[UIView commitAnimations];
	}
	
	if ([notifType isEqualToString:@"dn2"])
	{
			CGRect frame3 = editNotificationView.frame;
			frame3.origin.y = 0;
			editNotificationView.frame = frame3;
			
			//[createNotificationView removeFromSuperview];
			[self.view addSubview:editNotificationView];
			
			CGRect frame4 = editNotificationView.frame;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.5];
			
			frame4.origin.y = 480;
			editNotificationView.frame = frame4;
			[UIView commitAnimations];
			notifType = @"dn";
	}
	//[createNotificationView removeFromSuperview];
	//[displayNotificationView removeFromSuperview];
	//[editNotificationView removeFromSuperview];


	self.tabBarController.selectedIndex = 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
	return [list count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [list objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSLog(@"Sel", [list objectAtIndex:row], row);
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

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if(enterViewed)
	{
		[self.view addSubview:view2];
		[self.view addSubview:scrollView];
	}

	enterViewed = YES;
	
	
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[HomeViewController loadNotifications]; 
	
	int count = [notificationsSites count];
	
	for (int i = 0; i < count; i++)
	{
		
		// Creates buttons for each notification
		UIButton *notifButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		notifButton.frame = CGRectMake(60, 20 + (j*55), 200, 70);
		
		UIImage *img = [UIImage imageNamed:@"blankbutton.png"];
		[notifButton setImage:img forState:UIControlStateNormal];
		
		[notifButton setTag:i];
		
		[notifButton addTarget:self action:@selector(displayNotifications:)
		 forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview: notifButton];
		
		
		// Create button for updating notifications
		UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		updateButton.frame = CGRectMake(215, 45 + (j*55), 60, 20);
		
		UIImage *img2 = [UIImage imageNamed:@"UpdateButtonSmall.png"];
		[updateButton setImage:img2 forState:UIControlStateNormal];
		
		[updateButton setTag:i];
		
		[updateButton addTarget:self action:@selector(openEditNotification:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:updateButton];
		
		
		/*
		// Creates button to delete notifications
		UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		deleteButton.frame = CGRectMake(230, 60 + (j*55), 60, 20);
		
		UIImage *img3 = [UIImage imageNamed:@"DeleteButton.png"];
		[deleteButton setImage:img3 forState:UIControlStateNormal];
		
		[deleteButton setTag:i];
		
		[deleteButton addTarget:self action:@selector(deleteNotification:)
		  forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:deleteButton];*/
		
		
		
		
		// Displays each notification
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *sitesFont = [UIFont boldSystemFontOfSize:17.0];
		label.text=[notificationsSites objectAtIndex:i];
		label.font = sitesFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 42+(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *typeFont = [UIFont italicSystemFontOfSize:16.0];
		label.text=[notificationsType objectAtIndex:i];
		label.font = typeFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 64 +(j*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *messageFont = [UIFont systemFontOfSize:16];
		label.text=[notificationsMessage objectAtIndex:i];
		label.font = messageFont;
		[self.scrollView addSubview:label];
		
		j = j+2;
		
		NSString *path;
		NSBundle *thisBundle = [NSBundle mainBundle];
		path = [thisBundle pathForResource:@"editNotification" ofType:@"html"];
		
		// make a file: URL out of the path
		NSURL *instructionsURL = [NSURL fileURLWithPath:path];
		[webView2 loadRequest:[NSURLRequest requestWithURL:instructionsURL]];
		
		path = [thisBundle pathForResource:@"createNotification" ofType:@"html"];
		
		// make a file: URL out of the path
		instructionsURL = [NSURL fileURLWithPath:path];
		[webView loadRequest:[NSURLRequest requestWithURL:instructionsURL]];

		
		[label release];
		[messageFont release];
		[sitesFont release];
		[typeFont release];
		
	}
	
	
	//[HomeViewController displayNotifications];
	//[HomeViewController submitN
	
	//scrollView.contentSize = CGSizeMake(320, 620);
	
    [super viewDidLoad];
}




/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[list release];
    [super dealloc];
}


@end
