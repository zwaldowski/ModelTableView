//
//  YXSegmentedControlCell.m
//  YXModelTableViews
//
//  Created by Roman Busyghin on 6/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXSegmentedControlCell.h"
#import "YXSegmentedControlViewCell.h"

@implementation YXSegmentedControlCell

@synthesize image, segmentedControlItems, handler, initialValueGetter;

#pragma mark - Object lifecycle

+ (id)cellWithItems:(NSArray *)items initialValue:(YXNumberGetterBlock)getter handler:(YXNumberSenderBlock)handler {
    YXSegmentedControlCell *cell = [YXSegmentedControlCell new];
    
	cell.segmentedControlItems = items;
	cell.handler = handler;
	cell.initialValueGetter = getter;
    
	return [cell autorelease];
}

+ (id)cellWithItems:(NSArray *)items value:(NSUInteger)initialValue handler:(YXNumberSenderBlock)handler {
    return [self cellWithItems:items initialValue:^NSUInteger(id sender) {
        return initialValue;
    } handler:handler];
}

- (void)dealloc {
    self.segmentedControlItems = nil;
    self.initialValueGetter = NULL;
    self.handler = NULL;
    self.image = nil;
    
    [super dealloc];
}

#pragma mark - YXModelCell

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	YXSegmentedControlViewCell *cell = (YXSegmentedControlViewCell *)reusableCell;

	if (!cell)
        cell = [[[YXSegmentedControlViewCell alloc] initWithSegmentedControlItems:self.segmentedControlItems reuseIdentifier:self.reuseIdentifier] autorelease];
    else
		[cell setItems:self.segmentedControlItems];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;

    [cell.segmentedControl addTarget:self action:@selector(_segmentedControlDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    if (self.initialValueGetter)
        cell.segmentedControl.selectedSegmentIndex = self.initialValueGetter(self);
    
	return cell;
}

- (NSString *)reuseIdentifier {
    return @"YXSegmentedControlCell";
}

#pragma mark - Private

- (void)_segmentedControlDidChangeValue:(UISegmentedControl *)segmentedControl {
    YXNumberSenderBlock block = self.handler;
    if (block)
        block(self, segmentedControl.selectedSegmentIndex);
}

@end
