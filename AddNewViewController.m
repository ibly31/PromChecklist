//
//  AddNewViewController.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddNewViewController.h"


@implementation AddNewViewController
@synthesize nameField;
@synthesize descField;

@synthesize sectionPicker;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"New Entry";
		doneEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(stopEdit)];
	}
    return self;
}

- (IBAction)startEdit{
	[self.navigationItem setRightBarButtonItem: doneEdit animated:YES];
}

- (IBAction)stopEdit{
	[nameField resignFirstResponder];
	[descField resignFirstResponder];
	[self.navigationItem setRightBarButtonItem: nil animated:YES];
}

- (IBAction)add{
	
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return 6;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [[NSArray arrayWithObjects: @"3 Months Before Prom", @"2 Months Before Prom", @"1 Month Before Prom", @"One Week Before Prom", @"1 Day Before Prom", @"Day Of Prom",nil] objectAtIndex: row];
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
