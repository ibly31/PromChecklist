//
//  AddNewViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddNewViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	UITextField *nameField;
	UITextField *descField;
	
	UIPickerView *sectionPicker;
	
	UIBarButtonItem *doneEdit;
}

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *descField;

@property (nonatomic, retain) IBOutlet UIPickerView *sectionPicker;

@property (nonatomic, retain) UIBarButtonItem *doneEdit;

- (IBAction)add;
- (IBAction)stopEdit;
- (IBAction)startEdit;

@end
