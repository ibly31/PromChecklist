//
//  PromChecklistAppDelegate.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashScreenViewController.h"
#import "MainMenuViewController.h"
#import "InitialLoadViewController.h"

@interface PromChecklistAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
	SplashScreenViewController *ssvc;
	MainMenuViewController* mmvc;
	InitialLoadViewController *ilvc;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet SplashScreenViewController *ssvc;
@property (nonatomic, retain) IBOutlet MainMenuViewController *mmvc;
@property (nonatomic, retain) IBOutlet InitialLoadViewController *ilvc;

- (void)endSplashScreenWithInitialLoad:(BOOL)dateExists;

@end

