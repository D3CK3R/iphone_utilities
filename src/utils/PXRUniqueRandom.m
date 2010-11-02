#import "PXRUniqueRandom.h"


@implementation PXRUniqueRandom

- (id)init{
	self = [super init];
	log = [[NSMutableArray alloc] init];
	[self setRangeWithMin:0 andMax:10];
	return self;
}

- (id)initWithMin:(int)mini andMax:(int)maxi{
	self = [super init];
	log = [[NSMutableArray alloc] init];
	[self setRangeWithMin:mini andMax:maxi];
	return self;
}

- (void)setRangeWithMin:(int)mini andMax:(int)maxi{
	min = mini;
	max = maxi;
	[self reset];
}

- (int)getUnique{
	if([log count] == 0){
		[self reset];
	}
	int count = [log count];
	int pos = arc4random() % count;
	NSNumber *number = [log objectAtIndex:pos];
	[log removeObjectAtIndex:pos];
	return [number intValue];
}

- (void)reset{
	[log removeAllObjects];
	NSNumber *number;
	for(int i=min; i<max; i++){
		number = [NSNumber numberWithInt:i];
		[log addObject:number]; 
	}
}

- (void)dealloc{
	[log removeAllObjects];
	[log release];
	[super dealloc];
}

@end
