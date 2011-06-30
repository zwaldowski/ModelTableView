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

@synthesize segmentedControlItems, handler, initialValueGetter;

#pragma mark -
#pragma mark Object lifecycle


+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier segmentedControlItems:(NSArray *)items handler:(YXValueSenderBlock)handler initialValueGetter:(YXValueGetterBlock)initialValueGetter {
	YXSegmentedControlCell *cell = [YXSegmentedControlCell new];
    cell.reuseIdentifier = reuseIdentifier;
	cell.segmentedControlItems = items;
	cell.handler = handler;
	cell.initialValueGetter = initialValueGetter;

	return [cell autorelease];
}

- (void)dealloc {
    self.handler = nil;
    self.initialValueGetter = nil;
    self.segmentedControlItems = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public interface


- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	YXSegmentedControlViewCell * cell = (YXSegmentedControlViewCell *)reusableCell;
    if (![cell isKindOfClass:[YXSegmentedControlViewCell class]])
        cell = nil;
    
	if (cell)
        [cell setItems:self.segmentedControlItems];
    else
		cell = [[[YXSegmentedControlViewCell alloc] initWithSegmentedControlItems:self.segmentedControlItems reuseIdentifier:self.reuseIdentifier] autorelease];
        

    [cell.segmentedControl addTarget:self action:@selector(segmentedControlDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    if (self.initialValueGetter) {
        YXValueGetterBlock block = self.initialValueGetter;
        NSNumber *value = block(self);
        cell.segmentedControl.selectedSegmentIndex = [value integerValue];
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)segmentedControlDidChangeValue:(UISegmentedControl *)segmentedControl {
    YXValueSenderBlock block = self.handler;
    if (block)
        block(self, [NSNumber numberWithInteger:segmentedControl.selectedSegmentIndex]);
}

@end
