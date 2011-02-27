//
//  RemindMeViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RemindMeViewController.h"
#import "ChecklistViewController.h"
#import "ChecklistDetailedViewController.h"
#import "PromChecklistAppDelegate.h"

@implementation RemindMeViewController

@synthesize dpicker;
@synthesize date;
@synthesize cdvc;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Remind Me";
    }
    return self;
}

- (void)viewDidLoad{
	[dpicker setDate: date animated:NO];
}

- (IBAction)changeDate{
	NSDate *toSched = [dpicker date];
	if([toSched compare: [NSDate date]] == NSOrderedAscending){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Date Invalid" message:@"The date you chose is in the past, please choose a date that is in the future." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	NSIndexPath *index = cdvc.index;
	[[[cdvc.cvc.temp objectAtIndex: [index section]] objectAtIndex: [index row]] setObject:toSched forKey:@"RemindDate"];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	[cdvc.cvc.temp writeToFile: checklistName atomically: YES];
	
	PromChecklistAppDelegate *pcad = [[UIApplication sharedApplication] delegate];
	[pcad.navController popViewControllerAnimated: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
