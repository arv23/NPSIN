//
//  SoundTest.h
//  InstantNavigatore
//
//  Created by dni on 2/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SoundTest : UIViewController {
	IBOutlet UIButton *PlayButton;

}
@property (nonatomic, retain) IBOutlet UIButton *PlayButton;

- (IBAction) doPlayButton; 

@end
