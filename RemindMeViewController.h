//
//  RemindMeViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistDetailedViewController;

@interface RemindMeViewController : UIViewController{
	UIDatePicker *dpicker;
	NSDate *date;
	ChecklistDetailedViewController *cdvc;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *dpicker;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) ChecklistDetailedViewController *cdvc;

- (void)setDate:(NSDate *)newDate;
- (IBAction)changeDate;

@end