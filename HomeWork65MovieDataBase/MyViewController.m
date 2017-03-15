//
//  MyViewController.m
//  HomeWork65MovieDataBase
//
//  Created by Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController
@synthesize tableView, btnAdd, btnDel, btnEdt;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
//   NSRect     frameTV   =  self.tableView.frame;
//    self.tableView   = [[NSTableView  alloc] initWithFrame: frameTV];
}

- (IBAction)btnClick:(id)sender {
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