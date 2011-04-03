//
//  InformationViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 3/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InformationViewController : UIViewController {
	UINavigationBar *bar;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *bar;

- (IBAction)back;

@end
