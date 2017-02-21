//
//  DetailViewController.h
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-21.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

