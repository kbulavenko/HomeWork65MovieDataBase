//
//  MyOneRowView.h
//  HomeWork62ProductsDB
//
//  Created by Z on 09.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//static   NSString   *MyOneRowViewDataReadyAddNotification  = @"MyOneRowViewDataReadyAddNotification";
static   NSString   *MyOneRowViewDataReadyUpdateNotification  = @"MyOneRowViewDataReadyUpdateNotification";


@interface MyOneRowView : NSViewController
{
    //BOOL            isOperationEdit;
    
 //   NSDictionary    *editValues;
    
}


//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil operationType: (BOOL) ot  editValues: (NSDictionary *) ev;
@property (assign)              BOOL              isEditNotAdd;
@property (assign)              NSInteger         selectedId;
@property (strong)   NSDictionary      *readResult;

@property    NSString      *tableName;

@property (weak) IBOutlet NSTextField *filmName;

//@property (weak) IBOutlet NSTextField *filmGenre;

//@property (weak) IBOutlet NSTextField *filmDirector;

@property (weak) IBOutlet NSTextField *genre;

@property (weak) IBOutlet NSTextField *director;

@property (weak) IBOutlet NSComboBox *filmGenreCombo;

@property (weak) IBOutlet NSComboBox *filmDirectorCombo;

@property (weak) IBOutlet NSButton *btnOk;


@property (weak) IBOutlet NSButton *btnCancel;

- (IBAction)btnClick:(id)sender;




@end
