//
//  MyTableViewController.m
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyTableViewController.h"

@implementation MyTableViewController


- (instancetype)initWithDB: (MyDB *) db1
{
    self = [super init];
    if (self)
    {
        self->_myDB   = db1;
        //[[MyDB  alloc] initWithPath: p];
        if(self->_myDB == nil)
        {
            NSLog(@"Ошибка доступа к базе данных");
            return nil;
        }
        else
        {
           // [self->_myDB makeDB];
        }
    }
    return self;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return  10;
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    
       
    return	@"N/A";
}








@end
