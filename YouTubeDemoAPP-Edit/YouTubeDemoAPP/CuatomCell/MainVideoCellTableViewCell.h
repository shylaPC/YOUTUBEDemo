//
//  MainVideoCellTableViewCell.h
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/24/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainVideoCellTableViewCell;
@protocol MainVideoCellTableViewCellDelegate <NSObject>
- (void)didPlayButtonClick:(UIButton *)cell onCell:(MainVideoCellTableViewCell *)customCell;
@end
@interface MainVideoCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descriptVd;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (nonatomic, weak) id<MainVideoCellTableViewCellDelegate>PlayMainDelegate;

- (IBAction)mainPlayButtonAction:(id)sender;

@end
