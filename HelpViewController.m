//
//  HelpViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"


@implementation HelpViewController
@synthesize bar;

- (IBAction)back{
	[self dismissModalViewControllerAnimated: YES];
}

- (void)viewDidLoad{
	float r = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeR"];
	float g = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeG"];
	float b = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeB"];
	UIColor	*colorScheme = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
	[bar setTintColor: colorScheme];
}

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
