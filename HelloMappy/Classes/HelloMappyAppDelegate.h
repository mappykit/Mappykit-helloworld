//
//  HelloMappyAppDelegate.h
//  HelloMappy
//
//  Created by mappy on 02/07/09.
//  Copyright Mappy SA 2009-2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MappyKit/MappyKit.h>

@class HelloMappyViewController;

@interface HelloMappyAppDelegate : NSObject <UIApplicationDelegate, MPGeoLocDelegate, UISearchBarDelegate, RMMapViewDelegate> {
    UIWindow *window;
    HelloMappyViewController *viewController;
	
	MPItiDataSource * dataSourceIti;
	int stepCount;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HelloMappyViewController *viewController;

@end

