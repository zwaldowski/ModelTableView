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

- (UITableViewCellAccessoryType)_accessoryTypeForBool:(BOOL)flag;
- (BOOL)_boolForAccessoryType:(UITableViewCellAccessoryType)accessoryType;
- (BOOL)_allowsToChangeTo:(BOOL)newValue;

@property (nonatomic, retain) UITableViewCell *lastCreatedTableCell;
@property (nonatomic, copy) YXValidationBlock willChangeHandler;

@end

@implementation YXCheckmarkCell

@synthesize image, title, initialValueGetter, handler, willChangeHandler, lastCreatedTableCell;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithTitle:(NSString *)title group:(YXCheckmarkCellGroup *)group {
	return [self cellWithTitle:title group:group selected:NO];
}

+ (id)cellWithTitle:(NSString *)title group:(YXCheckmarkCellGroup *)group selected:(BOOL)selected {
	YXCheckmarkCell * cell = [YXCheckmarkCell new];
    
	cell.title = title;	
	[group addCell:cell setSelected:selected];
	
	return [cell autorelease];
}

+ (id)cellWithTitle:(NSString *)title initialValue:(YXBoolGetterBlock)getter handler:(YXBoolSenderBlock)handler {
    NSAssert(handler, @"");
    
    YXCheckmarkCell *cell = [self new];
    
    cell.title = title;
    cell.initialValueGetter = getter;
    cell.handler = handler;
    
    return [cell autorelease];
}

+ (id)cellWithTitle:(NSString *)title value:(BOOL)initialValue handler:(YXBoolSenderBlock)handler {
    return [self cellWithTitle:title initialValue:^BOOL(id sender) {
        return initialValue;
    } handler:handler];
}

- (void)dealloc {
    self.lastCreatedTableCell = nil;
    self.initialValueGetter = NULL;
    self.willChangeHandler = NULL;
    self.handler = NULL;
    self.title = nil;
    self.image = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark YXModelCell

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell*)reusableCell {
	UITableViewCell *cell = reusableCell;
    
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];
    self.lastCreatedTableCell = cell;
    
	cell.textLabel.text = self.title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
 	cell.textLabel.textAlignment = UITextAlignmentLeft;
	cell.textLabel.textColor = [UIColor blackColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    [self update];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	BOOL newValue = ![self _boolForAccessoryType:cell.accessoryType];
	
	if ([self _allowsToChangeTo:newValue]) {	
		cell.accessoryType = [self _accessoryTypeForBool:newValue];
        
        YXBoolSenderBlock block = self.handler;
        if (block)
            block(self, newValue);
	}
}

- (NSString *)reuseIdentifier {
    return @"YXCheckmarkCell";
}

#pragma mark -
#pragma mark Public

- (void)update {
	if (!self.lastCreatedTableCell)
		return;
    
    BOOL selected = NO;
    YXBoolGetterBlock block = self.initialValueGetter;
    if (block)
        selected = block(self);
    
	self.lastCreatedTableCell.accessoryType = [self _accessoryTypeForBool:selected];
}

#pragma mark -
#pragma mark Private


- (UITableViewCellAccessoryType)_accessoryTypeForBool:(BOOL)flag {
    return (flag) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (BOOL)_boolForAccessoryType:(UITableViewCellAccessoryType)accessoryType {
	return (accessoryType == UITableViewCellAccessoryCheckmark);
}

- (BOOL)_allowsToChangeTo:(BOOL)newValue {
    YXValidationBlock block = self.willChangeHandler;
    if (!block)
        return YES;
    
    return block(self, newValue);
}

@end
