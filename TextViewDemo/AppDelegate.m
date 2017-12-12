//
//  AppDelegate.m
//  TextViewDemo
//
//  Created by Karthus on 2017/12/12.
//  Copyright © 2017年 karthus. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (weak) IBOutlet NSButton *btnLog;
@property (weak) IBOutlet NSButton *btnCopyAttachment;

@property(strong, nonatomic)NSTextAttachment *attachment;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [_textView setRichText:YES];
    [_textView setImportsGraphics:YES];
    [_textView setAllowsImageEditing:NO];
    _attachment = nil;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)clickBtnLog:(id)sender
{
    [_textView.textStorage enumerateAttributesInRange:NSMakeRange(0, [_textView.textStorage length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        NSAttributedString *atString = [_textView.textStorage attributedSubstringFromRange:range];
        NSRange attachRange = NSMakeRange(0, atString.length);
        NSTextAttachment *attachment = [atString attribute:NSAttachmentAttributeName atIndex:0 effectiveRange:&attachRange];
        
        if(attachment)
        {
            NSLog(@"%@", attachment);
            NSLog(@"%@", attachment.fileWrapper);
            _attachment = attachment;
        }
    }];
}

- (IBAction)clickBtnCopyAttachment:(id)sender
{
    if (_attachment)
    {
        NSString *homePath = NSHomeDirectory();
        NSString *documentPath = [homePath stringByAppendingString:@"/Documents/111.jpg"];
        NSURL *url = [NSURL fileURLWithPath:documentPath];
        NSError *error;
        BOOL bresult = [_attachment.fileWrapper writeToURL:url
                                                   options:NSFileWrapperWritingWithNameUpdating
                                       originalContentsURL:nil error:&error];
        NSLog(@"");
    }
}
@end
