//
//  ChecklistViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"

@interface ChecklistViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	UITableView *tv;
	NSArray *temp;
}

@property (nonatomic, retain) IBOutlet UITableView *tv;
@property (nonatomic, retain) NSArray *temp;

- (void)didChangeProgressAtIndexPath:(NSIndexPath *)index newProg:(int)newProg;

- (IBAction)toggleEditing;
- (IBAction)addNewItem;

@end