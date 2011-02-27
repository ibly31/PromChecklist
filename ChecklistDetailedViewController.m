//
//  ChecklistDetailedViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChecklistDetailedViewController.h"
#import "ChecklistViewController.h"
#import "PromChecklistAppDelegate.h"
#import "RemindMeViewController.h"

@implementation ChecklistDetailedViewController
@synthesize name;
@synthesize remi;

@synthesize schedule;
@synthesize remove;

@synthesize description;
@synthesize progress;
@synthesize cvc;
@synthesize index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Details";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
	NSDate *currentRem = [[[cvc.temp objectAtIndex: [index section]] objectAtIndex: [index row]] objectForKey: @"RemindDate"];
	if(currentRem != nil){
		[schedule setEnabled: NO];
		[remove setEnabled: YES];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat: @"EEEE, MMMM d YYYY"];
		remi.text = [dateFormatter stringFromDate: currentRem];
	}else{
		[schedule setEnabled: YES];
		[remove setEnabled: NO];
		remi.text = @"No date set bro";
	}
}

- (void)viewDidLoad{
	name.text = nameString;
	description.text = descString;
	progress.selectedSegmentIndex = segment;
}

- (IBAction)changedSegment{
	int prog = progress.selectedSegmentIndex;
	[cvc didChangeProgressAtIndexPath:index newProg:prog];
}

- (IBAction)remindMe{
	RemindMeViewController *rmvc = [[RemindMeViewController alloc] initWithNibName:@"RemindMeViewController" bundle:nil];
	NSTimeInterval offset = (float)[[[[cvc.temp objectAtIndex: [index section]] objectAtIndex: [index row]] objectForKey: @"Offset"] intValue];
	NSDate *newDate = [NSDate dateWithTimeInterval:86400.0f * offset + 32400.0f sinceDate: [[NSUserDefaults standardUserDefaults] objectForKey: @"PromDate"]];
	// 86400.0f is the number of seconds in a day... 32400.0f is setting the hour to 9:00 AM (a default time for reminders)
	[rmvc setDate: newDate];
	[rmvc setCdvc: self];
	[newDate release];
	PromChecklistAppDelegate *pcad = [[UIApplication sharedApplication] delegate];
	[pcad.navController pushViewController:rmvc animated:YES];
	[rmvc release];
}

- (void)setName:(NSString *)checkName desc:(NSString *)checkDesc prog:(int)prog ind:(NSIndexPath *)ind{
	index = ind;
	segment = prog;
	nameString = checkName;
	descString = checkDesc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
