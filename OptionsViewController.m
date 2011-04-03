//
//  OptionsViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OptionsViewController.h"
#import "ResetDateViewController.h"

@implementation OptionsViewController
@synthesize notificationNumber;
@synthesize temp;
@synthesize promDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(back)];
		[self.navigationItem setLeftBarButtonItem:done];
		self.title = @"Options";
    }
    return self;
}

- (void)viewDidLoad{
	float r = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeR"];
	float g = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeG"];
	float b = [[NSUserDefaults standardUserDefaults] floatForKey:@"ColorSchemeB"];
	UIColor	*colorScheme = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
	[self.navigationController.navigationBar setTintColor: colorScheme];
}

- (void)viewDidAppear:(BOOL)animated{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat: @"EEEE, MMMM d yyyy"];
	promDate.text = [dateFormatter stringFromDate: [[NSUserDefaults standardUserDefaults] objectForKey:@"PromDate"]];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistFileName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	self.temp = [[NSArray alloc] initWithContentsOfFile: checklistFileName];
	int notifications = 0;
	for(int x = 0; x < [temp count]; x++){
		for(int y = 0; y < [[temp objectAtIndex: x] count]; y++){
			if([[[temp objectAtIndex: x] objectAtIndex: y] objectForKey:@"RemindDate"] != nil){
				notifications++;
			}
		}
	}
	notificationNumber.text = [NSString stringWithFormat: @"%i Reminders", notifications];
}

- (IBAction)resetDate{
	ResetDateViewController *rdvc = [[ResetDateViewController alloc] initWithNibName:@"ResetDateViewController" bundle:nil];
	[self.navigationController pushViewController:rdvc animated:YES];
	[rdvc release];
}

- (IBAction)changeColorScheme:(id)sender{
	UIColor *color;
	switch(((UIButton *)sender).tag){
		case 0://Pink yes
			color = [UIColor colorWithRed:0.98f green:0.68f blue:0.74f alpha:1.0f];
			[[NSUserDefaults standardUserDefaults] setFloat:0.98f forKey:@"ColorSchemeR"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.68f forKey:@"ColorSchemeG"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.73f forKey:@"ColorSchemeB"];
			break;
		case 1://Blue no
			color = [UIColor colorWithRed:0.4f green:0.59f blue:1.00f alpha:1.0f];
			[[NSUserDefaults standardUserDefaults] setFloat:0.40f forKey:@"ColorSchemeR"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.59f forKey:@"ColorSchemeG"];
			[[NSUserDefaults standardUserDefaults] setFloat:1.00f forKey:@"ColorSchemeB"];
			break;
		case 2://Red yes
			color = [UIColor colorWithRed:0.96f green:0.15f blue:0.09f alpha:1.0f];
			[[NSUserDefaults standardUserDefaults] setFloat:0.96f forKey:@"ColorSchemeR"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.15f forKey:@"ColorSchemeG"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.09f forKey:@"ColorSchemeB"];
			break;
		case 3://Lavender
			color = [UIColor colorWithRed:0.61f green:0.48f blue:1.00f alpha:1.0f];
			[[NSUserDefaults standardUserDefaults] setFloat:0.61f forKey:@"ColorSchemeR"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.48f forKey:@"ColorSchemeG"];
			[[NSUserDefaults standardUserDefaults] setFloat:1.00f forKey:@"ColorSchemeB"];
			break;
		case 4://Hot Pink
			color = [UIColor colorWithRed:0.96f green:0.39f blue:0.67f alpha:1.0f];
			[[NSUserDefaults standardUserDefaults] setFloat:0.96f forKey:@"ColorSchemeR"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.39f forKey:@"ColorSchemeG"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.67f forKey:@"ColorSchemeB"];
			break;
		default://Red
			color = [UIColor colorWithRed:0.8f green:0.1f blue:0.1f alpha:1.0f];
			[[NSUserDefaults standardUserDefaults] setFloat:0.8f forKey:@"ColorSchemeR"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.1f forKey:@"ColorSchemeG"];
			[[NSUserDefaults standardUserDefaults] setFloat:0.1f forKey:@"ColorSchemeB"];
			break;
	}
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	[self.navigationController.navigationBar setTintColor: color];
}

- (IBAction)back{
	[self.navigationController dismissModalViewControllerAnimated: YES];
}

- (IBAction)clearAll{
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	for(int x = 0; x < [temp count]; x++){
		for(int y = 0; y < [[temp objectAtIndex: x] count]; y++){
			if([[[temp objectAtIndex: x] objectAtIndex: y] objectForKey:@"RemindDate"] != nil){
				[[[temp objectAtIndex: x] objectAtIndex: y] removeObjectForKey:@"RemindDate"];
			}
		}
	}
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	[temp writeToFile: checklistName atomically: YES];
	
	int notifications = 0;
	for(int x = 0; x < [temp count]; x++){
		for(int y = 0; y < [[temp objectAtIndex: x] count]; y++){
			if([[[temp objectAtIndex: x] objectAtIndex: y] objectForKey:@"RemindDate"] != nil){
				notifications++;
			}
		}
	}
	
	notificationNumber.text = [NSString stringWithFormat: @"%i Reminders", notifications];
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
