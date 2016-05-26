//
//  SecondaryVideoTVCell.m
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/24/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import "SecondaryVideoTVCell.h"

@implementation SecondaryVideoTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)playFirstCellAction:(id)sender {
    if([self.PlaySecondDelegate respondsToSelector:@selector(didPlayFirstButtonClick:onCell:)])
        [self.PlaySecondDelegate didPlayFirstButtonClick:sender onCell:self];
}

- (IBAction)playSecondCellAction:(id)sender {
    if([self.PlaySecondDelegate respondsToSelector:@selector(didPlaySecondButtonClicked:onCell:)])
        [self.PlaySecondDelegate didPlaySecondButtonClicked:sender onCell:self];
}
@end
