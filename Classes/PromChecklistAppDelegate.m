//
//  PromChecklistAppDelegate.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PromChecklistAppDelegate.h"
#import "ChecklistDetailedViewController.h"

@implementation PromChecklistAppDelegate

@synthesize window;
@synthesize ssvc;
@synthesize mmvc;
@synthesize ilvc;
@synthesize navController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	ssvc = [[SplashScreenViewController alloc] initWithNibName:@"SplashScreenViewController" bundle:nil];
	ssvc.pcad = self;
	[self.window addSubview: ssvc.view];
    [self.window makeKeyAndVisible];
	
	UILocalNotification *localNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsLocalNotificationKey];
	if(localNotification != nil){
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex: 0];
		NSString *checklistFileName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
		NSMutableArray *temp = [[NSArray alloc] initWithContentsOfFile: checklistFileName];
		NSDictionary *userInfo = [localNotification userInfo];
		
		[[[temp objectAtIndex: [[userInfo objectForKey:@"Section"] intValue]] objectAtIndex: [[userInfo objectForKey:@"Row"] intValue]] removeObjectForKey:@"RemindDate"];
		[temp writeToFile:checklistFileName atomically:YES];
		[temp release];
	}
    return YES;
}

- (void)endSplashScreenWithInitialLoad:(BOOL)dateExists{
	[ssvc.view removeFromSuperview];
	[ssvc release];
	
	if(dateExists){
		mmvc = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
		navController = [[UINavigationController alloc] initWithRootViewController: mmvc];
		[mmvc release];
	}else{
		ilvc = [[InitialLoadViewController alloc] initWithNibName:@"InitialLoadViewController" bundle:nil];
		navController = [[UINavigationController alloc] initWithRootViewController: ilvc];
		[ilvc release];
	}
	
	if([[NSUserDefaults standardUserDefaults] objectForKey:@"ColorSchemeR"] != nil){
		float r = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeR"];
		float g = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeG"];
		float b = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeB"];
		UIColor	*colorScheme = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
		navController.navigationBar.tintColor = colorScheme;
	}else{
		UIColor *colorScheme = [UIColor colorWithRed:0.96f green:0.39f blue:0.67f alpha:1.0f];
		[[NSUserDefaults standardUserDefaults] setFloat:0.96f forKey:@"ColorSchemeR"];
		[[NSUserDefaults standardUserDefaults] setFloat:0.39f forKey:@"ColorSchemeG"];
		[[NSUserDefaults standardUserDefaults] setFloat:0.67f forKey:@"ColorSchemeB"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		navController.navigationBar.tintColor = colorScheme;
	}
	
	[self.window addSubview: navController.view];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PromChecklist" message:[notification alertBody] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
	[alert show];
	[alert release];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistFileName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	NSMutableArray *temp = [[NSArray alloc] initWithContentsOfFile: checklistFileName];
	NSDictionary *userInfo = [notification userInfo];
	
	[[[temp objectAtIndex: [[userInfo objectForKey:@"Section"] intValue]] objectAtIndex: [[userInfo objectForKey:@"Row"] intValue]] removeObjectForKey:@"RemindDate"];
	[temp writeToFile:checklistFileName atomically:YES];
	[temp release];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
