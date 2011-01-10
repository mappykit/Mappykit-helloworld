//
//  RootViewController.m
//  HelloIPad
//
//  Created by antoine on 09/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import <MappyKit/MappyKit.h>


@implementation RootViewController

@synthesize detailViewController;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	
	MPMarkerManager *markerManager = [detailViewController.mapView markerManager];
	MPMarkerCategory * c = [markerManager addCategory:@"HMP_VELIB_CATEGORY" withColor:[UIColor whiteColor]];
	c.animateAtFirstShow =YES;
	MPMarkerCategory * categoryVelib = [markerManager getCategory:@"HMP_VELIB_CATEGORY"];
	//add a new mappy poi datasource for velib; we limit the number of station showed to 5
	MPPoiDataSourceMappy * dataSource = [[MPPoiDataSourceMappy alloc] initWithId:4347 number:15 update:YES];
	// if you don't want to upload periodicly the poi data source leave commented
	//[dataSource setUpdatePeriod:30];
	//set the zoom to be optimal : show all poi in the category
	[categoryVelib setOptimalZoom:YES];
	//set label hidden for the first appear on map
	[categoryVelib setHideLabelOnTheFirstShow:YES];
	[categoryVelib setDataSource:dataSource];
	self.tableView.dataSource = dataSource;
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:MPGeoElementDataSourceHasBeenUpdated object:dataSource];
	
	[dataSource release];
}

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //zoom sur la carte
	//saut du poi?
    MPPoiDataSourceMappy * mp =  (MPPoiDataSourceMappy*)self.tableView.dataSource;
	NSArray * listPoi = [mp getListOfElement];
	if ([listPoi count] > indexPath.row)
	{
		MPPoi * mpoi = [listPoi objectAtIndex:indexPath.row];
		[detailViewController.mapView setRegion:mpoi.location latitudeSpan:0.001f longitudeSpan:0.001f animated:YES];
		MPMarkerManager *markerManager = [detailViewController.mapView markerManager];
		MPMarkerCategory * categoryVelib = [markerManager getCategory:@"HMP_VELIB_CATEGORY"];
		[categoryVelib hideAllLabel];
		MPMarker * marker = [categoryVelib getViewForElement:mpoi];
		[marker jump];
		[marker showLabel];
	}
	
	detailViewController.detailItem = [NSString stringWithFormat:@"Platform String: %@", [[UIDevice currentDevice]model]];//[NSString stringWithFormat:@"Row %d", indexPath.row];
	NSLog(@"Platform String: %@", [[UIDevice currentDevice]model]);
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [detailViewController release];
    [super dealloc];
}


@end

