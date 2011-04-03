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
		[dateFormatter setDateFormat: @"EEEE, MMMM d yyyy - HH:mm"];
		remi.text = [dateFormatter stringFromDate: currentRem];
	}else{
		[schedule setEnabled: YES];
		[remove setEnabled: NO];
		remi.text = @"";
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

- (IBAction)cancelCurrent{
	NSDate *currentRem = [[[cvc.temp objectAtIndex: [index section]] objectAtIndex: [index row]] objectForKey:@"RemindDate"];
	NSString *currentTitle = [[[cvc.temp objectAtIndex: [index section]] objectAtIndex: [index row]] objectForKey:@"Name"];
	currentTitle = [NSString stringWithFormat: @"Reminder: %@", currentTitle];
	
	[[[cvc.temp objectAtIndex: [index section]] objectAtIndex: [index row]] removeObjectForKey:@"RemindDate"];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	[cvc.temp writeToFile: checklistName atomically: YES];
	
	NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
	BOOL didCancel = NO;
	for(int x = 0; x < [notifications count]; x++){
		if([[[notifications objectAtIndex: x] alertBody] isEqualToString: currentTitle] && !didCancel){
			[[UIApplication sharedApplication] cancelLocalNotification: [notifications objectAtIndex: x]];
			didCancel = YES;
		}
	}
	
	if(!didCancel){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not find a scheduled notification with reminder date equal to reminder date of this event. Cancelling all notifications." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[[UIApplication sharedApplication] cancelAllLocalNotifications];
	}else{
		NSLog(@"Successfully removed scheduled local notification");
	}
	
	
	[schedule setEnabled: YES];
	[remove setEnabled: NO];
	remi.text = @"";
}

- (IBAction)remindMe{
	RemindMeViewController *rmvc = [[RemindMeViewController alloc] initWithNibName:@"RemindMeViewController" bundle:nil];
	NSTimeInterval offset = (float)[[[[cvc.temp objectAtIndex: [index section]] objectAtIndex: [index row]] objectForKey: @"Offset"] intValue];
	NSDate *newDate = [NSDate dateWithTimeInterval:86400.0f * offset + 32400.0f sinceDate: [[NSUserDefaults standardUserDefaults] objectForKey: @"PromDate"]];
	// 86400.0f is the number of seconds in a day... 32400.0f is setting the hour to 9:00 AM (a default time for reminders)
	[rmvc setDate: newDate];
	[rmvc setCdvc: self];
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
