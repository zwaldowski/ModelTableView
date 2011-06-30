//
//  YXModelTableViewController.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXModelTableView.h"

@interface YXModelTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *sections;
@property (nonatomic, retain) NSArray *accessoryGroup;
@property (nonatomic, retain, readonly) UITableView *tableView;
@property (nonatomic, retain, readonly) NSIndexPath *lastSelectedIndexPath;

- (id)initWithStyle:(UITableViewStyle)style;
- (UITableView *)createTableView;

@end
