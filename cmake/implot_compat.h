#ifndef IMPLOT_COMPAT_H
#define IMPLOT_COMPAT_H

#include <time.h>
#include <stdlib.h>

static inline time_t portable_timegm(struct tm *tm) {
    time_t ret;
    char *tz;

   tz = getenv("TZ");
    setenv("TZ", "", 1);
    tzset();
    ret = mktime(tm);
    if (tz)
        setenv("TZ", tz, 1);
    else
        unsetenv("TZ");
    tzset();
    return ret;
}

#ifndef timegm
#define timegm portable_timegm
#endif

#endif /* IMPLOT_COMPAT_H */