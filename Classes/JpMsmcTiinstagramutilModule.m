/**
 * MARSHMALLOW MACHINE 2012
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "JpMsmcTiinstagramutilModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "FilesystemModule.h"

@implementation JpMsmcTiinstagramutilModule
@synthesize isInstalled;

- (BOOL)openInstagram:(NSString *)filePath withCaption:(NSString *)caption
{
    if(![self.isInstalled boolValue])
    {
        return NO;
    }
    
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    RELEASE_TO_NIL(interactionController);
    interactionController = [[UIDocumentInteractionController interactionControllerWithURL:fileURL] retain];
    interactionController.UTI = @"com.instagram.exclusivegram";
    interactionController.delegate = self;
    interactionController.annotation = [NSDictionary dictionaryWithObjectsAndKeys:
                                         caption, @"InstagramCaption", nil];
    
    UIView *view = [TiApp controller].view;
    BOOL present = [interactionController presentOpenInMenuFromRect:view.frame
                                                             inView:view
                                                           animated:YES];
    
    if (!present)
    {
        NSLog(@"[ERROR]Cannot open this type of the file.");
        return NO;
    }
    
    return YES;
}

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"4b68cd74-4fbf-49db-bf49-fc4df16cc241";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"jp.msmc.tiinstagramutil";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
    RELEASE_TO_NIL(interactionController);
    
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma mark -
#pragma mark UIDocumentInteractionControllerDelegate

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
        willBeginSendingToApplication:(NSString *)application
{
    NSLog(@"[DEBUG] start sending.");
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
           didEndSendingToApplication:(NSString *)application
{
    NSLog(@"[DEBUG] end sending.");
}

#pragma Public APIs

- (void)openPhoto:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    TiBlob *media = [args objectForKey:@"media"];
    ENSURE_TYPE(media, TiBlob);
    
    NSString *caption = [args objectForKey:@"caption"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *toPath;
    toPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    
    [fileManager createFileAtPath:toPath contents:[media data] attributes:nil];

    [self openInstagram:toPath withCaption:caption];
}

- (id)isInstalled
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    
    if (![[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        return NUMBOOL(NO);
    }
    
    return NUMBOOL(YES);
}

@end
