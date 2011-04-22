//
//  YXModelTableViewController.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXModelTableViewController.h"

@implementation YXModelTableViewController

@synthesize sections, utilities;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
		sections = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark -
#pragma mark Table view data source


- (YXAbstractCell *)modelCellAtIndexPath:(NSIndexPath *)indexPath {
	YXSection * section = [self.sections objectAtIndex:indexPath.section];
	return [section cellAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
	YXSection * section = [self.sections objectAtIndex:sectionIndex];
	return [section cellCount];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)sectionIndex {
	YXSection * section = [self.sections objectAtIndex:sectionIndex];
	return section.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionIndex {
	YXSection * section = [self.sections objectAtIndex:sectionIndex];
	return section.header;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
	YXSection * section = [self.sections objectAtIndex:sectionIndex];
	return section.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex {
	YXSection * section = [self.sections objectAtIndex:sectionIndex];
	return section.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex {
	YXSection * section = [self.sections objectAtIndex:sectionIndex];
	if (section.footer == nil && section.footerView != nil) {
		return CGRectGetHeight(section.footerView.frame);
	}
	return -1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
	YXSection * section = [self.sections objectAtIndex:sectionIndex];
	if (section.header == nil && section.headerView != nil) {
		return CGRectGetHeight(section.headerView.frame);
	}
	return -1.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	YXAbstractCell * cell = [self modelCellAtIndexPath:indexPath];
	UITableViewCell * reusableCell = [tableView dequeueReusableCellWithIdentifier:cell.reuseIdentifier];
	UITableViewCell * newCell = [cell tableViewCellWithReusableCell:reusableCell];

	if (reusableCell != nil && newCell != reusableCell) {
		NSLog(@"WARNING: reusable cell for id %@ was ignored", cell.reuseIdentifier);
	}

	return newCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YXAbstractCell *cell = [self modelCellAtIndexPath:indexPath];
    CGFloat customHeight = 0.0f;
    if ([cell respondsToSelector:@selector(height)]) {
        customHeight = [cell height];
    }
    return (customHeight > 44.0f) ? customHeight : 44.0f;
}


#pragma mark -
#pragma mark Table view delegate 


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	YXAbstractCell * cell = [self modelCellAtIndexPath:indexPath];
	[cell tableView:tableView didSelectRowAtIndexPath:indexPath];
}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	YXCell * cell = [self modelCellAtIndexPath:indexPath];
//	[cell tableView:tableView willSelectRowAtIndexPath:indexPath];
//}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	YXAbstractCell * cell = [self modelCellAtIndexPath:indexPath];
	[cell tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}


#pragma mark -
#pragma mark Memory management


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	[sections release];
    self.utilities = nil;
    [super dealloc];
}


@end

