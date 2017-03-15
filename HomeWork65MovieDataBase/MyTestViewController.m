//
//  MyTestViewController.m
//  HomeWork65MovieDataBase
//
//  Created by Z on 16.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyTestViewController.h"

@interface MyTestViewController ()

@end

@implementation MyTestViewController
@synthesize tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
  //  [self.view ];
    self.tableView  = [[NSTableView  alloc] initWithFrame:NSMakeRect( 20, 50, 200, 200) ];
    
        NSDictionary    *genresDict1  = @{
                                         @"0id" : @"ganresName",
                                         @"0title" : @"Жанр",
                                         };
    
     [self  clearTableView];
     [self  createTableColumnsWithDictionary: genresDict1];
    //  selftableView.dataSource = self.MTVC;
    
    
    

    
    
    [self.view addSubview: self.tableView];
}



-(void)clearTableView
{
    NSArray     *arr   = self.tableView.tableColumns;
    for (NSInteger i = arr.count - 1   ;  i >= 0; i--)
    {
        [self.tableView removeTableColumn: [arr objectAtIndex: i]];
    }
}

-(void)createTableColumnsWithDictionary: (NSDictionary *) dict
{
    for (NSInteger i = 0; i < dict.count / 2; i++)
    {
        NSString   *keyId    =   [NSString stringWithFormat:@"%liid",i];
        NSString   *keyTitle    =   [NSString stringWithFormat:@"%lititle",i];
        
        NSString  *identifierTC = [dict[keyId] copy];
        NSString  *titleTC = [dict[keyTitle] copy];
        NSLog(@"identifier = %@ title = %@", identifierTC, titleTC);
        
        NSTableColumn   *TC   =   [[NSTableColumn  alloc] initWithIdentifier: identifierTC];
        TC.title    = titleTC;
        TC.headerCell.stringValue   = titleTC;
        TC.resizingMask  = NSTableColumnAutoresizingMask;
        //TC.width  = 200;
        [self.tableView  addTableColumn: TC];
        NSLog(@"%@", self.tableView.tableColumns);
    }
    NSLog(@"%@", self.tableView.tableColumns);
    [self.tableView  reloadData];
    self.tableView.needsDisplay = YES;
}



@end
