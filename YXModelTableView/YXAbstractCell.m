//
//  YXAbstractCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXAbstractCell.h"


@implementation YXAbstractCell

@synthesize reuseIdentifier, userInfo, image, height, style, editingAccessoryType, editable, editTarget, editAction;


#pragma mark -
#pragma mark Object lifecycle  

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier {
	if ((self = [super init])) {
		self.reuseIdentifier = aReuseIdentifier;
	}
	return self;
}

#pragma mark -
#pragma mark Public interface


- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell  {
	@throw @"abstract method";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editingAccessoryType == UITableViewCellAccessoryNone && tableView.editing && self.editTarget != nil && self.editAction != NULL && [self.editTarget respondsToSelector:self.editAction]) {
        [self.editTarget performSelector:self.editAction withObject:self];
    }}

- (void)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (self.editingAccessoryType != UITableViewCellAccessoryNone && tableView.editing && self.editTarget != nil && self.editAction != NULL && [self.editTarget respondsToSelector:self.editAction]) {
        [self.editTarget performSelector:self.editAction withObject:self];
    }
}

- (CGFloat)height {
    return 44.0f;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    self.reuseIdentifier = nil;
    self.userInfo = nil;
    self.image = nil;
	
	[super dealloc];
}

@end
