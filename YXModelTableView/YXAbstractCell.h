//
//  YXAbstractCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXAbstractCell : NSObject {
}

@property (nonatomic, copy) NSString * reuseIdentifier;
@property (nonatomic, retain) id userInfo;
@property (nonatomic, retain) UIImage * image;
@property (nonatomic, readonly) CGFloat height;
@property (nonatomic) UITableViewCellStyle style;
@property (nonatomic) UITableViewCellAccessoryType editingAccessoryType;
@property (nonatomic, assign) BOOL editable;
@property (nonatomic, assign) id editTarget;
@property (nonatomic, assign) SEL editAction;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;

@end
