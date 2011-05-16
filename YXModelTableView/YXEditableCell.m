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

@property (nonatomic, copy, readwrite) NSString * placeholder;
@property (nonatomic, assign, readwrite) id target;
@property (nonatomic, assign, readwrite) SEL action;

@end

@implementation YXEditableCell

- (void)dealloc {
	[placeholder_ release];

	[super dealloc];
}

+ (id)cellWithReuseIdentifier:(NSString*)reuseIdentifier target:(id)target
					   action:(SEL)action placeholder:(NSString *)placeholder
{
	YXEditableCell * cell = [[YXEditableCell alloc] initWithReuseIdentifier:reuseIdentifier];

	cell.target = target;
	cell.action = action;
	cell.placeholder = placeholder;

	return [cell autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier target:(id)target
					   action:(SEL)action
                        label:(NSString *)labelText
				  placeholder:(NSString *)placeholder {
	YXEditableCell * cell = [[YXEditableCell alloc] initWithReuseIdentifier:reuseIdentifier];
    
	cell.target = target;
	cell.action = action;
	cell.placeholder = placeholder;
    cell.labelText = labelText;
    
	return [cell autorelease];
    
}

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	YXEditableViewCell * cell = nil;

	if (reusableCell == nil) {
		cell = [[[YXEditableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										  reuseIdentifier:self.reuseIdentifier] autorelease];
	}
	else {
		cell = (YXEditableViewCell *)reusableCell;
        [cell.textField removeTarget:nil action:@selector(_textDidEdit:) forControlEvents:UIControlEventEditingChanged];
	}

    if (labelText_) {
        cell.textLabel.text = labelText_;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell.textLabel.textColor = [UIColor blackColor];
    }
	cell.placeholder = self.placeholder;
	cell.target = self;
	cell.action = @selector(textDidChange:);
    [cell.textField addTarget:self action:@selector(_textDidEdit:) forControlEvents:UIControlEventEditingChanged];
    if (self.image)
        cell.imageView.image = self.image;

	return cell;
}

- (void)textDidChange:(UITextField *)textField {
	[self.target performSelector:self.action withObject:self withObject:textField];
}

- (void)_textDidEdit:(UITextField *)textField {
    if (self.editTarget != nil && self.editAction != NULL && [self.editTarget respondsToSelector:self.editAction])
        [self.editTarget performSelector:self.editAction withObject:textField];
}

@synthesize placeholder = placeholder_;
@synthesize target = target_;
@synthesize action = action_;
@synthesize labelText = labelText_;

@end
