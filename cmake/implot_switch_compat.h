#pragma once

#if defined(__SWITCH__)

#include <time.h>

static inline long long mikupan_implot_floor_div(long long dividend, long long divisor) {
    long long quotient = dividend / divisor;
    long long remainder = dividend % divisor;
    if (remainder != 0 && ((remainder < 0) != (divisor < 0))) {
        --quotient;
    }
    return quotient;
}

static inline long long mikupan_implot_days_from_civil(long long year, unsigned month, unsigned day) {
    year -= month <= 2;
    const long long era = (year >= 0 ? year : year - 399) / 400;
    const unsigned year_of_era = static_cast<unsigned>(year - era * 400);
    const unsigned day_of_year = (153 * (month + (month > 2 ? -3 : 9)) + 2) / 5 + day - 1;
    const unsigned day_of_era = year_of_era * 365 + year_of_era / 4 - year_of_era / 100 + day_of_year;
    return era * 146097 + static_cast<long long>(day_of_era) - 719468;
}

static inline time_t mikupan_implot_timegm(struct tm *time_parts) {
    long long year = static_cast<long long>(time_parts->tm_year) + 1900;
    long long month = static_cast<long long>(time_parts->tm_mon);
    const long long month_quotient = mikupan_implot_floor_div(month, 12);
    year += month_quotient;
    month -= month_quotient * 12;

    const long long days = mikupan_implot_days_from_civil(year, static_cast<unsigned>(month) + 1U, 1U)
        + (static_cast<long long>(time_parts->tm_mday) - 1LL);
    const long long seconds = days * 86400LL
        + static_cast<long long>(time_parts->tm_hour) * 3600LL
        + static_cast<long long>(time_parts->tm_min) * 60LL
        + static_cast<long long>(time_parts->tm_sec);
    return static_cast<time_t>(seconds);
}

#ifndef timegm
#define timegm mikupan_implot_timegm
#endif

#endif