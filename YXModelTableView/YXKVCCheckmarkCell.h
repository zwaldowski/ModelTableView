//
//  YXKVOCheckmarkCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 6/30/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXCheckmarkCell.h"

@interface YXKVCCheckmarkCell : YXCheckmarkCell

@property (nonatomic, copy) YXSenderBlock updateAction;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, retain) id object;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title object:(id)object key:(NSString *)key;

@end
