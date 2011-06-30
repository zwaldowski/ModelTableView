//
//  YXEditableViewCell.m
//  YXModelTableViews
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXEditableViewCell.h"

@interface YXEditableViewCell()
@property (nonatomic, retain, readwrite) UITextField *textField;
@end

@implementation YXEditableViewCell

static const CGFloat kTextFieldMargin = 10.0f;

@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        UITextField *field = [UITextField new];
		field.font = [UIFont systemFontOfSize:17.0f];
		field.textColor = [UIColor blackColor];
		field.textAlignment = UITextAlignmentLeft;
        field.autocorrectionType = UITextAutocorrectionTypeNo;
		field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		[self addSubview:field];
        self.textField = field;
        [field release];
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.textField removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
}

- (void)layoutSubviews {
	[super layoutSubviews];
        
    CGFloat left = self.contentView.bounds.origin.x + kTextFieldMargin;
    
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
    } else {
        left += 30;
    }
    
    CGRect inset = CGRectMake(left, 0, self.contentView.bounds.size.width - left * 1.20, self.contentView.bounds.size.height);
    textField.frame = inset;
}

- (void)setPlaceholder:(NSString *)newPlaceholder {
	textField.placeholder = newPlaceholder;
}

- (NSString *)placeholder {
	return textField.placeholder;
}

- (void)dealloc {
    self.textField = nil;
    [super dealloc];
}


@end
