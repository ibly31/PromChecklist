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
#import "ChecklistViewController.h"

@implementation MainMenuViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Main Menu";
    }
    return self;
}

- (void)viewDidLoad{
//	[self viewChecklist];
}

- (IBAction)viewChecklist{
	ChecklistViewController *cvc = [[ChecklistViewController alloc] initWithNibName:@"ChecklistViewController" bundle:nil];
	PromChecklistAppDelegate *pcad = [[UIApplication sharedApplication] delegate];
	[[pcad navController] pushViewController: cvc animated: YES];
	[cvc release];
}

- (IBAction)options{
	OptionsViewController *ovc = [[OptionsViewController alloc] initWithNibName:@"OptionsViewController" bundle:nil];
	[self presentModalViewController:ovc animated:YES];
	[ovc release];
}

- (IBAction)help{
	
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
