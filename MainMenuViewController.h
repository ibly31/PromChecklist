//
//  MainMenuViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistViewController.h"


@interface MainMenuViewController : UIViewController {
	ChecklistViewController *cvc;
}

- (IBAction)viewChecklist;
- (IBAction)options;
- (IBAction)help;
- (IBAction)information;

@end
