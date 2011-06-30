//
//  YXKVOValueCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 6/29/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXKVCValueCell.h"

@implementation YXKVCValueCell

@synthesize title, object, key;
@synthesize editingAccessoryType, editHandler;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithReuseIdentifier:(NSString*)reuseIdentifier title:(NSString*)title  object:(id)object key:(NSString*)key {
	YXKVCValueCell *cell = [YXKVCValueCell new];
    cell.reuseIdentifier = reuseIdentifier;
	cell.title = title;
	cell.object = object;
	cell.key = key;
	
	return [cell autorelease];
}

- (void)dealloc {
    self.object = nil;
    self.key = nil;
    self.title = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Public interface 

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	UITableViewCell * cell = reusableCell;
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:self.reuseIdentifier] autorelease];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = self.title;
	cell.detailTextLabel.text = [[self.object valueForKey:self.key] description];
    if (self.image)
        cell.imageView.image = self.image;
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}


@end
