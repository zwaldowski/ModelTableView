//
//  YXModelTableViewController.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXModelTableViewController.h"

@interface YXModelTableViewController()
@property (nonatomic, readwrite, retain) UITableView *tableView;
@property (nonatomic, readwrite, retain) NSIndexPath *lastSelectedIndexPath;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@end

@implementation YXModelTableViewController

@synthesize sections, accessoryGroup, tableView,
            tableViewStyle, lastSelectedIndexPath;

#pragma mark NSObject

- (id)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.sections = [NSArray array];
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        self.sections = [NSArray array];
        self.tableViewStyle = style;
    }
    return self;
}

- (void)dealloc {
    self.tableView = nil;
    self.lastSelectedIndexPath = nil;
    self.sections = nil;
    self.accessoryGroup = nil;
    [super dealloc];
}

#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    UITableView *newTable = [self createTableView];
    newTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    newTable.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	newTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:newTable];
    self.tableView = newTable;
}

- (void)viewDidUnload {
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView flashScrollIndicators];
    [self performSelector:@selector(_deselectSelectedRow:) withObject:self.tableView afterDelay:0.5];    
    [super viewDidAppear:animated];
}

- (void)_deselectSelectedRow:(UITableView *)aTableView {
    NSIndexPath *indexPath = aTableView.indexPathForSelectedRow;
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Table view

- (UITableView *)createTableView {
    return [[[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle] autorelease];
}

- (void)setTableView:(UITableView *)aTableView {
    if ([aTableView isEqual:tableView])
        return;
    tableView.delegate = nil;
    tableView.dataSource = nil;
    [tableView release];
    tableView = [aTableView retain];
    tableView.delegate = self;
    tableView.dataSource = self;    
}

#pragma mark -
#pragma mark Table view data source


- (YXAbstractCell *)modelCellAtIndexPath:(NSIndexPath *)indexPath {
	YXSection *section = [self.sections objectAtIndex:indexPath.section];
	return [section cellAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.sections.count;
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
	YXSection *section = [self.sections objectAtIndex:sectionIndex];
	if (section.footerView)
		return CGRectGetHeight(section.footerView.frame);
    if (section.footer)
        return 32.0f;
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
	YXSection *section = [self.sections objectAtIndex:sectionIndex];
	if (section.headerView)
		return CGRectGetHeight(section.headerView.frame);
    if (section.header)
        return (self.tableViewStyle == UITableViewStylePlain) ? 24.0f : 32.0f;
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	YXAbstractCell *cell = [self modelCellAtIndexPath:indexPath];
	UITableViewCell *reusableCell = [aTableView dequeueReusableCellWithIdentifier:cell.reuseIdentifier];
	UITableViewCell *newCell = [cell tableViewCellWithReusableCell:reusableCell];

	if (reusableCell && newCell != reusableCell)
		NSLog(@"WARNING: reusable cell for id %@ was ignored", cell.reuseIdentifier);

	return newCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YXAbstractCell *cell = [self modelCellAtIndexPath:indexPath];
    CGFloat customHeight = 0.0f;
    if ([cell respondsToSelector:@selector(height)])
        customHeight = [cell height];
    return (customHeight > 44.0f) ? customHeight : 44.0f;
}


#pragma mark -
#pragma mark Table view delegate 

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.lastSelectedIndexPath = indexPath;
    
	YXAbstractCell * cell = [self modelCellAtIndexPath:indexPath];
	[cell tableView:aTableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)aTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	YXAbstractCell * cell = [self modelCellAtIndexPath:indexPath];
	[cell tableView:aTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

#pragma mark -
#pragma mark Keyboard management

- (void)keyboardChanged:(NSNotification *)notification up:(BOOL)up {
    // don't move if search display controller is active
    if (self.searchDisplayController.active)
        return;
    
    // if we are in a popover, don't change the size. popover manages this for us
    // http://stackoverflow.com/questions/4191840/determine-if-a-view-is-inside-of-a-popover-view
    // I *guess* this is appstore-safe, we'll see on the next submission
    UIView *v = self.view;
    for (;v.superview != nil; v=v.superview) {
        if (!strcmp(object_getClassName(v), "UIPopoverView"))
            return;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return;
    
    NSDictionary* userInfo = [notification userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve oldCurve;
    UIViewAnimationOptions newCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&oldCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    if (oldCurve == UIViewAnimationCurveEaseInOut)
        newCurve = UIViewAnimationOptionCurveEaseInOut;
    else if (oldCurve == UIViewAnimationCurveEaseIn)
        newCurve = UIViewAnimationOptionCurveEaseIn;
    else if (oldCurve == UIViewAnimationCurveEaseOut)
        newCurve = UIViewAnimationOptionCurveEaseOut;
    else
        newCurve = UIViewAnimationOptionCurveLinear;
        
    // Animate up or down
    [UIView animateWithDuration:animationDuration delay:0.0 options:newCurve animations:^(void) {
        CGRect newFrame = self.tableView.frame;
        CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
        
        newFrame.size.height -= keyboardFrame.size.height * (up? 1 : -1);
        self.tableView.frame = newFrame;
    } completion:NULL];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    [self keyboardChanged:notification up:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self keyboardChanged:notification up:NO];
}

@end

