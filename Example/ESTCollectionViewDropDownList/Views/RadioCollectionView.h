//
//  RadioCollectionView.h
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RadioCollectionViewDelegate <NSObject>
- (void)hideFileterViewIfNeeded;
@end

@interface RadioCollectionView : UICollectionView
@property (nonatomic, strong) NSArray *radioEntities;
@property (nonatomic, weak) id<RadioCollectionViewDelegate> radioCollectionDelegate;
@end
