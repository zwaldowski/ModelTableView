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
@synthesize editingAccessoryType, editHandler;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text {
	return [self cellWithReuseIdentifier:reuseIdentifier text:text font:nil color:nil alignment:UITextAlignmentLeft];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text font:(UIFont *)font color:(UIColor *)color alignment:(UITextAlignment)align {
	YXStaticLabelCell * cell = [YXStaticLabelCell new];
    cell.reuseIdentifier = reuseIdentifier;
	cell.text = text;
    cell.font = (font) ? font : [UIFont boldSystemFontOfSize:17];
    cell.color = (color) ? color : [UIColor blackColor];
    cell.alignment = (align) ? align : UITextAlignmentLeft;
	return [cell autorelease];
}

- (void)dealloc {
    self.text = nil;
    self.font = nil;
    self.color = nil;
    self.editHandler = NULL;
    
    [super dealloc];
}

- (UITableViewCell *)tableViewCellWithReusableCell:(UITableViewCell *)reusableCell {
	UITableViewCell * cell = reusableCell;
    
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = self.text;
    cell.textLabel.font = self.font;
    cell.textLabel.textColor = self.color;
    cell.textLabel.textAlignment = self.alignment;
    if (self.image)
        cell.imageView.image = self.image;
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)height {
    return [self.text sizeWithFont:self.font].height + 10.0f;
}

@end
