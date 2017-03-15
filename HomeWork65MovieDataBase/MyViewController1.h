//
//  MyViewController.h
//  HomeWork65MovieDataBase
//
//  Created by Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyViewController1 : NSViewController
{
   // NSTableView   *tableView;
}
@property (weak) IBOutlet NSTableView *tableView;


@property (weak) IBOutlet NSButton *btnAdd;

@property (weak) IBOutlet NSButton *btnDel;

@property (weak) IBOutlet NSButton *btnEdt;

- (IBAction)btnClick:(id)sender;


-(void)clearTableView;

-(void)createTableColumnsWithDictionary: (NSDictionary *) dict;


@end
