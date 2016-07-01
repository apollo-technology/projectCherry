//
//  CollectionViewCell.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/18/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIView *cornerView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;

@end
