//
//  NSDate+RSLAdditions.h
//  BudgetJar
//
//  Created by Oleksa Korin on 4/27/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>

static 	const NSUInteger 	kIDPDaysInWeek 		=	7;
static  NSString *const 	IDPDateTimeFormat 	=   @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'";

@interface NSDate (IDPExtensions)

- (NSDateComponents *)components:(NSUInteger)unitFlags;

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)weekOfMonth;
- (NSInteger)weekday;
- (NSInteger)day;

- (NSDate *)beginningOfMonth;
- (NSDate *)endOfMonth;
- (NSDate *)beginningOfWeek;
- (NSDate *)endOfWeek;

+ (NSInteger)numberOfDaysInCurrentMonth;
+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)date;
+ (NSInteger)numberOfDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
- (NSInteger)numberOfDaysToDate:(NSDate *)toDate;

+ (NSDate *)day:(NSInteger)day ofMonthForDate:(NSDate *)date;
+ (NSDate *)dayOfCurrentMonth:(NSInteger)day;

+ (NSDate *)midnightDateForDate:(NSDate *)date;
- (NSDate *)midnightDate;

+ (NSDate *)dateByAddingDays:(NSInteger)days toDate:(NSDate *)date;
- (NSDate *)dateByAddingDays:(NSInteger)days;

+ (NSDate *)dateFromString:(NSString *)dateString withStringFormat:(NSString *)stringFromat;
- (NSString *)dateToStringWithFormat:(NSString *)stringFromate;

- (NSString *)monthName;
- (NSString *)monthNameStandAlone;

@end
