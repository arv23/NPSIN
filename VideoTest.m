//
//  VideoTest.m
//  InstantNavigatore
//
//  Created by dni on 2/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VideoTest.h"


@implementation VideoTest

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/



- (void)loadView {
    NSString *moviePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"pres_topic1_vid001.mp4"];
	
	
	
	
	MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:moviePath]];
	
	moviePlayer.movieControlMode = MPMovieControlModeDefault;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback :) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
	
	[moviePlayer play];
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
