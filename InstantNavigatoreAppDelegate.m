//
//  InstantNavigatoreAppDelegate.m
//  InstantNavigatore
//
//  Created by dni on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "InstantNavigatoreAppDelegate.h"



@implementation InstantNavigatoreAppDelegate

@synthesize window;
@synthesize rootController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[window addSubview:rootController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[rootController release];
    [window release];
    [super dealloc];
}


@end
