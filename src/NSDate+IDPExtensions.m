//
//  NSDate+RSLAdditions.m
//  BudgetJar
//
//  Created by Oleksa Korin on 4/27/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import "NSDate+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

@implementation NSDate (IDPExtensions)

#pragma mark -
#pragma mark Date Components

- (NSDateComponents *)components:(NSUInteger)unitFlags {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	return [calendar components:unitFlags
					   fromDate:self];
}

- (NSInteger)year {
	NSUInteger flags = NSCalendarUnitYear;
	NSDateComponents *components = [self components:flags];
	
	return components.year;
}

- (NSInteger)month {
	NSUInteger flags = NSCalendarUnitMonth;
	NSDateComponents *components = [self components:flags];
	
	return components.month;
}

- (NSInteger)weekOfMonth {
	NSUInteger flags = NSCalendarUnitWeekOfMonth;
	NSDateComponents *components = [self components:flags];
	
	return components.weekOfMonth;
}

- (NSInteger)weekday {
	NSUInteger flags = NSCalendarUnitWeekday;
	NSDateComponents *components = [self components:flags];
	
	return components.weekday;
}

- (NSInteger)day {
	NSUInteger flags = NSCalendarUnitDay;
	NSDateComponents *components = [self components:flags];
	
	return components.day;
}

#pragma mark -
#pragma mark Beginning and End

- (NSDate *)beginningOfMonth {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [self components:NSCalendarUnitYear | NSCalendarUnitMonth];
	
	return [calendar dateFromComponents:components];
}

- (NSDate *)endOfMonth {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [NSDateComponents new];
	components.month = 1;
	
	NSDate *beginningOfNextMonth = [calendar dateByAddingComponents:components
															 toDate:[self beginningOfMonth]
															options:0];
	
	return [beginningOfNextMonth dateByAddingTimeInterval:-1];
}

- (NSDate *)beginningOfWeek {
	NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
	unitFlags |= NSCalendarUnitWeekday | NSCalendarUnitDay;
	NSDateComponents *components = [self components:unitFlags];
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSInteger offset = (self.weekday - calendar.firstWeekday + kIDPDaysInWeek) % kIDPDaysInWeek;
	components.day -= offset;
	
	return [calendar dateFromComponents:components];
}

- (NSDate *)endOfWeek {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [NSDateComponents new];
	components.weekOfMonth = 1;
	
	NSDate *beginningOfNextWeek = [calendar dateByAddingComponents:components
															toDate:[self beginningOfWeek]
														   options:0];
	
	return [beginningOfNextWeek dateByAddingTimeInterval:-1];
}

#pragma mark -
#pragma mark Time Intervals

+ (NSInteger)numberOfDaysInCurrentMonth {
	NSDate *today = [NSDate date]; //Get a date object for today's date
	return [self numberOfDaysInMonthForDate:today];
}

+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)date {
	NSCalendar *c = [NSCalendar currentCalendar];
	NSRange days = [c rangeOfUnit:NSDayCalendarUnit 
						   inUnit:NSMonthCalendarUnit 
						  forDate:date];
	
	return days.length;
}

+ (NSInteger)numberOfDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
	NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
											   fromDate:fromDate 
												 toDate:toDate 
												options:0];
	
    return [difference day];	
}

- (NSInteger)numberOfDaysToDate:(NSDate *)toDate {
	return [[self class] numberOfDaysFromDate:self toDate:toDate];
}

#pragma mark -
#pragma mark Day

+ (NSDate *)day:(NSInteger)day ofMonthForDate:(NSDate *)date {
	NSDateComponents *comps = [date components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];	
	
	comps.day = day;
	
	return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+ (NSDate *)dayOfCurrentMonth:(NSInteger)day {
	return [self day:day ofMonthForDate:[NSDate date]];
}

#pragma mark -
#pragma mark Midnight

+ (NSDate *)midnightDateForDate:(NSDate *)date {
	NSDateComponents *comps = [date components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];	
	
	return [[NSCalendar currentCalendar] dateFromComponents:comps];

}

- (NSDate *)midnightDate {
	return [[self class] midnightDateForDate:self];
}

#pragma mark -
#pragma mark Arithmetic

+ (NSDate *)dateByAddingDays:(NSInteger)days toDate:(NSDate *)date {
	NSDateComponents *comps = [NSDateComponents object];
	
	comps.day = days;
	
	return [[NSCalendar currentCalendar] dateByAddingComponents:comps 
														 toDate:date 
														options:0];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
	return [[self class] dateByAddingDays:days toDate:self];
}

#pragma mark -
#pragma mark Conversions

+ (NSDate *)dateFromString:(NSString *)dateString withStringFormat:(NSString *)stringFromat {
    NSDate *date = nil;
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSLocale *locate = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB_POSIX"] autorelease];
    
    [formatter setLocale:locate];
    [formatter setDateFormat:stringFromat];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Convert the RFC 3339 date time string to an NSDate.
    date = [formatter dateFromString:dateString];
    
    return date;
}

- (NSString *)dateToStringWithFormat:(NSString *)stringFromate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSLocale *locate = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB_POSIX"] autorelease];
    
    [formatter setLocale:locate];
    [formatter setDateFormat:stringFromate];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [formatter stringFromDate:self];
}

#pragma mark -
#pragma mark Month Name

- (NSString *)monthName {
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateFormat:@"MMMM"];
	
	return [dateFormatter stringFromDate:self];
}

- (NSString *)monthNameStandAlone {
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateFormat:@"LLLL"];
	
	return [dateFormatter stringFromDate:self];
}

@end
