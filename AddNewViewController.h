//
//  AddNewViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistViewController;

@interface AddNewViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{	
	UITableView *tv;
	
	ChecklistViewController *cvc;
}

@property (nonatomic, retain) IBOutlet UITableView *tv;
@property (nonatomic, retain) ChecklistViewController *cvc;

- (IBAction)add;
- (IBAction)cancel;


@end
