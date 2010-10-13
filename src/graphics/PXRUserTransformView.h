#import <UIKit/UIKit.h>
#import "angles.h"


@interface PXRUserTransformView : UIView {
	UIView *selectedTransformView;
	CGPoint startPosition;
	double startScale;
	double startRotation;
	bool autoSelect;
}

@property (nonatomic, retain) UIView *selectedTransformView;
@property (nonatomic, assign) bool autoSelect;

-(void)moveImage:(CGPoint)pos;
-(void)rotateAndScale:(CGPoint)start andPoint:(CGPoint)end;

@end
