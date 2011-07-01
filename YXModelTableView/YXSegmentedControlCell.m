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

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithSegmentedControlItems:(NSArray *)items handler:(YXValueSenderBlock)handler initialValueGetter:(YXValueGetterBlock)initialValueGetter {
	YXSegmentedControlCell *cell = [YXSegmentedControlCell new];

	cell.segmentedControlItems = items;
	cell.handler = handler;
	cell.initialValueGetter = initialValueGetter;

	return [cell autorelease];
}

- (void)dealloc {
    self.segmentedControlItems = nil;
    self.initialValueGetter = NULL;
    self.handler = NULL;
    self.image = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark YXModelCell

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
        cell.segmentedControl.selectedSegmentIndex = [self.initialValueGetter(self) integerValue];
    
	return cell;
}

- (NSString *)reuseIdentifier {
    return @"YXSegmentedControlCell";
}

#pragma mark -
#pragma mark Private

- (void)_segmentedControlDidChangeValue:(UISegmentedControl *)segmentedControl {
    YXValueSenderBlock block = self.handler;
    if (block)
        block(self, [NSNumber numberWithInteger:segmentedControl.selectedSegmentIndex]);
}

@end
