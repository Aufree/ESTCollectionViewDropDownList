//
//  DidSelectedTagsCell.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "DidSelectedTagsCell.h"

@interface DidSelectedTagsCell ()
@property (nonatomic, strong) UILabel *tagLabel;
@end

@implementation DidSelectedTagsCell

- (void)setTagString:(NSString *)tagString {
    _tagString = tagString;
    
    [self addSubview:self.tagLabel];
    _tagLabel.text = _tagString;
    [_tagLabel sizeToFit];
    
    CGRect labelFrame = _tagLabel.frame;
    labelFrame.size.height = ESTDropDownListTagHeight;
    _tagLabel.frame = labelFrame;
}

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = BasicColor;
        _tagLabel.font = [UIFont systemFontOfSize:ESTDropDownListTagFontSize];
    }
    return _tagLabel;
}

@end
