//
//  ChecklistViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistDetailedViewController.h"
#import "PromChecklistAppDelegate.h"
#import "AddNewViewController.h"

@implementation ChecklistViewController
@synthesize tv;
@synthesize temp;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
		self.title = @"Checklist";
		self.tv = [[UITableView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 416.0f)];
		[tv setDelegate: self];
		[tv setDataSource: self];
		[self.view addSubview: tv];
		[tv setRowHeight: 64.0f];
		[tv setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
		[tv setShowsVerticalScrollIndicator: NO];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex: 0];
		NSString *checklistFileName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
		
		temp = [[NSArray alloc] initWithContentsOfFile: checklistFileName];
		
		UIBarButtonItem *addNewButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
		[self.navigationItem setRightBarButtonItem: addNewButton];
		[addNewButton release];
    }
    return self;
}

- (IBAction)addNewItem{
	AddNewViewController *anvc = [[AddNewViewController alloc] initWithNibName:@"AddNewViewController" bundle:nil];
	PromChecklistAppDelegate *pcad = [[UIApplication sharedApplication] delegate];
	[pcad.navController pushViewController:anvc animated:YES];
	[anvc release];
}

- (void)viewWillAppear:(BOOL)animated{
	[tv reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[temp objectAtIndex: section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [[NSArray arrayWithObjects: @"3 Months Before Prom", @"2 Months Before Prom", @"1 Month Before Prom", @"One Week Before Prom", @"1 Day Before Prom", @"Day Of Prom",nil] objectAtIndex: section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[TableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier: CellIdentifier];
    }
	
	[cell setChecked: [[[[temp objectAtIndex: [indexPath section]] objectAtIndex: [indexPath row]] objectForKey: @"Progress"] intValue]];
	[cell setCVC: self];
	[cell setIndex: indexPath];
	[cell setDate: [[[temp objectAtIndex: [indexPath section]] objectAtIndex: [indexPath row]] objectForKey: @"RemindDate"]];
	[cell setName: [[[temp objectAtIndex: [indexPath section]] objectAtIndex: [indexPath row]] objectForKey: @"Name"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *name = [[[temp objectAtIndex: [indexPath section]] objectAtIndex: [indexPath row]] objectForKey: @"Name"];
	NSString *desc = [[[temp objectAtIndex: [indexPath section]] objectAtIndex: [indexPath row]] objectForKey: @"Description"];
	NSNumber *prog = [[[temp objectAtIndex: [indexPath section]] objectAtIndex: [indexPath row]] objectForKey: @"Progress"];
	
	ChecklistDetailedViewController *cdvc = [[ChecklistDetailedViewController alloc] initWithNibName:@"ChecklistDetailedViewController" bundle:nil];
	[cdvc setName:name desc:desc prog:[prog intValue] ind:indexPath];
	[cdvc setCvc: self];
	PromChecklistAppDelegate *pcad = [[UIApplication sharedApplication] delegate];
	[pcad.navController pushViewController: cdvc animated: YES];
	[cdvc release];
	[tableView deselectRowAtIndexPath:indexPath animated: YES];
}

- (void)didChangeProgressAtIndexPath:(NSIndexPath *)index newProg:(int)newProg{
	[[[temp objectAtIndex: [index section]] objectAtIndex: [index row]] setObject:[NSNumber numberWithInt: newProg] forKey:@"Progress"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	[temp writeToFile: checklistName atomically: YES];
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
