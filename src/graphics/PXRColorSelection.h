#import <UIKit/UIKit.h>

@class PXRColorSelection;

@protocol PXRColorSelectionDelegate
- (void)colorSelection:(PXRColorSelection*)colorSelection didFinishPickingColor:(UIColor*)color;
@end

/**
 * A simple hsv touch view to sample a color.
 **/
@interface PXRColorSelection : UIView {
	NSObject <PXRColorSelectionDelegate> *delegate;
}

@property (nonatomic, retain) id delegate;

- (void)selectColorFromLocation:(CGPoint)location;

@end
