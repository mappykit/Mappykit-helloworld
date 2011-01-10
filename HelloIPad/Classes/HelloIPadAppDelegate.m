//
//  HelloIPadAppDelegate.m
//  HelloIPad
//
//  Created by antoine on 09/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "HelloIPadAppDelegate.h"


#import "RootViewController.h"
#import "DetailViewController.h"


@implementation HelloIPadAppDelegate

@synthesize window, splitViewController, rootViewController, detailViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    
    // Add the split view controller's view to the window and display.
    [window addSubview:splitViewController.view];
    [window makeKeyAndVisible];
    detailViewController.mapView.delegate = self;
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Save data if appropriate
}

#pragma mark -
#pragma mark RMMapViewDelegate

- (void) tapOnMarker:(MPMarker *)marker onMap:(RMMapView *)map
{
	if (marker == [detailViewController.mapView userLocation])
	{
		[self showMeIGod:nil];
	}
	MPMarkerManager * m = [detailViewController.mapView markerManager];
	[m hideAllLabel];
	[marker showLabel];
}

-(void) beforeMapMove:(RMMapView *)map
{
	[detailViewController.mapView.userLocation setIsMapFollowMe:NO];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [splitViewController release];
    [window release];
    [super dealloc];
}

-(IBAction) showMeIGood:(id)sender
{
	detailViewController.mapView.showsUserLocation = YES;
}

- (IBAction) showMeIGod:(id)sender
{
	if (detailViewController.mapView.userLocation == nil)
	{
		detailViewController.mapView.showsUserLocation = YES;
	}
	if (count == 0)
		[detailViewController.mapView.userLocation setRotate:YES];
	else 
	{
		[detailViewController.mapView.userLocation setMapRotate:YES];
		count = -1;
	}
	count += 1;
}


@end

