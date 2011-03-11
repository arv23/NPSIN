//
//  TicketViewController.m
//  InstantNavigatore
//
//  Created by dni on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TicketViewController.h"


@implementation TicketViewController

@synthesize scrollView;
//@synthesize siteLabel;
//@synthesize eventsLabel;
//@synthesize ticketsLabel
@synthesize webView;
@synthesize displayTicketFormView;

NSMutableArray *ticketsEvents;
NSMutableArray *ticketsSites;
NSMutableArray *ticketsLeft;
NSMutableArray *reserveNames;

int p = 0;
int selIndex = 0;




+ (void) loadTickets
{
	ticketsEvents = [[NSMutableArray alloc] init];
	ticketsSites = [[NSMutableArray alloc] init];
	ticketsLeft = [[NSMutableArray alloc] init];
	reserveNames = [[NSMutableArray alloc] init];
	
	// for now setup some dummy ones
	NSString *tickets=@"";
	int firstNumber = 10;
	
	
	
	tickets=@"Presidential Presentation";
	[ticketsEvents insertObject:tickets atIndex:0];
	tickets=@"Presidents House";
	[ticketsSites insertObject:tickets atIndex:0];
	tickets=@"40";
	[ticketsLeft insertObject:tickets atIndex:0];
	
	
	tickets=@"Constitution Center Tour";
	[ticketsEvents insertObject:tickets atIndex:1];
	tickets=@"Constitution Center";
	[ticketsSites insertObject:tickets atIndex:1];
	tickets=@"30";
	[ticketsLeft insertObject:tickets atIndex:1];
	
	[tickets release];
	
	
	
	
}

- (IBAction) openTicketForm:(id)sender{
	CGRect frame3 = displayTicketFormView.frame;
	frame3.origin.y = 480;
	displayTicketFormView.frame = frame3;
	
	//[createNotificationView removeFromSuperview];
	[self.view addSubview:displayTicketFormView];
	
	CGRect frame4 = displayTicketFormView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 0;
	displayTicketFormView.frame = frame4;
	[UIView commitAnimations];
	[[[webView subviews] lastObject] setScrollingEnabled:NO]; 
	
	UIButton* button1 = sender;
	selIndex = button1.tag;
	
	NSString * siteCommand = @"setSiteField('";
	siteCommand = [siteCommand stringByAppendingString:[ticketsSites objectAtIndex:selIndex]];
	siteCommand = [siteCommand stringByAppendingString:@"');"];
	
	NSString * eventsCommand = @"setEventField('";
	eventsCommand = [eventsCommand stringByAppendingString:[ticketsEvents objectAtIndex:selIndex]];
	eventsCommand = [eventsCommand stringByAppendingString:@"');"];
	
	NSString *jsCommand = [NSString stringWithFormat:@"resetFields();"];
	
	tixRemainingLabel.text = [ticketsLeft objectAtIndex:selIndex];
	
	[webView stringByEvaluatingJavaScriptFromString:jsCommand];
	[webView stringByEvaluatingJavaScriptFromString:siteCommand];
	[webView stringByEvaluatingJavaScriptFromString:eventsCommand];
	

}

- (IBAction) BackToTickets
{
	CGRect frame3 = displayTicketFormView.frame;
	frame3.origin.y = 0;
	displayTicketFormView.frame = frame3;
	
	//[createNotificationView removeFromSuperview];
	[self.view addSubview:displayTicketFormView];
	
	CGRect frame4 = displayTicketFormView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 480
	;
	displayTicketFormView.frame = frame4;
	[UIView commitAnimations];
}

- (IBAction) updateTickets
{
	
	NSString *left = [webView stringByEvaluatingJavaScriptFromString: @"document.formNotification.ticketsLeft.value"];
	NSString *name = [webView stringByEvaluatingJavaScriptFromString: @"document.formNotification.nameField.value"];
	NSString *tickets=@"";
	
	tickets=left;
	
	int totalTickets = 0;
	
	int currentTicketsValue = [[ticketsLeft objectAtIndex:selIndex] intValue];
	int ticketsSubtractedValue = [left intValue];
	
	if (currentTicketsValue < ticketsSubtractedValue)
	{
		totalTickets = 0;
	}
	else
	{
		totalTickets = currentTicketsValue - ticketsSubtractedValue;
	}
	
	
	
	
	tickets = [NSString stringWithFormat:@"%d", totalTickets];
	
		
	[ticketsLeft replaceObjectAtIndex:selIndex withObject:tickets];
	[reserveNames addObject:name];
	
	//[tickets release];
	
	p = 0;
	
	int count = [ticketsSites count];
	
	for (int i = 0; i < count; i++)
	{
		
		// Creates buttons for each notification
		UIButton *notifButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		notifButton.frame = CGRectMake(60, 20 + (p*55), 200, 70);
		
		UIImage *img = [UIImage imageNamed:@"blankbutton.png"];
		[notifButton setImage:img forState:UIControlStateNormal];
		
		[notifButton setTag:i];
		
		[notifButton addTarget:self action:@selector(openTicketForm:)
			  forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview: notifButton];
		
		// Create button for updating notifications
		UIButton *reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		reserveButton.frame = CGRectMake(225, 45 + (p*55), 60, 20);
		
		UIImage *img2 = [UIImage imageNamed:@"ReserveBtnSmall.png"];
		[reserveButton setImage:img2 forState:UIControlStateNormal];
		
		[reserveButton setTag:i];
		
		[reserveButton addTarget:self action:@selector(openTicketForm:)
				forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:reserveButton];
		
		
		
		// Displays each notification
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+(p*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *sitesFont = [UIFont boldSystemFontOfSize:17.0];
		label.text=[ticketsSites objectAtIndex:i];
		label.font = sitesFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 42+(p*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *typeFont = [UIFont italicSystemFontOfSize:16.0];
		label.text=[ticketsEvents objectAtIndex:i];
		label.font = typeFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 64 +(p*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *messageFont = [UIFont systemFontOfSize:16];
		
		
		label.text = [@"Remaining Tickets: " stringByAppendingString:[ticketsLeft objectAtIndex:i]];
		label.font = messageFont;
		[self.scrollView addSubview:label];
		tixRemainingLabel.text = [ticketsLeft objectAtIndex:i];
		
		p = p+2;
		
		[label release];
		[messageFont release];
		[sitesFont release];
		[typeFont release];
		
	}

	CGRect frame3 = displayTicketFormView.frame;
	frame3.origin.y = 0;
	displayTicketFormView.frame = frame3;
	
	//[createNotificationView removeFromSuperview];
	[self.view addSubview:displayTicketFormView];
	
	CGRect frame4 = displayTicketFormView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	frame4.origin.y = 480;
	displayTicketFormView.frame = frame4;
	[UIView commitAnimations];
	
	
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"1");
	[TicketViewController loadTickets]; 
	
	int count = [ticketsSites count];
	
	for (int i = 0; i < count; i++)
	{
		// Creates buttons for each notification
		UIButton *notifButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		notifButton.frame = CGRectMake(60, 20 + (p*55), 200, 70);
		
		UIImage *img = [UIImage imageNamed:@"blankbutton.png"];
		[notifButton setImage:img forState:UIControlStateNormal];
		
		[notifButton setTag:i];
		
		[notifButton addTarget:self action:@selector(openTicketForm:)
			  forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview: notifButton];
		
		// Create button for updating notifications
		UIButton *reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		reserveButton.frame = CGRectMake(225, 45 + (p*55), 60, 20);
		
		UIImage *img2 = [UIImage imageNamed:@"ReserveBtnSmall.png"];
		[reserveButton setImage:img2 forState:UIControlStateNormal];
		
		[reserveButton setTag:i];
		
		[reserveButton addTarget:self action:@selector(openTicketForm:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		[self.scrollView addSubview:reserveButton];
		
		
		// Displays each notification
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+(p*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *sitesFont = [UIFont boldSystemFontOfSize:17.0];
		label.text=[ticketsSites objectAtIndex:i];
		label.font = sitesFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 42+(p*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *typeFont = [UIFont italicSystemFontOfSize:16.0];
		label.text=[ticketsEvents objectAtIndex:i];
		label.font = typeFont;
		[self.scrollView addSubview:label];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(20, 64 +(p*55), 200, 25)];
		[label setBackgroundColor:[UIColor clearColor]];
		UIFont *messageFont = [UIFont systemFontOfSize:16];
		//int tix = [[ticketsLeft objectAtIndex:i]intValue];
		//NSString *tempString = [NSString stringWithFormat:@"Tickets Remaining: %d", tix];
		label.text = [@"Remaining Tickets: " stringByAppendingString:[ticketsLeft objectAtIndex:i]];
		label.font = messageFont;
		[self.scrollView addSubview:label];
		
		p = p+2;
		
		NSString *path;
		NSBundle *thisBundle = [NSBundle mainBundle];
		path = [thisBundle pathForResource:@"ticketForm" ofType:@"html"];
		
		// make a file: URL out of the path
		NSURL *instructionsURL = [NSURL fileURLWithPath:path];
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
    [super dealloc];
}


@end
