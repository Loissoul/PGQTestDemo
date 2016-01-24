//
//  YALSideMenuCell.h
//  YALMenuAnimation
//
//  Created by 魏帅 on 1/12/15.
//  Copyright (c) 2015 Lois_soul. All rights reserved.
//


@import UIKit;

#import "PGQContentMenuCell.h"

@interface ContextMenuCell : UITableViewCell <PGQContentMenuCell>

@property (strong, nonatomic) IBOutlet UIImageView *menuImageView;
@property (strong, nonatomic) IBOutlet UILabel *menuTitleLabel;

@end
