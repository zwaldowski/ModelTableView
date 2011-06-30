//
//  YMSwitchCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXSwitchCell.h"

@implementation YXSwitchCell

@synthesize title, initialValueGetter, handler, togglesOnSelect;
@synthesize editingAccessoryType, editHandler;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title initialValueGetter:(YXValueGetterBlock)initialValueGetter handler:(YXValueSenderBlock)handler {
	YXSwitchCell *cell = [YXSwitchCell new];
    cell.reuseIdentifier = reuseIdentifier;
	cell.title = title;
	cell.initialValueGetter = initialValueGetter;
	cell.handler = handler;
    cell.togglesOnSelect = YES;
	return [cell autorelease];
}

- (void)dealloc {
    self.title = nil;
    self.initialValueGetter = NULL;
    self.handler = NULL;
    self.editHandler = NULL;
    
	[super dealloc];
}


#pragma mark -
#pragma mark Public interface


- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	UITableViewCell * cell = reusableCell;
	UISwitch *switchControl = nil;

	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];
		switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
		cell.accessoryView = switchControl;
		[switchControl release];
	} else {
		switchControl = (UISwitch *)[cell accessoryView];
	}

	[switchControl removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];

	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = self.title;
    if (self.image)
        cell.imageView.image = self.image;
    
    YXValueGetterBlock block = self.initialValueGetter;
    if (block)
        switchControl.on = [block(self) boolValue];

	[switchControl addTarget:self action:@selector(_switchControlChanged:) forControlEvents:UIControlEventValueChanged];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.editing && self.togglesOnSelect) {
        UITableViewCell *theCell = [tableView cellForRowAtIndexPath:indexPath];
        UISwitch *theSwitch = (UISwitch *)theCell.accessoryView;
        BOOL set = !theSwitch.on;
        [theSwitch setOn:set animated:YES];
        [self performSelector:@selector(switchControlChanged:) withObject:theSwitch];
	}
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)_switchControlChanged:(UISwitch *)switchControl {
    YXValueSenderBlock block = self.handler;
    if (block)
        block(self, [NSNumber numberWithBool:switchControl.on]);
}


@end
