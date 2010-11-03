#import "PXRColorSelection.h"


@implementation PXRColorSelection
@synthesize delegate;

- (void)drawRect:(CGRect)rect{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGGradientRef rainbowGradient;
	CGGradientRef shadingGradient;
	CGColorSpaceRef colorspace;
	size_t num_locations = 7;
	float inc = 1.0/6.0;
	CGFloat locations[7];
	float pos = 0;
	for(int i=0; i<num_locations; i++){
		locations[i] = pos;
		pos += inc;
	}
	CGFloat components[28] = {1.0, 0.0, 0.0, 1.0,
							  1.0, 1.0, 0.0, 1.0,
							  0.0, 1.0, 0.0, 1.0,
							  0.0, 1.0, 1.0, 1.0,
							  0.0, 0.0, 1.0, 1.0,
							  1.0, 0.0, 1.0, 1.0,
							  1.0, 0.0, 0.0, 1.0 }; // End color
	colorspace = CGColorSpaceCreateDeviceRGB();
	rainbowGradient = CGGradientCreateWithColorComponents (colorspace, components, locations, num_locations);
	
	CGContextDrawLinearGradient(context, rainbowGradient, CGPointMake(0, 0), CGPointMake(self.frame.size.width, 0), kCGGradientDrawsAfterEndLocation);
	
	
	size_t black_num_locations = 4;
	CGFloat blackLocations[4] = {0.0, 0.5, 0.51, 1.0};
	CGFloat blackComponents[16] = {0.0, 0.0, 0.0, 1.0,
								   0.0, 0.0, 0.0, 0.0,
								   1.0, 1.0, 1.0, 0.0,
								   1.0, 1.0, 1.0, 1.0};
	shadingGradient = CGGradientCreateWithColorComponents(colorspace, blackComponents, blackLocations, black_num_locations);
	CGContextDrawLinearGradient(context, shadingGradient, CGPointMake(0, self.frame.size.height), CGPointMake(0, 0), kCGGradientDrawsAfterEndLocation);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	NSSet *viewTouches = [event touchesForView:self];
	UITouch *touch1 = [[viewTouches allObjects] objectAtIndex:0];
	CGPoint location = [touch1 locationInView:self];
	[self selectColorFromLocation:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	NSSet *viewTouches = [event touchesForView:self];
	UITouch *touch1 = [[viewTouches allObjects] objectAtIndex:0];
	CGPoint location = [touch1 locationInView:self];
	[self selectColorFromLocation:location];
}

- (void)selectColorFromLocation:(CGPoint)location{
	float h;
	float s;
	float v;
	h = location.x/self.frame.size.height;
	float yPos = location.y/self.frame.size.height;
	if(h <0 || h>1 || yPos<0 || yPos>1);
	if(yPos > .5){
		s = 1;
		v = (location.y - (self.frame.size.height/2))/(self.frame.size.height/2);
		v = 1-v;
	}else{
		s = ((self.frame.size.height/2) - location.y)/(self.frame.size.height/2);
		v = 1;
		s = 1-s;
	}
	UIColor *color = [UIColor colorWithHue:h saturation:s brightness:v alpha:1];
	[delegate colorSelection:self didFinishPickingColor:color];
}

- (void)dealloc {
	delegate = nil;
	[super dealloc];
}


@end
