//
//  NavigationViewController.h
//  InstantNavigatore
//
//  Created by dni on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Mapkit/MKReverseGeocoder.h>
#import <Mapkit/MKAnnotation.h>
//#import "MyCLController.h"
#import "Placemark.h";

@interface NavigationViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {

	CLLocationManager *locationManager;
	CLLocation *retrievedLocation;
	//MyCLController *locationController;
	CLLocationCoordinate2D currentLocation;
	MKPlacemark *mPlacemark;
	UIBarButtonItem *bbutton;

	MKMapView *mapView;
	IBOutlet UIBarButtonItem *mStoreLocationButton;
	bool *firstTime;
	UIButton *centerSitesButton;
	
	
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocation *retrievedLocation;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *mStoreLocationButton;
@property (nonatomic, retain) IBOutlet UIButton *centerSitesButton;


//-(IBAction)showInfo;
-(IBAction)updateDistances:(id) sender;
-(IBAction)centerSites:(id) sender;

@end
