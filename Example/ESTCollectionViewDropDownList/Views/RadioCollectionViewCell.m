//
//  RadioCollectionViewCell.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "RadioCollectionViewCell.h"

#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface RadioCollectionViewCell ()
@property (nonatomic, strong) UIImageView *radioImage;
@property (nonatomic, strong) UIButton *radioPlayButton;
@property (nonatomic, strong) UILabel *radioNameLabel;
@end

@implementation RadioCollectionViewCell

- (void)setRadioEntity:(RadioEntity *)radioEntity {
    _radioEntity = radioEntity;
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.radioImage];
    [self.contentView addSubview:self.radioNameLabel];
    [self loadAlbumImagFadeInAnimationWithImageView:_radioImage ImageUrl:_radioEntity.cover];
    _radioNameLabel.text = _radioEntity.name;
    [self addAutoLayout];
}

- (UIImageView *)radioImage {
    if (!_radioImage) {
        _radioImage = [[UIImageView alloc] init];
        _radioImage.contentMode = UIViewContentModeScaleAspectFill;
        _radioImage.clipsToBounds = YES;
        [_radioImage addSubview:self.radioPlayButton];
    }
    return _radioImage;
}

- (UIButton *)radioPlayButton {
    if (!_radioPlayButton) {
        _radioPlayButton = [[UIButton alloc] init];
        [_radioPlayButton setImage:[UIImage imageNamed:@"Assets.bundle/play_icon"] forState:UIControlStateNormal];
    }
    return _radioPlayButton;
}

- (UILabel *)radioNameLabel {
    if (!_radioNameLabel) {
        _radioNameLabel = [[UILabel alloc] init];
        _radioNameLabel.font = [UIFont systemFontOfSize:15];
        _radioNameLabel.textColor = [UIColor colorWithWhite:0.463 alpha:1.000];
        _radioNameLabel.numberOfLines = 1;
    }
    return _radioNameLabel;
}

- (void)addAutoLayout {
    [_radioImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.equalTo(self);
        CGFloat albumImageWidth = (kScreenWidth - 15)/2;
        make.size.mas_equalTo(CGSizeMake(albumImageWidth, albumImageWidth));
    }];
    
    [_radioPlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_radioImage.mas_right).offset(-10);
        make.bottom.equalTo(_radioImage.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    [_radioNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.top.equalTo(_radioImage.mas_bottom).offset(0);
        make.bottom.offset(0);
    }];
}

- (void)loadAlbumImagFadeInAnimationWithImageView:(UIImageView *)imageView ImageUrl:(NSString *)cover {
    NSString *albumImageWidthString = [NSString stringWithFormat:@"%.f", kScreenWidth - 15];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView/1/w/%@/h/%@", cover, albumImageWidthString, albumImageWidthString]];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:URL.absoluteString];
    if (image) {
        imageView.image = image;
    } else {
        [imageView sd_setImageWithURL:URL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imageView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                imageView.alpha = 1;
            } completion:^(BOOL finished) {
                imageView.image = image;
            }];
        }];
    }
}

@end