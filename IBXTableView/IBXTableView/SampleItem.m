//
//  SampleItem.m
//  IBXTableView
//
//  Created by 剑锋 屠 on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SampleItem.h"
#import "IBXTableViewCell.h"

@interface SampleItem () 
{
}

@end

@implementation SampleItem

+ (IBXTableViewCell *)allocTableViewCell
{
    IBXTableViewCell * cell = [[IBXTableViewCell alloc] init];
        
    UILabel * rightLabel = [[UILabel alloc] init];
    rightLabel.text = @"right";
    [rightLabel sizeToFit];
    cell.rightIndicator = rightLabel;
    [rightLabel release];
    
    UILabel * leftLabel = [[UILabel alloc] init];
    leftLabel.text = @"left";
    [leftLabel sizeToFit];
    cell.leftIndicator = leftLabel;
    [leftLabel release];
    
    return cell;
}

- (void)updateCell:(IBXTableViewCell *)cell
{
    cell.titleLabel.text = [self title];
    
    [cell addButton:[UIImage imageNamed:@"icon_edit.png"] title:@"edit" tag:100];
    [cell addButton:nil title:@"share" tag:101];
    [cell addRightButton:[UIImage imageNamed:@"icon_trash.png"] title:nil];
    
    [cell layoutSubviews];    
}


@end
