//
//  InstantNavigatoreAppDelegate.h
//  InstantNavigatore
//
//  Created by dni on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstantNavigatoreAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *rootController;
	
	
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;


@end

