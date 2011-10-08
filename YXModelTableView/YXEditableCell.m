//
//  YXEditableCell.m
//  YXModelTableViews
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXEditableCell.h"
#import "YXEditableViewCell.h"

@interface YXEditableCell ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation YXEditableCell

@synthesize placeholder, title, value, handler, textField;
@synthesize image, editingAccessoryType, editHandler;

#pragma mark - NSObject

+ (id)cellWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    return [self cellWithTitle:title placeholder:placeholder value:nil handler:NULL];
}

+ (id)cellWithTitle:(NSString *)title placeholder:(NSString *)placeholder value:(NSString *)value {
    return [self cellWithTitle:title placeholder:placeholder value:value handler:NULL];
}

+ (id)cellWithTitle:(NSString *)title placeholder:(NSString *)placeholder handler:(YXSenderBlock)handler {
    return [self cellWithTitle:title placeholder:placeholder value:nil handler:handler];
}

+ (id)cellWithTitle:(NSString *)title placeholder:(NSString *)placeholder value:(NSString *)value handler:(YXSenderBlock)handler {
    YXEditableCell * cell = [YXEditableCell new];
    
    cell.title = title;
    cell.placeholder = placeholder;
    cell.value = value;
    cell.handler = handler;
    
    return cell;
}

#pragma mark - YXModelCell

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	YXEditableViewCell * cell = (YXEditableViewCell *)reusableCell;

	if (!cell)
		cell = [[YXEditableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier];
    
    [cell.textField removeTarget:nil action:NULL forControlEvents:UIControlEventAllEditingEvents];

    if (self.title) {
        cell.textLabel.text = self.title;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.imageView.image = self.image;
    
	cell.placeholder = self.placeholder;
    if (self.value)
        cell.textField.text = value;
    
    [cell.textField addTarget:self action:@selector(didChangeEdit:) forControlEvents:UIControlEventEditingChanged];
    [cell.textField addTarget:self action:@selector(didEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.textField = cell.textField;

	return cell;
}

- (NSString *)reuseIdentifier {
    return @"YXEditableCell";
}

#pragma mark - Delegates

- (void)didEndEditing:(UITextField *)aTextField {
    YXSenderBlock block = self.handler;
    if (block) block(self);
}

- (void)didChangeEdit:(UITextField *)aTextField {
    YXSenderBlock block = self.editHandler;
    if (block) block(self);
}

#pragma mark - Properties

- (void)setValue:(NSString *)aValue {
    textField.text = aValue;
}

- (NSString *)value {
    return textField.text;
}

@end
