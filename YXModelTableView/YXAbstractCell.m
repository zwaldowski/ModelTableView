//
//  YXAbstractCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXAbstractCell.h"


@implementation YXAbstractCell

@synthesize reuseIdentifier, image;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier {
    YXAbstractCell *cell = [[self class] new];
    cell.reuseIdentifier = reuseIdentifier;
    return [cell autorelease];
}

#pragma mark -
#pragma mark Public interface

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell  {
	@throw @"abstract method";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing && [self conformsToProtocol:@protocol(YXModelCellSupportsEditing)]) {
        id <YXModelCellSupportsEditing> inst = (id <YXModelCellSupportsEditing>)self;
        if (inst.editingAccessoryType == UITableViewCellAccessoryNone && inst.editHandler)
            inst.editHandler(inst);
    }
}

- (void)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // nothing
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing && [self conformsToProtocol:@protocol(YXModelCellSupportsEditing)]) {
        id <YXModelCellSupportsEditing> inst = (id <YXModelCellSupportsEditing>)self;
        if (inst.editingAccessoryType != UITableViewCellAccessoryNone && inst.editHandler)
            inst.editHandler(inst);
    }
}

- (CGFloat)height {
    return 44.0f;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    self.reuseIdentifier = nil;
    self.image = nil;
	
	[super dealloc];
}

@end
