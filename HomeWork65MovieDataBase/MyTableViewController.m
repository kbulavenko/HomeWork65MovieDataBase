//
//  MyTableViewController.m
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyTableViewController.h"

@implementation MyTableViewController
@synthesize films, genres, directors, myDB;

- (instancetype)initWithDB: (MyDB *) db1
{
    self = [super init];
    if (self)
    {
        self->myDB   = db1;
        //[[MyDB  alloc] initWithPath: p];
        if(self->myDB == nil)
        {
            NSLog(@"Ошибка доступа к базе данных");
            return nil;
        }
        else
        {
           /////////////////////////////////////////////////////////////// [self.myDB makeDB];
            //self->films  = [NSMutableArray array];
            self->films  = [self->myDB getFilms];
            
           // self->genres  = [NSMutableArray   array];
           // self->directors  = [NSMutableArray   array];
            self.genres  = [self.myDB getGenres];
            self.directors  = [self.myDB getDirectors];
            
          //  NSLog(@"self.genres  = %@", self.genres);
        }
    }
    return self;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
   // NSLog(@"numberOfRowsInTableView tableView (%@).identifier = %@",tableView, tableView.identifier);
    
    if([ tableView.identifier isEqualToString: @"TableViewIdFilms"])
    {
        return films.count;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdGenres"])
    {
        return genres.count;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdDirectors"])
    {
        return directors.count;
    }
    
    return  100;
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    
    //NSLog(@"objectValueForTableColumn  tableColumn.identifier = %@", tableColumn.identifier);
    if([ tableView.identifier isEqualToString: @"TableViewIdFilms"])
    {
        return [films objectAtIndex: row][tableColumn.identifier]  ;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdGenres"])
    {
      //  NSLog(@"[genres objectAtIndex: row = %li][tableColumn.identifier = %@] = %@", row,tableColumn.identifier,[genres objectAtIndex: row][tableColumn.identifier]);
        return [genres objectAtIndex: row][tableColumn.identifier]  ;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdDirectors"])
    {
        return [directors objectAtIndex: row][tableColumn.identifier]  ;

    }
    

       
    return	@"N/A";
}








@end
