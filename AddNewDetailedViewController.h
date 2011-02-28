//
//  AddNewDetailedViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddNewViewController;

@interface AddNewDetailedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	UITableView *tv;
	AddNewViewController *anvc;
}

@property (nonatomic, retain) IBOutlet UITableView *tv;
@property (nonatomic, retain) AddNewViewController *anvc;

@end
