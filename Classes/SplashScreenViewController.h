//
//  SplashScreenViewController.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PromChecklistAppDelegate;
@interface SplashScreenViewController : UIViewController {
	PromChecklistAppDelegate *pcad;
}

@property (nonatomic, retain) PromChecklistAppDelegate *pcad;

- (void)doneLoading;

@end