//
//  AddNewViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddNewViewController.h"
#import "ChecklistViewController.h"
#import "AddNewDetailedViewController.h"

@implementation AddNewViewController
@synthesize tv;
@synthesize cvc;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"New Entry";
		UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
		[self.navigationItem setLeftBarButtonItem: cancel];
		[cancel release];
		
		UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(add)];
		[self.navigationItem setRightBarButtonItem: add];
		[add release];
	
	}
    return self;
}

- (IBAction)add{
	NSString *name = ((UITextField *)[[[[tv visibleCells] objectAtIndex: 0] contentView] viewWithTag: 31]).text;
	NSString *desc = ((UITextField *)[[[[tv visibleCells] objectAtIndex: 1] contentView] viewWithTag: 31]).text;
	NSString *sect = ((UILabel *)[[[tv visibleCells] objectAtIndex: 2] textLabel]).text;
	NSInteger section;
	NSInteger offset;
	if(![sect compare:@"3 Months Before Prom"]){
		section = 0;
		offset = -90;
	}else if(![sect compare:@"2 Months Before Prom"]){
		section = 1;
		offset = -60;
	}else if(![sect compare:@"1 Month Before Prom"]){
		section = 2;
		offset = -30;
	}else if(![sect compare:@"One Week Before Prom"]){
		section = 3;
		offset = -7;
	}else if(![sect compare:@"One Day Before Prom"]){
		section = 4;
		offset = -1;
	}else if(![sect compare:@"Day Of Prom"]){
		section = 5;
		offset = 0;
	}else{
		section = 0;
		offset = 0;
	}
	
	NSArray *objs = [NSArray arrayWithObjects: name, desc, [NSNumber numberWithInteger: offset], [NSNumber numberWithInt: 0], nil];
	NSArray *keys = [NSArray arrayWithObjects: @"Name", @"Description", @"Offset", @"Progress",nil];
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjects:objs forKeys:keys];
	
	[[cvc.temp objectAtIndex: section] insertObject: dict atIndex: 0];
	[dict release];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *checklistName = [documentsDirectory stringByAppendingPathComponent: @"Checklist.plist"];
	[cvc.temp writeToFile: checklistName atomically: YES];
	[cvc.tv reloadData];
	[self.parentViewController dismissModalViewControllerAnimated: YES];
}

- (IBAction)cancel{
	[self.parentViewController dismissModalViewControllerAnimated: YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier: CellIdentifier];
    }
	
	if([indexPath section] == 0){
		UITextField *tf = [[UITextField alloc] initWithFrame: CGRectMake(10.0f, 10.0f, 280.0f, 31.0f)];
		[tf setPlaceholder: @"Name"];
		[tf becomeFirstResponder];
		tf.tag = 31;
		[cell.contentView addSubview: tf];
	}else if([indexPath section] == 1){
		UITextField *tf = [[UITextField alloc] initWithFrame: CGRectMake(10.0f, 10.0f, 280.0f, 31.0f)];
		[tf setPlaceholder: @"Description"];
		tf.tag = 31;
		[cell.contentView addSubview: tf];
	}else if([indexPath section] == 2){
		cell.textLabel.text = @"3 Months Before Prom";
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	AddNewDetailedViewController *andvc = [[AddNewDetailedViewController alloc] initWithNibName:@"AddNewDetailedViewController" bundle:nil];
	[andvc setAnvc: self];
	[self.navigationController pushViewController: andvc animated: YES];
	[andvc release];
	[tv deselectRowAtIndexPath:indexPath animated:YES];
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
