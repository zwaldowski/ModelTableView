//
//  YXDisclosureCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXAbstractCell.h"

@interface YXDisclosureCell : YXAbstractCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) YXSenderBlock handler;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title description:(NSString *)description;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title handler:(YXSenderBlock)handler;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title description:(NSString *)description handler:(YXSenderBlock)handler;

@end
