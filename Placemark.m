//
//  Placemark.m
//  InstantNavigatore
//
//  Created by Christopher on 2/24/10.
//  Copyright 2010 Drexel University. All rights reserved.
//

#import "Placemark.h"

@implementation Placemark
@synthesize coordinate;
@synthesize titleString;
@synthesize subtitleString;


- (NSString *)subtitle{
	return subtitleString;
}
- (NSString *)title{
	return titleString;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}
@end