//
//  TableViewCell.m
//  PromChecklist
//
//  Created by Billy Connolly on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewCell.h"
#import "ChecklistViewController.h"

@implementation TableViewCell
@synthesize nameLabel;
@synthesize remindLabel;
@synthesize checkBack;
@synthesize checkMark;
@synthesize checkHalf;

@synthesize CVC;
@synthesize index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
		self.checkBack = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 25.0f, 19.0f, 19.0f)];
		UIImage *bk = [[UIImage alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Back" ofType:@"png"]];
		[checkBack setImage: bk];
		[bk release];
		[self.contentView addSubview: checkBack];
		
		self.checkHalf = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 25.0f, 19.0f, 19.0f)];
		UIImage *ch = [[UIImage alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"CheckHalf" ofType:@"png"]];
		[checkHalf setImage: ch];
		[ch release];
		[self.contentView addSubview: checkHalf];
		[checkHalf setHidden: YES];
		
		self.checkMark = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 25.0f, 19.0f, 19.0f)];
		UIImage *ck = [[UIImage alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Check" ofType:@"png"]];
		[checkMark setImage: ck];
		[ck release];
		[self.contentView addSubview: checkMark];
		[checkMark setHidden: YES];
		
		checked = 0;
		
		self.nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(40.0f, 20.0f, 240.0f, 20.0f)];
		//nameLabel.backgroundColor = [UIColor redColor];
		[self.contentView addSubview: nameLabel];
		[nameLabel setText: @""];
		
		self.remindLabel = [[UILabel alloc] initWithFrame: CGRectMake(40.0f, 40.0f, 240.0f, 20.0f)];
		//remindLabel.backgroundColor = [UIColor greenColor];
		remindLabel.font = [UIFont systemFontOfSize: 12.0f];
		remindLabel.textColor = [UIColor lightGrayColor];
		[self.contentView addSubview: remindLabel];
		[remindLabel setText: @""];
		
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setChecked:(int)check{
	checked = check;
	if(checked == 0){
		[checkMark setHidden: YES];
		[checkHalf setHidden: YES];
	}else if(checked == 1){
		[checkMark setHidden: YES];
		[checkHalf setHidden: NO];
	}else{
		[checkMark setHidden: NO];
		[checkHalf setHidden: YES];
	}
}

- (void)toggleChecked{
	if(checked == 0){
		checked = 1;
		[checkMark setHidden: YES];
		[checkHalf setHidden: NO];
	}else if(checked == 1){
		checked = 2;
		[checkMark setHidden: NO];
		[checkHalf setHidden: YES];
	}else if(checked == 2){
		checked = 0;
		[checkMark setHidden: YES];
		[checkHalf setHidden: YES];
	}
	[CVC didChangeProgressAtIndexPath:index newProg:checked];
}

- (void)setName:(NSString *)name{
	[nameLabel setText: name];
	[nameLabel setAdjustsFontSizeToFitWidth: YES];
	[nameLabel setLineBreakMode: UILineBreakModeWordWrap];
}

- (void)setDate:(NSDate *)date{
	if(date != nil){
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat: @"EEEE, MMMM d YYYY"];
		remindLabel.text = [dateFormatter stringFromDate: date];
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	CGPoint loc = [touch locationInView: self];
	if(CGRectContainsPoint(CGRectMake(5.0f, 20.0f, 29.0f, 29.0f), loc)){
		[self toggleChecked];
	}else{
		[super touchesBegan:touches withEvent:event];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {    
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [super dealloc];
}


@end