//
//  NavigationViewController.m
//  InstantNavigatore
//
//  Created by dni on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NavigationViewController.h"


@implementation NavigationViewController

@synthesize mapView;
@synthesize locationManager;
@synthesize	retrievedLocation;
@synthesize mStoreLocationButton;
@synthesize centerSitesButton;

BOOL regionHasBeenSet;


CLLocationCoordinate2D presidentHouse;
CLLocationCoordinate2D constitutionCenter;
CLLocationCoordinate2D franklinCourt;


//CLLocation *testLoc = [[CLLocation alloc] initWithCoordinate:testLocation altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:today];
CLLocation *locPresHouse;
CLLocation *locConCenter;
CLLocation *locFrankCourt;

Placemark *presHouseMarker;
Placemark *conCenterHouseMarker;
Placemark *franklinCourtMarker;

CLLocationDistance distanceFromPresHouse;

CLLocationDistance distanceFromConCenter;
CLLocationDistance distanceFromFrankCourt;

double distPH;
double distCC;
double distFC;

NSString *PHLocString;
NSString *CCLocString;
NSString *FCLocString;




 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
	[super viewDidLoad];

	regionHasBeenSet = NO;
	
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	
	[locationManager startUpdatingLocation];
	
	
	mapView.showsUserLocation = YES;
	mapView.scrollEnabled = YES;
	mapView.mapType=MKMapTypeStandard;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	
	
	MKPinAnnotationView *test=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    test.pinColor = MKPinAnnotationColorPurple;
    test.animatesDrop=TRUE;
    test.canShowCallout = YES;
    test.calloutOffset = CGPointMake(-5, 5);
	test.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	
	[test setCanShowCallout:YES];
	[test setSelected:YES animated:YES];
	
    return test;
									
	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:fromLocation:(CLLocation *)oldLocation{
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	//mStoreLocationButton.hidden=FALSE;
	currentLocation=newLocation.coordinate;
	
	retrievedLocation = newLocation;
	
	if (regionHasBeenSet == NO)
	{
		//One location is obtained.. just zoom to that location
		MKCoordinateRegion region;
		region.center.latitude = currentLocation.latitude;
		region.center.longitude = currentLocation.longitude;
		region.span.latitudeDelta = .005;
		region.span.longitudeDelta = .005;
		[mapView setRegion:region animated:YES];
		regionHasBeenSet = YES;
	}
	
	// [locationManager stopUpdatingLocation];
	
	CLLocationCoordinate2D presidentHouse;
	CLLocationCoordinate2D constitutionCenter;
	CLLocationCoordinate2D franklinCourt;
	
	
	presidentHouse.latitude = 39.950255;
	presidentHouse.longitude = -75.149403;
	constitutionCenter.latitude = 39.952977457209876;
	constitutionCenter.longitude = -75.14897346496582;
	franklinCourt.latitude = 39.950272;
	franklinCourt.longitude = -75.146394;
	
	NSDate *today = [NSDate date];
	
	//CLLocation *testLoc = [[CLLocation alloc] initWithCoordinate:testLocation altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:today];
	locPresHouse = [[CLLocation alloc] initWithCoordinate:presidentHouse altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:today];
	locConCenter = [[CLLocation alloc] initWithCoordinate:constitutionCenter altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:today];
	locFrankCourt = [[CLLocation alloc] initWithCoordinate:franklinCourt altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:today];
	
	presHouseMarker=[[Placemark alloc] initWithCoordinate:presidentHouse];
	conCenterHouseMarker=[[Placemark alloc] initWithCoordinate:constitutionCenter];
	franklinCourtMarker=[[Placemark alloc] initWithCoordinate:franklinCourt];
	
	distanceFromPresHouse = [retrievedLocation getDistanceFrom:locPresHouse];
	distanceFromConCenter = [retrievedLocation getDistanceFrom:locConCenter];
	distanceFromFrankCourt = [retrievedLocation getDistanceFrom:locFrankCourt];
	
	distPH = distanceFromPresHouse * 0.000621371192237334;
	distCC = distanceFromConCenter * 0.000621371192237334;
	distFC = distanceFromFrankCourt * 0.000621371192237334;
	
	PHLocString = [NSString stringWithFormat:@"Distance (Miles) From Current Location:  %.2lf", distPH];
	CCLocString = [NSString stringWithFormat:@"Distance (Miles) From Current Location:  %.2lf", distCC];
	FCLocString = [NSString stringWithFormat:@"Distance (Miles) From Current Location:  %.2lf", distFC];
	
	//NSString *myString =[NSString stringWithFormat:@"%f",dist];	
	
	//	currentLocMarker.titleString = @"My Current Location";
	presHouseMarker.titleString = @"President's House";
	presHouseMarker.subtitleString = PHLocString;
	conCenterHouseMarker.titleString = @"National Constitution Center";
	conCenterHouseMarker.subtitleString = CCLocString;
	franklinCourtMarker.titleString = @"Franklin Court";
	franklinCourtMarker.subtitleString = FCLocString;
	
	
	
	[mapView addAnnotation:presHouseMarker];
	[mapView addAnnotation:conCenterHouseMarker];
	[mapView addAnnotation:franklinCourtMarker];
	
	/*[locPresHouse release];
	[locConCenter release];
	[locFrankCourt release];
	[presHouseMarker release];
	[conCenterHouseMarker release];
	[franklinCourtMarker release];
	[PHLocString release];
	[CCLocString release];
	[FCLocString release];*/
	
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
}

- (IBAction)updateDistances:(id) sender{
	
	currentLocation = mapView.userLocation.coordinate;
	MKCoordinateRegion region;
	region.center.latitude = currentLocation.latitude;
	region.center.longitude = currentLocation.longitude;
	region.span.latitudeDelta = .005;
	region.span.longitudeDelta = .005;
	[mapView setRegion:region animated:YES];

}

- (IBAction)centerSites:(id) sender{
	
	MKCoordinateRegion region;
	region.center.latitude = 39.951974070328404;
	region.center.longitude = -75.14802932739258;
	region.span.latitudeDelta = .005;
	region.span.longitudeDelta = .005;
	[mapView setRegion:region animated:YES];
	
}

- (void)dealloc {
    [super dealloc];
}

@end
