//
//  YXDisclosureCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXDisclosureCell.h"

@implementation YXDisclosureCell

@synthesize title, description, handler;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title {
    return [self cellWithReuseIdentifier:reuseIdentifier title:title description:nil handler:NULL];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title description:(NSString *)description {
    return [self cellWithReuseIdentifier:reuseIdentifier title:title description:description handler:NULL];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title handler:(YXSenderBlock)handler {
    return [self cellWithReuseIdentifier:reuseIdentifier title:title description:nil handler:handler];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title description:(NSString *)description handler:(YXSenderBlock)handler {
	YXDisclosureCell * cell = [YXDisclosureCell new];
    
    cell.reuseIdentifier = reuseIdentifier;
	cell.title = title;
	cell.description = description;
	cell.handler = handler;
    
	return [cell autorelease];
}

- (void)dealloc {
    self.title = nil;
    self.description = nil;
    self.handler = nil;
    
	[super dealloc];
}

#pragma mark -
#pragma mark Public interface

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	UITableViewCellStyle style = (self.description) ? UITableViewCellStyleValue1 : UITableViewCellStyleDefault;

	UITableViewCell * cell = reusableCell;
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:self.reuseIdentifier] autorelease];

	cell.textLabel.text = self.title;
	cell.detailTextLabel.text = self.description;
    if (self.image)
        cell.imageView.image = self.image;
    if (self.handler)
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!tableView.editing) {
        YXSenderBlock block = self.handler;
        if (block) block(self);
    }
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end