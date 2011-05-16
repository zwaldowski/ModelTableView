//
//  YXEditableViewCell.m
//  YXModelTableViews
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXEditableViewCell.h"

@implementation YXEditableViewCell

static const CGFloat kTextFieldMargin = 10.0f;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        textField_ = [[UITextField alloc] initWithFrame:CGRectZero];
		textField_.delegate = self;
		textField_.font = [UIFont systemFontOfSize:17.0f];
		textField_.textColor = [UIColor blackColor];
		textField_.textAlignment = UITextAlignmentLeft;
		textField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;

		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[self addSubview:textField_];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
    CGFloat left = kTextFieldMargin;
    
    if (self.imageView.image) {
        left += self.imageView.image.size.width + 5;
    }
    
    if (self.textLabel.text) {
        left += 100 + kTextFieldMargin + kTextFieldMargin + 5;
        CGRect myRect = self.contentView.bounds;
        myRect.size.width = 100;
        myRect.size.height -= 1;
        myRect.origin.x = kTextFieldMargin;
        self.textLabel.frame = myRect;
    }
    
    CGRect inset = CGRectInset(self.contentView.bounds, left, 0);
    inset.origin.y += 1;
    textField_.frame = inset;
}

- (void)setPlaceholder:(NSString *)newPlaceholder {
	textField_.placeholder = newPlaceholder;
}

- (NSString *)placeholder {
	return textField_.placeholder;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self.target performSelector:self.action withObject:textField];
}

@synthesize textField = textField_;
@synthesize target = target_;
@synthesize action = action_;

- (void)dealloc {
    [textField_ resignFirstResponder];
	[textField_ release];

    [super dealloc];
}


@end
