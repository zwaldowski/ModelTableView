//
//  YXEditableViewCell.h
//  YXModelTableViews
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

@interface YXEditableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong, readonly) UITextField *textField;

@end
