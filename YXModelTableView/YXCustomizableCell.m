//
//  YXCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXCustomizableCell.h"

@implementation YXCustomizableCell

@synthesize deselectsAutomatically, buildingHandler, selectionHandler;
@synthesize editingAccessoryType, editHandler;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier buildingHandler:(YXCustomizableBuildingBlock)buildingHandler selectionHandler:(YXSenderBlock)selectionHandler {
    YXCustomizableCell *cell = [YXCustomizableCell new];
    
    cell.reuseIdentifier = reuseIdentifier;
    cell.buildingHandler = buildingHandler;
    cell.selectionHandler = selectionHandler;
    cell.deselectsAutomatically = YES;
    
    return [cell autorelease];
}

- (void)dealloc {
    self.buildingHandler = NULL;
    self.selectionHandler = NULL;
    self.editHandler = NULL;
}

#pragma mark -
#pragma mark Public interface

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
    YXCustomizableBuildingBlock block = self.buildingHandler;
    if (block)
        return block(self, reusableCell);
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.deselectsAutomatically)
		[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YXSenderBlock block = self.selectionHandler;
    if (!tableView.editing && block)
		block(self);
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end