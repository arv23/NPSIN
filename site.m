#import <objc/Object.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>
#import <CoreLocation/CoreLocation.h>

@interface Site : Object
{
	NSString *name;
	unsigned int siteID;
	NSMutableArray *assetList=[[NSMutableArray alloc] init];
	double cost;
	CLLocationCoordinate2D location;
	NSString *siteAbbrv;
	unsigned int waitTime;
}

- (void) setName: (NSString*) n;
- (NSString*) getName;
- (void) setSiteID: (unsigned int) id;
- (unsigned int) getSiteID;
- (void) addAsset (Asset) newAsset;
- (int) getAssetCount;
- (Asset) getAsset: (int) assetNumber;
- (void) setCost: (double) newCost;
- (double) getCost;
- (void) setLatitude: (double) newLatitude;
- (void) setLongitude: (double) newLongitude;
- (CLLocationCoordinate2D) getLocation;
- (double) getLatitude;
- (double) getLongitude;
- (void) setSiteAbbrv: (NSString*) newSiteAbbrv;
- (NSString*) getSiteAbbrv;
- (void) setWaitTime: (unsigned int) newWaitTime;
- (unsigned int) getWaitTime;

@end

@implementation Site

- (void) setName: (NSString*) n
	{
		[n retain];
		[name release];
		name=n;
	}

- (NSString*) getName
{
	return name;
}

- (void) setSiteID: (unsigned int) newID
{
	[newID retain];
	[siteID release];
	siteID=newId;
}

- (unsigned int) getSiteID
{
	return siteID;
}

- (void) addAsset: (Asset) newAsset
{
	[assetList addObject: newAsset];
}

- (NSMutableArray*) getAssetList
{
	return assetList;
}

- (Asset) getAsset: (int) assetNumber
{
	return [assetList objectAtIndex: assetNumber];
}

- (void) setCost: (double) newCost
{
	[newCost retain];
	[cost release];
	cost=newCost;
}

- (double) getCost
{
	return cost;
}

- (void) setLatitude: (double) newLat
{
	[newLat retain];
	[location.latitude release];
	location.latitude=newLat;
}

- (void) setLongitude: (double) newLong
{
	[newLong retain];
	[location.longitude release];
	location.longitude=newLong;
}

- (CLLocationCoordinate2D) getLocation
{
	return location;
}

- (double) getLatitude
{
	return location.latitude;
}

- (double) getLongitude
{
	return location.longitude;
}

- (void) setSiteAbbrv: (NSString*) newSiteAbbrv
{
	[newSiteAbbrv retain];
	[siteAbbrv release];
	siteAbbrv=newSiteAbbrv;
}

- (NSString*) getSiteAbbrv
{
	return siteAbbrv;
}

- (void) setWaitTime: (unsigned int) newWaitTime
{
	[newWaitTime retain];
	[waitTime release];
	waitTime=newWaitTime;
}

- (unsigned int) getWaitTime
{
	return waitTime;
}

@end
