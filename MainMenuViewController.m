//
//  MainMenuViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "PromChecklistAppDelegate.h"
#import "OptionsViewController.h"
#import "HelpViewController.h"
#import "ChecklistViewController.h"
#import "InformationViewController.h"

@implementation MainMenuViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Main Menu";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
	float r = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeR"];
	float g = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeG"];
	float b = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeB"];
	UIColor	*colorScheme = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
	[self.navigationController.navigationBar setTintColor: colorScheme];
	//[self viewChecklist];
}

- (IBAction)viewChecklist{
	cvc = [[ChecklistViewController alloc] initWithNibName:@"ChecklistViewController" bundle:nil];
	PromChecklistAppDelegate *pcad = [[UIApplication sharedApplication] delegate];
	[[pcad navController] pushViewController: cvc animated: YES];
	[cvc release];
}

- (IBAction)options{
	OptionsViewController *ovc = [[OptionsViewController alloc] initWithNibName:@"OptionsViewController" bundle:nil];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ovc];
	float r = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeR"];
	float g = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeG"];
	float b = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeB"];
	UIColor	*colorScheme = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
	[navController.navigationBar setTintColor: colorScheme];
	[ovc release];
	[self presentModalViewController:navController animated:YES];
	[navController release];
}

- (IBAction)information{
	InformationViewController *ivc = [[InformationViewController alloc] initWithNibName:@"InformationViewController" bundle:nil];
	[self presentModalViewController:ivc animated:YES];
	[ivc release];
}

- (IBAction)help{
	HelpViewController *hvc = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
	[self presentModalViewController: hvc animated:YES];
	[hvc release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
