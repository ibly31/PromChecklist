//
//  ResetDateViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResetDateViewController : UIViewController {
	UIDatePicker *datePicker;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

- (IBAction)pickedDate;

@end
