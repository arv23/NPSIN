//
//  HomeViewController.h
//  InstantNavigatore
//
//  Created by dni on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SecondView.h"


@interface HomeViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	IBOutlet UIButton *enterButton;
	IBOutlet UIView *view2;
	IBOutlet UIView *createNotificationView;
	IBOutlet UIView *displayNotificationView;
	IBOutlet UIView *editNotificationView;
	IBOutlet UIBarButtonItem *cNotificationButton;
	IBOutlet UINavigationBar *navBar;
	IBOutlet UIPickerView *pickerView;
	NSMutableArray *list;
	IBOutlet UIWebView *webView;
	IBOutlet UIWebView *webView2;
	IBOutlet UIButton *postNotificationButton;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UILabel *siteLabel;
	IBOutlet UILabel *typeLabel;
	IBOutlet UITextView *messageBox;
	//IBOutlet UIView *view3;
	IBOutlet UIButton *editButton;
	IBOutlet UIButton *deleteButton;
	
}

@property (nonatomic, retain) IBOutlet UIButton *enterButton;
@property (nonatomic, retain) IBOutlet UIButton *postNotificationButton;
@property (nonatomic, retain) IBOutlet UIView *view2;
@property (nonatomic, retain) IBOutlet UIView *createNotificationView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cNotificationButton;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIWebView *webView2;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *displayNotificationView;
@property (nonatomic, retain) IBOutlet UIView *editNotificationView;
@property (nonatomic, retain) IBOutlet UILabel *siteLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UITextView *messageBox;
@property (nonatomic, retain) IBOutlet UIButton *editButton;
@property (nonatomic, retain) IBOutlet UIButton *deleteButton;
//@property (nonatomic, retain) IBOutlet UIView *view3;


- (IBAction) pushEnter;
- (IBAction) openCreateNotification;
- (IBAction) openEditNotification:(id)sender;
-(IBAction) backToNotifications;
-(IBAction) submitNotification;
-(IBAction) updateNotification;
-(void) displayNotifications:(id)sender;
-(void) deleteNotification:(id) sender;
//- (void) displayNotifications:(id)sender;
//(UIView*)input;
+ (void) loadNotifications;
+ (UIColor*)myColor1;
@end
