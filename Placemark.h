//
//  Placemark.h
//  InstantNavigatore
//
//  Created by Christopher on 2/24/10.
//  Copyright 2010 Drexel University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Placemark : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *titleString;
	NSString *subtitleString;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, retain) NSString *titleString;
@property(nonatomic, retain) NSString *subtitleString;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;
- (NSString *)subtitle;
- (NSString *)title;

@end