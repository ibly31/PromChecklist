//
//  InitialLoadViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InitialLoadViewController.h"
#import "PromChecklistAppDelegate.h"
#import "MainMenuViewController.h"

@implementation InitialLoadViewController
@synthesize datePicker;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Set Prom Date";
		self.datePicker = [[UIDatePicker alloc] initWithFrame: CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
        datePicker.datePickerMode = UIDatePickerModeDate;
		[self.view addSubview: datePicker];
    }
    return self;
}

- (IBAction)pickedDate{
	NSDate *chosenDate = [datePicker date];
	if([chosenDate compare: [NSDate date]] == NSOrderedAscending){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Date Invalid" message:@"The date you chose is in the past, please choose a date that is in the future." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	[[NSUserDefaults standardUserDefaults] setObject:chosenDate forKey:@"PromDate"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	NSArray *templateArray = [[NSArray alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Template" ofType:@"plist"]];
	NSMutableArray *newArray = [[NSMutableArray alloc] init];
	for(int x = 0; x < 6; x++){
		NSMutableArray *monthArray = [[NSMutableArray alloc] init];
		for(int y = 0; y < [[templateArray objectAtIndex: x] count]; y++){
			NSMutableDictionary *checkEntry = [[NSMutableDictionary alloc] initWithDictionary:[[templateArray objectAtIndex: x] objectAtIndex: y]];
			[checkEntry setObject: [NSNumber numberWithInt: 0] forKey: @"Progress"];
			[monthArray addObject: checkEntry];
		}
		[newArray addObject: monthArray];
	}
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	
	[newArray writeToFile: checklistName atomically: YES];
	
	PromChecklistAppDelegate *pcad = [[UIApplication sharedApplication] delegate];
	MainMenuViewController *mmvc = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
	[[pcad navController] setViewControllers: [NSArray arrayWithObjects: mmvc, nil] animated: YES];
	[mmvc release];
	return;
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
