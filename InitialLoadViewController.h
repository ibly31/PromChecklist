//
//  InitialLoadViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitialLoadViewController : UIViewController {
	UIDatePicker *datePicker;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

- (IBAction)pickedDate;

@end