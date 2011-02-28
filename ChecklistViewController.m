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
		[tv setAllowsSelectionDuringEditing: YES];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex: 0];
		NSString *checklistFileName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
		
		temp = [[NSArray alloc] initWithContentsOfFile: checklistFileName];
		
		UIBarButtonItem *startEditing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditing)];
		[self.navigationItem setRightBarButtonItem: startEditing];
		[startEditing release];
    }
    return self;
}

- (IBAction)toggleEditing{
	if(tv.editing == NO){
		[tv setEditing:YES animated:YES];
		
		UIBarButtonItem *stopEditing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleEditing)];
		[self.navigationItem setLeftBarButtonItem: stopEditing animated: YES];
		[stopEditing release];
		
		UIBarButtonItem *addNewButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
		[self.navigationItem setRightBarButtonItem: addNewButton animated: YES];
		[addNewButton release];
	}else{
		[tv setEditing:NO animated:YES];
		[self.navigationItem setLeftBarButtonItem: nil animated:YES];
		UIBarButtonItem *startEditing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditing)];
		[self.navigationItem setRightBarButtonItem: startEditing animated: YES];
		[startEditing release];
	}
}



- (IBAction)addNewItem{
	AddNewViewController *anvc = [[AddNewViewController alloc] initWithNibName:@"AddNewViewController" bundle:nil];
	[anvc setCvc: self];
	UINavigationController *popupNav = [[UINavigationController alloc] initWithRootViewController: anvc];
	[self presentModalViewController:popupNav animated:YES];
	[popupNav.navigationBar setTintColor: [UIColor colorWithRed:0.8f green:0.1f blue:0.1f alpha:1.0f]];
	[popupNav release];
	
	[anvc release];
}

- (void)viewWillAppear:(BOOL)animated{
	[tv reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[temp objectAtIndex: section] count];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [[NSArray arrayWithObjects: @"3 Months Before Prom", @"2 Months Before Prom", @"1 Month Before Prom", @"One Week Before Prom", @"1 Day Before Prom", @"Day Of Prom",nil] objectAtIndex: section];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
	NSDictionary *currentDict = [[temp objectAtIndex: [fromIndexPath section]] objectAtIndex: [fromIndexPath row]];
	[[temp objectAtIndex: [toIndexPath section]] insertObject:currentDict atIndex:[toIndexPath row]];
	[[temp objectAtIndex: [fromIndexPath section]] removeObjectAtIndex: [fromIndexPath row]];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	[temp writeToFile: checklistName atomically: YES];
	[tv reloadData];
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
