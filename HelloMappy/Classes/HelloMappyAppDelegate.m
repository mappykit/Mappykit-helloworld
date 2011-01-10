//
//  HelloMappyAppDelegate.m
//  HelloMappy
//
//  Created by mappy on 02/07/09.
//  Copyright Mappy SA 2009-2011. All rights reserved.
//

#import "HelloMappyAppDelegate.h"
#import "HelloMappyViewController.h"

@implementation HelloMappyAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application { 
    [window addSubview:viewController.view];
	
	viewController.searchBar.delegate = self;
	viewController.mapView.delegate = self;
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[dataSourceIti release];
    [viewController release];
    [window release];
    [super dealloc];
}


//search bar
- (void) searchBarSearchButtonClicked:(UISearchBar *)search
{
	NSLog(@"%@", viewController.searchBar.text);
	[MPGeocoder geocode:search.text delegate:self context:@"HM_SEARCH"];
	//remove the path
	[[viewController.mapView pathManager] removePath:HMP_ITI_CATEGORY];
	//release the data source
	[dataSourceIti release];
	dataSourceIti = nil;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
	[MPGeocoder cancelTasksWithDelegate:self];
	[viewController.searchBar resignFirstResponder];
}


//mappy geocoder 
- (void)didFindLocation:(MPLocationData *)locationData context:(id)aContext{
	viewController.searchBar.text = locationData.address;
	[viewController.searchBar resignFirstResponder];
	
	CLLocationCoordinate2D findLocation = locationData.location.coordinate;
	[viewController.mapView setCenterCoordinate:findLocation]; 
	
	//add a marker on map
	MPMarkerManager *markerManager = [viewController.mapView markerManager];
	MPMarkerCategory * category = [markerManager getCategory:HMP_LOC_CATEGORY];
	//remove old elements	
	[category.dataSource removeAllElements];
	//create a new POI object with location	
	MPPoi * poi = [[MPPoi alloc] initWithUId:locationData.address withLocation:findLocation];
	[category.dataSource addElement:poi];
	[poi release];
	
	//new poi source
	MPMarkerCategory * categoryVelib = [markerManager getCategory:HMP_VELIB_CATEGORY];
	//add a new mappy poi datasource for velib; we limit the number of station showed to 5
	MPPoiDataSourceMappy * dataSource = [[MPPoiDataSourceMappy alloc] initWithIdAndLocation:4347 location:locationData.location.coordinate number:5];
	// if you don't want to upload periodicly the poi data source leave commented
	//[dataSource setUpdatePeriod:30];
	//set the zoom to be optimal : show all poi in the category
	[categoryVelib setOptimalZoom:YES];
	//set label hidden for the first appear on map
	[categoryVelib setHideLabelOnTheFirstShow:YES];
	[categoryVelib setDataSource:dataSource];
	[dataSource release];
}

//disable map centrage on user
-(void) beforeMapMove:(RMMapView *)map
{
	[viewController.mapView.userLocation setIsMapFollowMe:NO];
}

- (void) tapOnMarker: (MPMarker*) marker 
			   onMap: (RMMapView*) map
{
	if (marker != viewController.mapView.userLocation)
	{
		[marker toggleLabel];
		
		if (dataSourceIti != nil)
		{
			[[viewController.mapView pathManager] removePath:HMP_ITI_CATEGORY];
			[dataSourceIti release];
			
		}
		
		//Create step list : start step : userLocation and arrival step : geoElement location.
		CLLocation * userLoc = [[CLLocation alloc] initWithLatitude:viewController.mapView.userLocation.currentLocation.latitude longitude:viewController.mapView.userLocation.currentLocation.longitude];
		CLLocation* loc = [[[CLLocation alloc] initWithLatitude:marker.geoElement.location.latitude longitude:marker.geoElement.location.longitude] autorelease];
		NSArray * steps = [NSArray arrayWithObjects:userLoc, loc, nil]; 
		[userLoc release];
		//Create a bundle and the datasource
		dataSourceIti = [[MPRouteWithStepDataSource alloc] init:steps withBundle:[MPRouteBundle routeBundleWithVehicule:PEDESTRIAN withCost:LENGTH]];
		// create a polyline path
		MPPathPolyline * path = [[MPPathPolyline alloc] init];
		// set the polyline datasource
		[path setDataSource:(id<MPPathDataSource>)[dataSourceIti pathDataSource]];
		// add the new path in the path manager to be drawn on the map.
		[[viewController.mapView pathManager] addPath:path withName:HMP_ITI_CATEGORY];
		[path release];
	}
}

@end
