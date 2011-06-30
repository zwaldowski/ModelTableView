//
//  YXAbstractCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//


typedef void(^YXSenderBlock)(id sender);
typedef void(^YXValueSenderBlock)(id sender, NSNumber *value);
typedef BOOL(^YXValueValidationBlock)(id sender, NSNumber *value);
typedef NSNumber *(^YXValueGetterBlock)(id sender);

@interface YXAbstractCell : NSObject

@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, copy) NSString *reuseIdentifier;

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@protocol YXModelCellSupportsEditing <NSObject>
@property (nonatomic) UITableViewCellAccessoryType editingAccessoryType;
@property (nonatomic, copy) YXSenderBlock editHandler;
@end