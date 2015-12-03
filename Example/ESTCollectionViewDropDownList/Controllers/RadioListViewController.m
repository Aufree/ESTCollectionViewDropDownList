//
//  RadioListViewController.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "RadioListViewController.h"
#import "ESTCollectionViewDropDownList.h"
#import "RadioCollectionView.h"
#import "RadioEntity.h"

#import "Masonry.h"

@interface RadioListViewController () <ESTCollectionViewDropDownListDelegate, RadioCollectionViewDelegate>
@property (nonatomic, strong) RadioCollectionView *radioCollectionView;
@property (nonatomic, strong) ESTCollectionViewDropDownList *radioHeaderView;
@property (nonatomic, strong) NSMutableArray *radioEntities;
@property (nonatomic, strong) MASConstraint *radioHeaderHeightConstraint;
@property (nonatomic, assign) RadioDataType radioDataType;
@property (nonatomic, copy) NSArray *tagList;
@property (nonatomic, strong) NSMutableArray *didSelectedTagsId;
@property (nonatomic, assign) BOOL filterViewIsOpen;
@end

@implementation RadioListViewController

# pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"电台";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.radioHeaderView = [[ESTCollectionViewDropDownList alloc] initWithFrame:self.view.bounds];
    self.radioHeaderView.delegate = self;
    [self.view addSubview:self.radioHeaderView];
    
    self.radioCollectionView = [[RadioCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self radioFlowLayout]];
    self.radioCollectionView.radioCollectionDelegate = self;
    [self.view addSubview:self.radioCollectionView];
    
    [self addAutoLayout];
    
    [self loadRadioData];
    [self loadTagListData];
}

# pragma mark - Load data

- (void)loadRadioData {
    NSDictionary *radioDict = [self dictionaryWithContentsOfJSONString:@"radio.json"];
    self.radioCollectionView.radioEntities = [RadioEntity arrayOfEntitiesFromArray:radioDict[@"data"]];;
    [self.radioCollectionView reloadData];
}

- (void)loadTagListData {
    NSDictionary *tagListDict = [self dictionaryWithContentsOfJSONString:@"tag_list.json"];
    NSArray *tagListData = tagListDict[@"data"];
    self.tagList = tagListData;
    self.radioHeaderView.tagsEntities = tagListData;
}

- (NSDictionary *)dictionaryWithContentsOfJSONString:(NSString *)fileLocation {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

# pragma mark - Radio FlowLayout

- (UICollectionViewFlowLayout *)radioFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (kScreenWidth - 15)/2;
    CGFloat itemFooterHeight = 32;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth + itemFooterHeight);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    return flowLayout;
}

# pragma mark - Radio header view delegate

- (void)refreshRadioWithRadioDataType:(RadioDataType)radioDataType {
    _radioDataType = radioDataType;
}

- (void)touchFilterButtonWithOpenState:(BOOL)isOpen {
    _filterViewIsOpen = isOpen;
    CGFloat headerHeight = [self headerHeight];
    if (!isOpen) {
        BOOL hasSelectedTag = _didSelectedTagsId.count > 0;
        headerHeight = hasSelectedTag ? ESTDropDownListTagHeight * 2 : ESTDropDownListTagHeight;
        _radioHeaderView.tagsContainerHeight.offset = hasSelectedTag ? 0 : _tagList.count * ESTDropDownListTagHeight;
    }
    
    [_radioHeaderView.didSelectedTagsView reloadData];
    
    __weak typeof(self) weakSelf = self;
    _radioHeaderHeightConstraint.offset = headerHeight;
    [UIView animateWithDuration:.3 animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}

- (void)hideFileterViewIfNeeded {
    if (_filterViewIsOpen) {
        [self.radioHeaderView didTouchFilterButton:nil];
    }
}

- (void)loadRadioByDidSelectedTagsId:(NSMutableArray *)tagsId {
    _didSelectedTagsId = tagsId;
    _radioHeaderHeightConstraint.offset = [self headerHeight];
    [self.view layoutIfNeeded];
}

- (CGFloat)headerHeight {
    CGFloat headerHeight = (_tagList.count + 1) * ESTDropDownListTagHeight;
    return headerHeight;
}

# pragma mark - AutoLayout

- (void)addAutoLayout {
    [_radioHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(5);
        make.right.offset(-5);
        _radioHeaderHeightConstraint = make.height.offset(ESTDropDownListTagHeight);
    }];
    
    [_radioCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_radioHeaderView.mas_bottom).offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
}

@end
