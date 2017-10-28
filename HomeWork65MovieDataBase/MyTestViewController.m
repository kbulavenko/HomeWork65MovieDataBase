//
//  MyTestViewController.m
//  HomeWork65MovieDataBase
//
//  Created by  Z on 16.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyTestViewController.h"

@interface MyTestViewController ()

@end

@implementation MyTestViewController
//@synthesize btnAdd,btnDel,btnEdt,tableView;
@synthesize tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self clearTableView];
  //  [self createTableColumnsWithDictionary: self->tableHeadersDict];

    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
//    NSLog(@"MyViewController viewDidLoad");
//    // NSRect     frameTV   =  self.tableView.frame;
//    NSRect frameTV   = NSMakeRect( 30, 30, 100, 100);
//    self->tableView   = [[NSTableView  alloc] initWithFrame: frameTV];
//    //self.view  = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, 400, 400)];
//    // self.tableView   =  [NSTableView new];
//    
//    NSTableColumn   *TC   =   [[NSTableColumn  alloc] initWithIdentifier: @"id_test"];
//    TC.title    = @"title_test";
//    TC.headerCell.stringValue   = @"header_test";
//    TC.resizingMask  = NSTableColumnAutoresizingMask;
//    //TC.width  = 200;
//    [self.tableView  addTableColumn: TC];
//    
   
    
//    NSLayoutConstraint    *LCtopTtopV   = [NSLayoutConstraint  constraintWithItem: self.tableView
//                                                                        attribute: NSLayoutAttributeTop
//                                                                        relatedBy: NSLayoutRelationEqual
//                                                                           toItem: self.view
//                                                                        attribute: NSLayoutAttributeTop
//                                                                       multiplier: 1
//                                                                         constant: 5];
//    
//    [self.view addConstraint: LCtopTtopV];
//
//    
//    NSLayoutConstraint    *LCleftTleftV   = [NSLayoutConstraint  constraintWithItem: self.tableView
//                                                                        attribute: NSLayoutAttributeLeft
//                                                                        relatedBy: NSLayoutRelationEqual
//                                                                           toItem: self.view
//                                                                        attribute: NSLayoutAttributeLeft
//                                                                       multiplier: 1
//                                                                         constant: 5];
//    
//    [self.view addConstraint: LCleftTleftV];
//
//    NSLayoutConstraint    *LCrightTrightV   = [NSLayoutConstraint  constraintWithItem: self.view
//                                                                          attribute: NSLayoutAttributeRight
//                                                                          relatedBy: NSLayoutRelationEqual
//                                                                             toItem: self.tableView
//                                                                          attribute: NSLayoutAttributeRight
//                                                                         multiplier: 1
//                                                                           constant: -5];
//    
//    [self.view addConstraint: LCrightTrightV];
    
    
//
    
    NSRect   frameT =  self.view.frame;
    self->scroll  = [[NSScrollView alloc] initWithFrame: frameT];
    self->scroll.hasVerticalScroller  = YES;
    self->scroll.hasHorizontalScroller  = YES;
    self->scroll.scrollerStyle   = NSScrollerStyleLegacy;
    
    //self->scroll.sty
    [self->scroll setDocumentView: self.tableView];
    
    
    [self.view addSubview: self->scroll];
    
    
//        NSLayoutConstraint    *LCtopTtopV   =
//    [NSLayoutConstraint
//                    constraintWithItem: self.view
//                    attribute: NSLayoutAttributeTop
//                    relatedBy: NSLayoutRelationEqual
//                    toItem: scroll
//                    attribute: NSLayoutAttributeTop
//                    multiplier: 1
//                    constant: 5];
//    
//        [self.view addConstraint: LCtopTtopV];
    
}



- (IBAction)btnClick:(id)sender {
}


-(void)clearTableView
{
  //  self->THV    = [[NSTableHeaderView alloc]  init];
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
        
        
        NSTextField  *TF  = [[NSTextField alloc]  initWithFrame: NSMakeRect(0, 0, 100, 30) ];
        TF.stringValue   = titleTC.copy;
        
      //  [self->THV addSubview: TF ];
      //  NSLog(@"self->THV = %@", self->THV);
        
        NSLog(@"!!!!!!!!!!!!!!   identifier = %@ title = %@", identifierTC, titleTC);
        
        NSTableColumn   *TC   = [NSTableColumn new];
        //[[NSTableColumn  alloc] initWithIdentifier: identifierTC];
        TC.title    = titleTC.copy;
        TC.identifier  =  identifierTC;
       // TC.headerCell.stringValue   = titleTC;
        TC.resizingMask  = NSTableColumnAutoresizingMask | NSTableColumnUserResizingMask;
        TC.width  = 100;
        NSLog(@"TC= %@", TC);
        [self.tableView  addTableColumn: TC];
        NSLog(@"TC= %@, self.tableView = %@", TC, self.tableView);
        
        NSLog(@"%@", self.tableView.tableColumns);
    }
 //   [self.tableView setHeaderView: self->THV];
    NSLog(@"%@", self.tableView.tableColumns);
//[self.tableView  reloadData];
 //   self.tableView.needsDisplay = YES;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andDictionary: (NSDictionary *) d
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self != nil)
    {
        
        self->tableHeadersDict   = d;
       // self->THV    = [[NSTableHeaderView alloc]  init];
              //  [self->THV  add];
        NSRect frameTV   = NSMakeRect( 30, 90, 440, 200);
//        frameTV   = self.view.frame;
//        NSLog(@"%g %g %g %g", frameTV.origin.x, frameTV.origin.y, frameTV.size.width, frameTV.size.height);
//        frameTV.origin.x        = 20.0;
//        frameTV.origin.y        = 20.0;
//        frameTV.size.width      -= 160.0;
//        frameTV.size.height     -= 160.0;
        NSLog(@"%g %g %g %g", frameTV.origin.x, frameTV.origin.y, frameTV.size.width, frameTV.size.height);

        self->tableView = [[NSTableView  alloc] initWithFrame: frameTV];
      //  [self->tableView setHeaderView: self->THV];
       // self->tableView.headerView
       // [self clearTableView];
        [self createTableColumnsWithDictionary: d];
    }
    
    
    return self;
}


@end
