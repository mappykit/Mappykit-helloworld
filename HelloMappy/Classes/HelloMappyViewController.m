//
//  HelloMappyViewController.m
//  HelloMappy
//
//  Created by mappy on 02/07/09.
//  Copyright Mappy SA 2009-2011. All rights reserved.
//

#import "HelloMappyViewController.h"
#import "MappyKitAPIKey.h"

@implementation HelloMappyViewController

@synthesize mapView;
@synthesize searchBar;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//init
	//initialisation with apikey
	[MPInit initialisation:MAPPYKIT_API_KEY];
	[RMMapView class];
	
	//show user location
	mapView.showsUserLocation = YES;
	
	//Marker initialization
	MPMarkerManager *markerManager = [mapView markerManager];
	//add a new category with orange default color
	[markerManager addCategory:HMP_LOC_CATEGORY withColor:[UIColor orangeColor]];
	//add a new category with white default color
    MPMarkerCategory * bikeCategory = [markerManager addCategory:HMP_VELIB_CATEGORY withColor:[UIColor whiteColor]];
	bikeCategory.animateAtFirstShow =YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
	[mapView release];
	[searchBar release];
    [super dealloc];
}


@end
