//
//  DetailViewController.h
//  MasterDetailApplication
//
//  Created by Naoyoshi Aikawa on 5/18/13.
//  Copyright (c) 2013 Naoyoshi Aikawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
