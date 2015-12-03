//
//  TagListCollectionViewCell.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "TagListCollectionViewCell.h"

@interface TagListCollectionViewCell ()
@property (nonatomic, strong) UILabel *tagLabel;
@end

@implementation TagListCollectionViewCell

- (void)setTagEntity:(TagEntity *)tagEntity {
    _tagEntity = tagEntity;
    [self addSubview:self.tagLabel];
    [self updateTagLabel];
}

- (void)updateTagLabel {
    _tagLabel.text = _tagEntity.tagName;
    [_tagLabel sizeToFit];
    
    CGRect labelFrame = _tagLabel.frame;
    labelFrame.size.height = ESTDropDownListTagHeight;
    _tagLabel.frame = labelFrame;
    
    _tagLabel.textColor = [UIColor colorWithRed:0.604 green:0.600 blue:0.600 alpha:1.000];
    if (_tagEntity.didSelected) {
        _tagLabel.textColor = BasicColor;
    }
}

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = [UIColor colorWithRed:0.604 green:0.600 blue:0.600 alpha:1.000];
        _tagLabel.font = [UIFont systemFontOfSize:ESTDropDownListTagFontSize];
    }
    return _tagLabel;
}

@end
