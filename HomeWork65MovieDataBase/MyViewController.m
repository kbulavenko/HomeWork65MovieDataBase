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
   
    NSLog(@"MyViewController viewDidLoad");
    [self.tableView sizeToFit];
}

- (void)dealloc
{
    self->MTVC = nil;
}

-(void)setMTVC : (MyTableViewController *) m   //  Установить указатель, иначе
{
    self->MTVC  = m;
}

- (IBAction)btnClick:(id)sender
{
    if(sender  == btnAdd)
    {
        NSTableView    *TV   = self.tableView;
        NSLog(@" Вносим данные в базу  и TableView : %@", TV);
        //TV.tableColumns.count
        
    }
    else if(sender  == btnDel)
    {
        NSTableView    *TV   = self.tableView;
        NSLog(@" Удаляем данные из базы  и TableView : %@", TV);
        if([TV  selectedRow] != -1)
        {
            [self->MTVC   deleteRow: TV.selectedRow];
            [self->tableView reloadData];
        }
        else
        {
            //NSAlert не выбрана строка
            NSLog(@"Не выбрана строка");
            NSAlert    *alert       = [NSAlert  new];
            alert.messageText       = @"Внимание!";
            alert.informativeText   = @"Не выбрана строка для удаления!";
            alert.alertStyle        = NSWarningAlertStyle;
            
            [alert runModal];
        }

        
        
        
    }
    else if(sender  == btnEdt)
    {
        NSTableView    *TV   = self.tableView;
        NSLog(@" Редактируем  данные в базе  и TableView : %@", TV);
        
    }
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
      //  NSLog(@"identifier = %@ title = %@", identifierTC, titleTC);
        
        NSTableColumn   *TC   =   [[NSTableColumn  alloc] initWithIdentifier: identifierTC];
        TC.title    = titleTC;
        TC.headerCell.stringValue   = titleTC;
        TC.resizingMask  = NSTableColumnAutoresizingMask | NSTableColumnUserResizingMask;
        TC.width  = 150;
        if([titleTC  isEqualToString:@"Название"])
        {
           TC.width  = 250;
        }
       // NSLog(@"TC= %@", TC);
        [self.tableView  addTableColumn: TC];
      //  NSLog(@"TC= %@, self.tableView = %@", TC, self.tableView);
        
      //  NSLog(@"%@", self.tableView.tableColumns);
    }
    // NSLog(@"%@", self.tableView.tableColumns);
    [self.tableView  reloadData];
    self.tableView.needsDisplay = YES;
}


//-(void)tableView:  (NSTableView *)    AddColumnWithIdentifier:


@end