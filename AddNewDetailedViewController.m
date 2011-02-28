//
//  AddNewDetailedViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddNewDetailedViewController.h"
#import "AddNewViewController.h"

@implementation AddNewDetailedViewController
@synthesize tv;
@synthesize anvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [tv setAllowsSelection: NO];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier: CellIdentifier];
    }
	
	if([indexPath row] == 0){
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	
	cell.textLabel.text = [[NSArray arrayWithObjects: @"3 Months Before Prom", @"2 Months Before Prom", @"1 Month Before Prom", @"One Week Before Prom", @"One Day Before Prom", @"Day Of Prom", nil] objectAtIndex: [indexPath row]];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	for(int x = 0; x < [[tv visibleCells] count]; x++){
		((UITableViewCell *)[[tv visibleCells] objectAtIndex: x]).accessoryType = UITableViewCellAccessoryNone;
	}
	[tv cellForRowAtIndexPath: indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
	[tv deselectRowAtIndexPath:indexPath animated:YES];
	
	((UITableViewCell *)[[anvc.tv visibleCells] objectAtIndex: 2]).textLabel.text = [[NSArray arrayWithObjects: @"3 Months Before Prom", @"2 Months Before Prom", @"1 Month Before Prom", @"One Week Before Prom", @"One Day Before Prom", @"Day Of Prom", nil] objectAtIndex: [indexPath row]];
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
