//
//  SecondaryVideoTVCell.h
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/24/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondaryVideoTVCell;
@protocol SecondaryVideoTVCellDelegate <NSObject>

- (void)didPlayFirstButtonClick:(UIButton *)cell onCell:(SecondaryVideoTVCell *)customCell;
- (void)didPlaySecondButtonClicked:(UIButton *)cell onCell:(SecondaryVideoTVCell *)customCell;

@end
@interface SecondaryVideoTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbCell2Img;
@property (weak, nonatomic) IBOutlet UILabel *titelCell2;
@property (weak, nonatomic) IBOutlet UILabel *descriptionCell2;
@property (weak, nonatomic) IBOutlet UIImageView *thumbCell3Img;
@property (weak, nonatomic) IBOutlet UILabel *titelcell3;
@property (weak, nonatomic) IBOutlet UILabel *descriptionCell3;
@property (nonatomic, weak) id<SecondaryVideoTVCellDelegate>PlaySecondDelegate;

- (IBAction)playFirstCellAction:(id)sender;
- (IBAction)playSecondCellAction:(id)sender;

@end
