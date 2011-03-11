//
//  TicketViewController.h
//  InstantNavigatore
//
//  Created by dni on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SecondView.h"


@interface TicketViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIView *displayTicketFormView;
	IBOutlet UIWebView *webView;
	IBOutlet UILabel *tixRemainingLabel;

}


@property (nonatomic, retain) IBOutlet UIView *displayTicketFormView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *tixRemainingLabel;


+ (void) loadTickets;
- (IBAction) openTicketForm:(id)sender;
-(void) displayTickets:(id)sender;
- (IBAction) updateTickets;
- (IBAction) BackToTickets;

@end
