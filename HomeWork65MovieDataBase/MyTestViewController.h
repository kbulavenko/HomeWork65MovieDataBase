//
//  MyTestViewController.h
//  HomeWork65MovieDataBase
//
//  Created by Z on 16.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyTestViewController : NSViewController


@property  NSTableView   *tableView;

-(void)clearTableView;
-(void)createTableColumnsWithDictionary: (NSDictionary *) dict;


@end
