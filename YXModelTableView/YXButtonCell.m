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
@synthesize editingAccessoryType, editHandler;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title handler:(YXSenderBlock)handler {
	YXButtonCell * cell = [YXButtonCell new];
    
    cell.reuseIdentifier = reuseIdentifier;
	cell.handler = handler;
	cell.title = title;
    
	return [cell autorelease];
}

- (void)dealloc {
    self.editHandler = NULL;
    self.handler = NULL;
    self.title = nil;
    
	[super dealloc];
}

#pragma mark -
#pragma mark Public interface

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	UITableViewCell *cell = reusableCell;
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];
    
	cell.textLabel.text = self.title;
	cell.textLabel.textAlignment = UITextAlignmentCenter;
	cell.textLabel.textColor = [UIColor colorWithRed:0.20f green:0.31f blue:0.52f alpha:1.0f];
    if (self.image)
        cell.imageView.image = self.image;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (!tableView.editing && self.handler)
		self.handler(self);
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
