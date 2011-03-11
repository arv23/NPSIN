//
//  SiteOneController.h
//  InstantNavigatore
//
//  Created by dni on 2/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class AudioStreamer;


@interface SiteOneController : UIViewController {
	MPMoviePlayerController *moviePlayer;
	AudioStreamer *streamer;
	IBOutlet UIWebView *webView;
	IBOutlet UIWebView *webView2;
	IBOutlet UIView *view1;
	IBOutlet UIButton *button1;
	

	
}

@property (nonatomic, retain) IBOutlet UIView *view1;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) IBOutlet UIWebView *webView2;


+ (UIColor*)myColor1;
+ (UIColor*)myColor2;
+ (UINavigationBar*)myNavBar1: (NSString*)input;
@property (readwrite, retain) MPMoviePlayerController *moviePlayer;
- (void) showCCView:(id) sender;
- (void) backToSites:(id) sender;
-(int)getIndexOf:(char)c:(NSString*)string;

-(void)checkContent:(NSString *)name; 
-(IBAction) openEmailSend:(id)sender;
@end
