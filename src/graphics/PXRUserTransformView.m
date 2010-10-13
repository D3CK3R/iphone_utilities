#import "PXRUserTransformView.h"


@implementation PXRUserTransformView
@synthesize selectedTransformView;
@synthesize autoSelect;

-(UIView*)selectedTransformView{
    return selectedTransformView;
}

-(void)setSelectedTransformView:(UIView*)view{
    if(selectedTransformView != view){
        [view retain];
        [selectedTransformView release];
        selectedTransformView = view;
    }
}

-(void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event{
	NSSet *allTouches = [event allTouches];
	UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
	if([allTouches count] == 1 && autoSelect){
		CGPoint loc = [touch1 locationInView: self];
		self.selectedTransformView = [self hitTest:loc withEvent:nil];
		if(self.selectedTransformView == self){
			self.selectedTransformView = nil;
		}
	}
}

-(void)touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event{
	//isMoving = true;
	NSSet * allTouches = [event allTouches];
	if([allTouches count] > 1) {
		UITouch * touch1 = [[allTouches allObjects] objectAtIndex:0];
		UITouch * touch2 = [[allTouches allObjects] objectAtIndex:1];
		CGPoint prev1 = [touch1 previousLocationInView: self];
		CGPoint prev2 = [touch2 previousLocationInView: self];
		CGPoint location1 = [touch1 locationInView: self];
		CGPoint location2 = [touch2 locationInView: self];
		//rotate and scale
		startScale = GetDistanceBetweenPoints(prev1, prev2);
		startRotation = GetAngleBetweenPoints(prev1, prev2);
		[self rotateAndScale:location1 andPoint:location2];
	}else{
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		CGPoint prev1 = [touch1 previousLocationInView: self];
		CGPoint location = [touch1 locationInView: self];
		CGPoint startPositionOffset = CGPointMake((location.x - prev1.x), (location.y - prev1.y));
		[self moveImage:startPositionOffset];
	}
}

-(void)moveImage:(CGPoint)pos{
	if(selectedTransformView == nil) return;
	selectedTransformView.center = CGPointMake(selectedTransformView.center.x + pos.x, selectedTransformView.center.y + pos.y);
}

-(void)rotateAndScale:(CGPoint)start andPoint:(CGPoint)end{
	if(selectedTransformView == nil) return;
	//new scale
	float newScale = GetDistanceBetweenPoints(start, end);
	float sizeDifference = (newScale / startScale);
	selectedTransformView.transform = CGAffineTransformScale(selectedTransformView.transform, sizeDifference, sizeDifference);
	startScale = newScale;
	//new rotation
	float newRotation = GetAngleBetweenPoints(start, end);
	float offset = newRotation - startRotation;
	selectedTransformView.transform = CGAffineTransformRotate(selectedTransformView.transform, DegreesToRadians(offset) );
	startRotation = newRotation;
}

-(void)dealloc {
	if(selectedTransformView != nil){
		[selectedTransformView release];
	}
    [super dealloc];
}


@end
