//
//  ESTCollectionViewDropDownList.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "ESTCollectionViewDropDownList.h"
#import "TagListContainerView.h"
#import "TagEntity.h"

@interface ESTCollectionViewDropDownList () <TagListContainerViewDelegate>
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UIButton *recommendedButton;
@property (nonatomic, strong) UIButton *newestButton;
@property (nonatomic, strong) UIButton *hotsButton;
@property (nonatomic, strong) UIButton *filterButton;
@property (nonatomic, strong) UILabel *separatorLine;
@property (nonatomic, strong) TagListContainerView *tagListContainerView;
@property (nonatomic, assign) BOOL isOpenFilter;
@end

@implementation ESTCollectionViewDropDownList

# pragma mark - Initialize

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

# pragma mark - Basic setup

- (void)setTagsEntities:(NSArray *)tagsEntities {
    _tagsEntities = tagsEntities;
    self.tagListContainerView.tagsEntities = _tagsEntities;
    BOOL hasDidSelectedTags = YES;
    _tagsContainerHeight.offset = hasDidSelectedTags && !_isOpenFilter ? 0 : [self tagListContainerViewHeight];
    [self layoutIfNeeded];
}

- (void)setup {
    [self setupView];
    [self addSubview:self.topBarView];
    [self addSubview:self.separatorLine];
    [self addSubview:self.tagListContainerView];
    [self addSubview:self.didSelectedTagsView];
    [self addAutoLayout];
    [self makeButtonHaveSameUI:@[_recommendedButton, _newestButton, _hotsButton]];
    [self didTouchRecommendedAction:_recommendedButton];
}

- (void)setupView {
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
}

# pragma mark - Initial view

- (UIView *)topBarView {
    if (!_topBarView) {
        _topBarView = [[UIView alloc] initWithFrame:self.bounds];
        _topBarView.backgroundColor = [UIColor whiteColor];
        [_topBarView addSubview:self.recommendedButton];
        [_topBarView addSubview:self.newestButton];
        [_topBarView addSubview:self.hotsButton];
        [_topBarView addSubview:self.filterButton];
    }
    return _topBarView;
}

- (UIButton *)recommendedButton {
    if (!_recommendedButton) {
        _recommendedButton = [[UIButton alloc] init];
        [_recommendedButton setTitle:@"推荐" forState:UIControlStateNormal];
        [_recommendedButton addTarget:self action:@selector(didTouchRecommendedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addBottomLineWithView:_recommendedButton AtIndex:1];
    }
    return _recommendedButton;
}

- (UIButton *)newestButton {
    if (!_newestButton) {
        _newestButton = [[UIButton alloc] init];
        [_newestButton setTitle:@"最新" forState:UIControlStateNormal];
        [_newestButton addTarget:self action:@selector(didTouchNewestAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addBottomLineWithView:_recommendedButton AtIndex:2];
    }
    return _newestButton;
}

- (UIButton *)hotsButton {
    if (!_hotsButton) {
        _hotsButton = [[UIButton alloc] init];
        [_hotsButton setTitle:@"最热" forState:UIControlStateNormal];
        [_hotsButton addTarget:self action:@selector(didTouchHotsAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotsButton;
}

- (UIButton *)filterButton {
    if (!_filterButton) {
        _filterButton = [[UIButton alloc] init];
        [_filterButton setTitle:@"筛选 " forState:UIControlStateNormal];
        [_filterButton setBackgroundColor:BasicColor];
        [_filterButton setImage:[UIImage imageNamed:@"Assets.bundle/arrow_down"] forState:UIControlStateNormal];
        [_filterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _filterButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_filterButton addTarget:self action:@selector(didTouchFilterButton:) forControlEvents:UIControlEventTouchUpInside];
        CALayer *buttonLayer = _filterButton.layer;
        buttonLayer.cornerRadius = 2;
        buttonLayer.masksToBounds = YES;
        buttonLayer.borderWidth = 0.5;
        buttonLayer.borderColor = [UIColor colorWithWhite:0.886 alpha:1.000].CGColor;
        [self transformButtonTitleWithButton:_filterButton];
    }
    return _filterButton;
}

- (UILabel *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [[UILabel alloc] init];
        _separatorLine.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    }
    return _separatorLine;
}

- (TagListContainerView *)tagListContainerView {
    if (!_tagListContainerView) {
        _tagListContainerView = [[TagListContainerView alloc] init];
        _tagListContainerView.delegate = self;
    }
    return _tagListContainerView;
}

- (DidSelectedTagsCollectionView *)didSelectedTagsView {
    if (!_didSelectedTagsView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.headerReferenceSize = CGSizeMake(60, ESTDropDownListTagHeight);
        _didSelectedTagsView = [[DidSelectedTagsCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ESTDropDownListTagHeight) collectionViewLayout:layout];
    }
    return _didSelectedTagsView;
}

- (void)addBottomLineWithView:(UIView *)view AtIndex:(NSInteger)index {
    CALayer *verticalLine = [CALayer layer];
    verticalLine.frame = CGRectMake(ESTDropDownListButtonWidth * index, 8, 0.5, 14.0f);
    verticalLine.backgroundColor = [UIColor grayColor].CGColor;
    [view.layer addSublayer:verticalLine];
}

# pragma mark - Button target action

- (void)didTouchRecommendedAction:(UIButton *)sender {
    [self resetButtonsStateWithButton:sender];
    [self refreshRadioData:RadioDataTypeRecommended];
    NSLog(@"Did touch recommended button");
}

- (void)didTouchNewestAction:(UIButton *)sender {
    [self resetButtonsStateWithButton:sender];
    [self refreshRadioData:RadioDataTypeNewest];
    NSLog(@"Did touch newest button");
}

- (void)didTouchHotsAction:(UIButton *)sender {
    [self resetButtonsStateWithButton:sender];
    [self refreshRadioData:RadioDataTypeHots];
    NSLog(@"Did touch hots button");
}

- (void)refreshRadioData:(RadioDataType)radioDataType {
    if (_delegate && [_delegate respondsToSelector:@selector(refreshRadioWithRadioDataType:)]) {
        [_delegate refreshRadioWithRadioDataType:radioDataType];
    }
}

- (void)didTouchFilterButton:(UIButton *)sender {
    _isOpenFilter = !_isOpenFilter;
    _tagListContainerView.hidden = NO;
    _tagsContainerHeight.offset = [self tagListContainerViewHeight];
    if (_isOpenFilter) {
        [_filterButton setImage:[UIImage imageNamed:@"Assets.bundle/arrow_up"] forState:UIControlStateNormal];
    } else {
        [_filterButton setImage:[UIImage imageNamed:@"Assets.bundle/arrow_down"] forState:UIControlStateNormal];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(touchFilterButtonWithOpenState:)]) {
        [_delegate touchFilterButtonWithOpenState:_isOpenFilter];
    }
    
}

# pragma mark - Filter tags container delegate

- (void)didSelectedTags:(NSMutableArray *)tags {
    NSMutableArray *tagsId = [NSMutableArray new];
    for (TagEntity *tag in tags) {
        [tagsId addObject:tag.tagId];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(loadRadioByDidSelectedTagsId:)]) {
        [_delegate loadRadioByDidSelectedTagsId:tagsId];
    }
    _didSelectedTagsView.tags = tags;
}

# pragma mark - Univeral button method

- (void)makeButtonHaveSameUI:(NSArray *)buttons {
    for (UIButton *button in buttons) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button setTitleColor:[UIColor colorWithRed:0.604 green:0.600 blue:0.600 alpha:1.000] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
}

- (void)resetButtonsStateWithButton:(UIButton *)sender {
    [self makeButtonHaveSameUI:@[_recommendedButton, _newestButton, _hotsButton]];
    if ([sender isKindOfClass:[UIButton class]]) {
        [sender setTitleColor:BasicColor forState:UIControlStateNormal];
    }
}

- (void)transformButtonTitleWithButton:(UIButton *)button {
    button.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    button.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    button.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}

# pragma mark - Auto Layout

- (void)addAutoLayout {
    
    // Top bar view
    
    [_topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(ESTDropDownListTagHeight);
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
    [_recommendedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(ESTDropDownListButtonWidth);
    }];
    
    [_newestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recommendedButton.mas_right).offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(ESTDropDownListButtonWidth);
    }];
    
    [_hotsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_newestButton.mas_right).offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(ESTDropDownListButtonWidth);
    }];
    
    [_filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.centerY.equalTo(self.topBarView);
        make.size.mas_equalTo(CGSizeMake(57, 21));
    }];
    
    // Separator line
    
    [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.offset(0.5);
        make.top.equalTo(_topBarView.mas_bottom).offset(0);
    }];
    
    // Tag List Container View
    
    [_tagListContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_separatorLine.mas_bottom).offset(0);
        make.left.offset(0);
        make.right.offset(0);
        _tagsContainerHeight = make.height.offset(0);
    }];

    // Did selected tags view
    
    [_didSelectedTagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagListContainerView.mas_bottom).offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
}

- (CGFloat)tagListContainerViewHeight {
    return _tagsEntities.count * ESTDropDownListTagHeight;
}

@end
