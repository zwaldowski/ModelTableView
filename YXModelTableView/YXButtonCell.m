//
//  YXButtonCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXButtonCell.h"

@implementation YXButtonCell

@synthesize title, handler;
@synthesize image, editingAccessoryType, editHandler;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithTitle:(NSString *)title handler:(YXBlock)handler {
	YXButtonCell *cell = [YXButtonCell new];
    
	cell.handler = handler;
	cell.title = title;
    
	return [cell autorelease];
}

- (void)dealloc {
    self.editHandler = NULL;
    self.handler = NULL;
    self.title = nil;
    self.image = nil;
    
	[super dealloc];
}

#pragma mark -
#pragma mark YXModelCell

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	UITableViewCell *cell = reusableCell;
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];
    
	cell.textLabel.text = self.title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
	cell.textLabel.textAlignment = UITextAlignmentCenter;
	cell.textLabel.textColor = [UIColor colorWithRed:0.20f green:0.31f blue:0.52f alpha:1.0f];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YXBlock block = self.handler;
	if (block) block();
}

- (NSString *)reuseIdentifier {
    return @"YXButtonCell";
}

@end
