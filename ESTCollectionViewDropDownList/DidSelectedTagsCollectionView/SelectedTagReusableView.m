//
//  SelectedTagReusableView.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "SelectedTagReusableView.h"

@interface SelectedTagReusableView ()
@property (nonatomic, strong) UILabel *tagsTitleLabel;
@end

@implementation SelectedTagReusableView
- (void)setTagsTitle:(NSString *)tagsTitle {
    _tagsTitle = tagsTitle;
    [self addSubview:self.tagsTitleLabel];
    _tagsTitleLabel.text = _tagsTitle;
}

- (UILabel *)tagsTitleLabel {
    if (!_tagsTitleLabel) {
        _tagsTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _tagsTitleLabel.font = [UIFont systemFontOfSize:ESTDropDownListTagFontSize];
        _tagsTitleLabel.textColor = [UIColor colorWithRed:0.604 green:0.600 blue:0.600 alpha:1.000];
        _tagsTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tagsTitleLabel;
}
@end
