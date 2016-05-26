//
//  MainVideoCellTableViewCell.m
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/24/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import "MainVideoCellTableViewCell.h"

@implementation MainVideoCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mainPlayButtonAction:(id)sender {
    
    if([self.PlayMainDelegate respondsToSelector:@selector(didPlayButtonClick:onCell:)])
        [self.PlayMainDelegate didPlayButtonClick:sender onCell:self];
}
@end
