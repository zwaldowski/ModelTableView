//
//  YXModelTableViewController.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXModelTableView.h"

@interface YXModelTableViewController : UITableViewController {
}

@property (nonatomic, copy) NSArray *sections;
@property (nonatomic, copy) NSArray *utilities; // Work around having to retain a YXCheckmarkCellGroup


@end
