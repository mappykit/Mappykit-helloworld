//
//  HelloMappyViewController.h
//  HelloMappy
//
//  Created by mappy on 02/07/09.
//  Copyright Mappy SA 2009-2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MappyKit/MappyKit.h>

#define HMP_LOC_CATEGORY @"loc"
#define HMP_VELIB_CATEGORY @"velib"
#define HMP_ITI_CATEGORY @"iti"

@interface HelloMappyViewController : UIViewController {
		RMMapView *mapView;
		UISearchBar *searchBar;
}

@property (nonatomic, retain) IBOutlet RMMapView *mapView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@end

