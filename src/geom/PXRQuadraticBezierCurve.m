
#import "PXRQuadraticBezierCurve.h"


@implementation PXRQuadraticBezierCurve

@synthesize pointA;
@synthesize pointB;
@synthesize controlPoint;

-(id)init{
	self = [super init];
	pointA = CGPointMake(0, 0);
	controlPoint = CGPointMake(160, 200);
	pointB = CGPointMake(320, 0);
	return self;
}

-(CGPoint)positionAt:(double)time{
	double ip2 = 2 * (1-time);
	double x = pointA.x + time*(ip2*(controlPoint.x-pointA.x) + time*(pointB.x - pointA.x));
	double y = pointA.y + time*(ip2*(controlPoint.y-pointA.y) + time*(pointB.y - pointA.y));
	return CGPointMake(x, y);
}

-(double)rotationAt:(double)time withSensitivity:(double)sens{
	double offset = 0;
	CGPoint startPos;
	CGPoint nextPos;
	if(time < .5){
		startPos = [self positionAt:time];
		nextPos = [self positionAt:time + sens];
	}else{
		offset = -180;
		startPos = [self positionAt:time];
		nextPos = [self positionAt:time - sens];
	}
	return atan2((nextPos.y - startPos.y), (nextPos.x - startPos.x)) * 180/M_PI;
}

-(double)averageLengthWithSensitivity:(double)sens{
	int i;
	double distance = 0;
	for(i=0; i<sens-1; i++){
		CGPoint current = [self positionAt:((float)i/sens)];
		CGPoint next = [self positionAt:(((float)i+1)/sens)];
		distance += sqrt(pow((current.x-next.x), 2) + pow( (current.y-next.y), 2));			
	}
	return distance;
}

- (void)dealloc {
    [super dealloc];
}


@end
