//
//  YXStaticLabelCell.m
//  YXModelTableViews
//
//  Created by Zachary Waldowski on 4/22/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import "YXStaticLabelCell.h"


@implementation YXStaticLabelCell

@synthesize text, font, color, alignment;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text {
	YXStaticLabelCell * cell = [[YXStaticLabelCell alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.text = text;
	return [cell autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text font:(UIFont *)font color:(UIColor *)color alignment:(UITextAlignment)align {
	YXStaticLabelCell * cell = [[YXStaticLabelCell alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.text = text;
    cell.font = font;
    cell.color = color;
    cell.alignment = align;
	return [cell autorelease];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithReuseIdentifier:reuseIdentifier])) {
        self.font = [UIFont boldSystemFontOfSize:17];
        self.color = [UIColor blackColor];
        self.alignment = UITextAlignmentLeft;
    }
    return self;
}

- (void)dealloc {
    self.text = nil;
    self.font = nil;
    self.color = nil;
    [super dealloc];
}

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	UITableViewCell * cell = reusableCell;
    
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];
	}
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = self.text;
    cell.textLabel.font = self.font;
    cell.textLabel.textColor = self.color;
    cell.textLabel.textAlignment = self.alignment;
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView.editing) {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)height {
    CGFloat customHeight = [self.text sizeWithFont:self.font].height + 10.0f;
    return (customHeight > 44.0f) ? customHeight : 44.0f;
}

@end
