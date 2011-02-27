//
//  TableViewCell.h
//  PromChecklist
//
//  Created by Billy Connolly on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistViewController;

@interface TableViewCell : UITableViewCell {
	UILabel *nameLabel;
	UILabel *remindLabel;
	UIImageView *checkBack;
	UIImageView *checkMark;
	UIImageView *checkHalf;
	
	ChecklistViewController *CVC;
	NSIndexPath *index;
	
	int checked;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *remindLabel;
@property (nonatomic, retain) UIImageView *checkBack;
@property (nonatomic, retain) UIImageView *checkMark;
@property (nonatomic, retain) UIImageView *checkHalf;

@property (nonatomic, retain) ChecklistViewController *CVC;
@property (nonatomic, retain) NSIndexPath *index;

- (void)setChecked:(int)check;
- (void)toggleChecked;
- (void)setName:(NSString *)name;
- (void)setDate:(NSDate *)date;

@end
