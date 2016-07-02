//
//  PCDiseasesTableViewController.h
//  PregnantCare
//
//  Created by tarena on 16/6/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    kTableCellTypeDisease,
    kTableCellTypeQuestion
}cellType;

@interface PCDiseasesTableViewController : UITableViewController
-(instancetype)initWithUrlStr:(NSString *)urlStr andCellType:(cellType)type;
@end
