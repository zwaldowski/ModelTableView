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
@property (nonatomic, assign) UITextField *textField;
@end

@implementation YXEditableCell

@synthesize placeholder, labelText, value, handler, textField;
@synthesize editingAccessoryType, editHandler;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier label:(NSString *)labelText placeholder:(NSString *)placeholder {
    return [self cellWithReuseIdentifier:reuseIdentifier label:labelText placeholder:placeholder value:nil handler:NULL];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier label:(NSString *)labelText placeholder:(NSString *)placeholder value:(NSString *)value {
    return [self cellWithReuseIdentifier:reuseIdentifier label:labelText placeholder:placeholder value:value handler:NULL];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier label:(NSString *)labelText placeholder:(NSString *)placeholder handler:(YXSenderBlock)handler {
    return [self cellWithReuseIdentifier:reuseIdentifier label:labelText placeholder:placeholder value:nil handler:handler];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier label:(NSString *)labelText placeholder:(NSString *)placeholder value:(NSString *)value handler:(YXSenderBlock)handler {
    YXEditableCell * cell = [YXEditableCell new];
    cell.reuseIdentifier = reuseIdentifier;
    cell.labelText = labelText;
    cell.placeholder = placeholder;
    cell.value = value;
    cell.handler = handler;
    return [cell autorelease];
}

- (void)dealloc {
	self.placeholder = nil;
    self.labelText = nil;
    self.value = nil;
    self.handler = nil;
    self.textField = nil;
    self.editHandler = NULL;
    
	[super dealloc];
}


- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	YXEditableViewCell * cell = (YXEditableViewCell *)reusableCell;

	if (!cell)
		cell = [[[YXEditableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];

    if (labelText) {
        cell.textLabel.text = self.labelText;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
	cell.placeholder = self.placeholder;
    if (self.value)
        cell.textField.text = value;
    
    [cell.textField addTarget:self action:@selector(didChangeEdit:) forControlEvents:UIControlEventEditingChanged];
    [cell.textField addTarget:self action:@selector(didEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    if (self.image)
        cell.imageView.image = self.image;
    
    self.textField = cell.textField;

	return cell;
}

- (void)didEndEditing:(UITextField *)aTextField {
    YXSenderBlock block = self.handler;
    if (block) block(self);
}

- (void)didChangeEdit:(UITextField *)aTextField {
    YXSenderBlock block = self.editHandler;
    if (block) block(self);
}

- (void)setValue:(NSString *)aValue {
    textField.text = aValue;
}

- (NSString *)value {
    return textField.text;
}

@end
