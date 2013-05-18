//
//  MasterViewController.h
//  MasterDetailApplication
//
//  Created by Naoyoshi Aikawa on 5/18/13.
//  Copyright (c) 2013 Naoyoshi Aikawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
