//
//  MJTextViewTableRow.h
//  MJTableViewExample
//
//  Created by Dany on 13-2-1.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTableRow.h"

#define ADJUST_TOP_INSET    5

@interface MJTextViewTableRow : MJTableRow

+ (MJTextViewTableRow *)row;
+ (MJTextViewTableRow *)rowWithText:(NSString *)text stringValue:(NSString *)string;

@property(nonatomic) UITextAutocapitalizationType autocapitalizationType; // default is UITextAutocapitalizationTypeSentences
@property(nonatomic) UITextAutocorrectionType autocorrectionType;         // default is UITextAutocorrectionTypeDefault
@property(nonatomic) UITextSpellCheckingType spellCheckingType NS_AVAILABLE_IOS(5_0); // default is UITextSpellCheckingTypeDefault;
@property(nonatomic) UIKeyboardType keyboardType;                         // default is UIKeyboardTypeDefault
@property(nonatomic) UIKeyboardAppearance keyboardAppearance;             // default is UIKeyboardAppearanceDefault
@property(nonatomic) UIReturnKeyType returnKeyType;                       // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property(nonatomic) BOOL enablesReturnKeyAutomatically;                  // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property(nonatomic,getter=isSecureTextEntry) BOOL secureTextEntry;       // default is NO

@property (nonatomic, strong) NSString *stringValue;

@property (nonatomic, assign) BOOL editable;                // default is YES


@property (nonatomic, assign) BOOL dynamicAdjustRowHeightWhenShow;  // default is YES
@property (nonatomic, assign) BOOL dynamicAdjustRowHeightWhenEdit;  // default is NO
@property (nonatomic, assign) BOOL showTextViewBolderWhenEdit;      // default is NO
@property (nonatomic, assign) CGFloat textViewWidth;                // fixed textview width. default is 120.0f
@property (nonatomic, assign) CGFloat minRowHeight;
@property (nonatomic, assign) CGFloat maxRowHeight;

//@property (nonatomic, strong) NSString *placeHolder;

@property(nonatomic, copy) void (^onValueChanged)(NSString *newText);

@end
