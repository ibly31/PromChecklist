//
//  ChecklistDetailedViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistViewController;

@interface ChecklistDetailedViewController : UIViewController {
	UILabel *name;
	UILabel *remi;
	UITextView *description;
	
	UIButton *schedule;
	UIButton *remove;
	
	NSString *nameString;
	NSString *descString;
	int segment;
	
	UISegmentedControl *progress;
	
	ChecklistViewController *cvc;
	NSIndexPath *index;
}

@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *remi;
@property (nonatomic, retain) IBOutlet UITextView *description;

@property (nonatomic, retain) IBOutlet UIButton *schedule;
@property (nonatomic, retain) IBOutlet UIButton *remove;

@property (nonatomic, retain) IBOutlet UISegmentedControl *progress;
@property (nonatomic, retain) ChecklistViewController *cvc;
@property (nonatomic, retain) NSIndexPath *index;

- (void)setName:(NSString *)checkName desc:(NSString *)checkDesc prog:(int)prog ind:(NSIndexPath *)ind;
- (IBAction)changedSegment;
- (IBAction)remindMe;

- (IBAction)cancelCurrent;

@end