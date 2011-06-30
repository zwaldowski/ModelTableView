//
//  YXCheckmarkCell.m
//  YXModelTableViews
//
//  Created by Roman Busyghin on 5/17/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXCheckmarkCell.h"
#import "YXCheckmarkCellGroup.h"

@interface YXCheckmarkCell ()

- (UITableViewCellAccessoryType)accessoryTypeForBool:(BOOL)flag;
- (BOOL)boolForAccessoryType:(UITableViewCellAccessoryType)accessoryType;
- (BOOL)_allowsToChangeTo:(BOOL)newValue;

@property (nonatomic, retain) UITableViewCell *lastCreatedTableCell;
@property (nonatomic, copy) YXValueValidationBlock willChangeHandler;

@end

@implementation YXCheckmarkCell

@synthesize title, initialValueGetter, handler, willChangeHandler, lastCreatedTableCell;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title group:(YXCheckmarkCellGroup *)group {
	return [self cellWithReuseIdentifier:reuseIdentifier title:title group:group selected:NO];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title group:(YXCheckmarkCellGroup *)group selected:(BOOL)selected {
	YXCheckmarkCell * cell = [YXCheckmarkCell new];
    
    cell.reuseIdentifier = reuseIdentifier;
	cell.title = title;
	
	[group addCell:cell setSelected:selected];
	
	return [cell autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title initialValueGetter:(YXValueGetterBlock)initialValueGetter handler:(YXValueSenderBlock)handler {
	NSAssert(handler, @"");
    
    YXCheckmarkCell *cell = [self new];
    
    cell.reuseIdentifier = reuseIdentifier;
    cell.title = title;
    cell.initialValueGetter = initialValueGetter;
    cell.handler = handler;
    
    return [cell autorelease];
}

- (void)dealloc {
    self.title = nil;
    self.lastCreatedTableCell = nil;
    self.handler = NULL;
    self.initialValueGetter = NULL;
    self.willChangeHandler = NULL;
	
	[super dealloc];
}

#pragma mark Table view

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell*)reusableCell {
	UITableViewCell *cell = reusableCell;
    
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];
    self.lastCreatedTableCell = cell;
    
	cell.textLabel.text = self.title;
    if (self.image)
        cell.imageView.image = self.image;

	[self update];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	BOOL previousValue = [self boolForAccessoryType:cell.accessoryType];
	BOOL newValue = !previousValue;
	
	if ([self _allowsToChangeTo:newValue]) {	
		cell.accessoryType = [self accessoryTypeForBool:newValue];
        
        YXValueSenderBlock block = self.handler;
        if (block)
            block(self, [NSNumber numberWithBool:newValue]);
	}
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)update {
	if (!self.lastCreatedTableCell)
		return;
    
    NSNumber *boolNumber = [NSNumber numberWithBool:NO];
    YXValueGetterBlock block = self.initialValueGetter;
    if (block)
        boolNumber = block(self);
    
	self.lastCreatedTableCell.accessoryType = [self accessoryTypeForBool:[boolNumber boolValue]];
}

#pragma mark -
#pragma mark Private


- (UITableViewCellAccessoryType)accessoryTypeForBool:(BOOL)flag {
	if (flag)
		return UITableViewCellAccessoryCheckmark;
	else
		return UITableViewCellAccessoryNone;
}

- (BOOL)boolForAccessoryType:(UITableViewCellAccessoryType)accessoryType {
	return (accessoryType == UITableViewCellAccessoryCheckmark);
}

- (BOOL)_allowsToChangeTo:(BOOL)newValue {
    YXValueValidationBlock block = self.willChangeHandler;
    if (!block)
        return YES;
    
    return block(self, [NSNumber numberWithBool:newValue]);
}

@end
