//
//  OptionsViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OptionsViewController : UIViewController {
	UILabel *notificationNumber;
	UILabel *promDate;
	NSArray *temp;
}

@property (nonatomic, retain) IBOutlet UILabel *notificationNumber;
@property (nonatomic, retain) IBOutlet UILabel *promDate;
@property (nonatomic, retain) NSArray *temp;

- (IBAction)back;
- (IBAction)clearAll;
- (IBAction)changeColorScheme:(id)sender;
- (IBAction)resetDate;

@end