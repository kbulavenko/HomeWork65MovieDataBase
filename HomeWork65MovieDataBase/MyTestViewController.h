//
//  MyTestViewController.h
//  HomeWork65MovieDataBase
//
//  Created by  Z on 16.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyTestViewController : NSViewController
{
    //   NSTableView   *tableView1;
    NSTableView   *tableView;
    NSScrollView   *scroll;
    NSTableHeaderView     *THV;
   // NSView          *view;
    NSDictionary      *tableHeadersDict;
}
@property (strong) IBOutlet NSTableView *tableView;

//@property  NSView          *view;

/*
@property (weak) IBOutlet NSButton *btnAdd;

@property (weak) IBOutlet NSButton *btnDel;

@property (weak) IBOutlet NSButton *btnEdt;
*/
- (IBAction)btnClick:(id)sender;


-(void)clearTableView;

-(void)createTableColumnsWithDictionary: (NSDictionary *) dict;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andDictionary: (NSDictionary *) d;





@end
