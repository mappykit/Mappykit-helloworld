//
//  HelloIPadAppDelegate.h
//  HelloIPad
//
//  Created by antoine on 09/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MappyKit/MappyKit.h>

@class RootViewController;
@class DetailViewController;

@interface HelloIPadAppDelegate : NSObject <UIApplicationDelegate, RMMapViewDelegate> {
    
    UIWindow *window;
    
    UISplitViewController *splitViewController;
    
    RootViewController *rootViewController;
    DetailViewController *detailViewController;
	
	int count;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

- (IBAction) showMeIGod:(id)sender;

@end
