//
//  HelpViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController {
	UINavigationBar *bar;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *bar;

- (IBAction)back;

@end
