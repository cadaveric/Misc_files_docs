/* ivan - july 14 04 
 * 
 * a custom date function because the standard date binary doesn't fit my needs
 *                   
 */


#include <stdio.h>
#include <time.h>
#include <string.h>
#include <unistd.h>  /* getopt */
#include <stdlib.h>  /* atoi */

extern int optind;
extern char *optarg;

int verbose = 0;



void usage() 
{
    fprintf(stderr, "\nUsage: custom_date\n\n");

    fprintf(stderr, "  -v : verbose\n");
    fprintf(stderr, "  -h : help\n\n\n");


    fprintf(stderr, " INPUT :\n\n");

    fprintf(stderr, "  -p : set offset computation to positive (default: negative)\n\n");

    fprintf(stderr, "  -S seconds : seconds offset\n");
    fprintf(stderr, "  -M minutes : minutes offset\n");
    fprintf(stderr, "  -H hour:     hours offset\n\n");

    fprintf(stderr, "  -I YYYY-MM-DD : set the date to the specified day (must be in YYYY-MM-DD format)\n\n\n");


    fprintf(stderr, " OUTPUT (by default, standard date output):\n\n");

    fprintf(stderr, "  -i : output an iso YYYY-MM-DD date\n");
    fprintf(stderr, "  -d string format : user date/time format (see strftime)\n\n\n");


    fprintf(stderr, " Examples:\n\n");

    fprintf(stderr, " - Today's time, but for 1988-01-01 and minus 60 hours and 121 minutes:\n");
    fprintf(stderr, "    custom_date -I 1988-01-01 -H 500 -M 121\n\n");

    fprintf(stderr, " - The iso date of today minus 28800 seconds:\n");
    fprintf(stderr, "    custom_date -S 28800 -i\n\n");

    fprintf(stderr, " - Same as above, but with a defined user format:\n");
    fprintf(stderr, "    custom_date -S 28800 -d \"%%F\"\n\n");

    fprintf(stderr, " - Same as above, but with a defined user format:\n");
    fprintf(stderr, "    custom_date -S 28800 -d \"%%F\"\n\n");

    fprintf(stderr, " - 76 minutes *after* 1988-01-01 00:00:00 :\n");
    fprintf(stderr, "    custom_date -p -z -I 1988-01-01 -M 76\n\n");


}


/* fill some of a tm struct fields from an iso YYYY-MM-DD date */
int set_iso(struct tm *mytm, char * isostring) {

    int year;
    int month;
    int day;

    int i = 0;


    if (verbose) printf("isostring: %s\n", isostring);

    if ( !isostring )
	return 1;

    if ( strlen(isostring) != 10 )
	return 1;

    /* the string should only contain '-' and digits */
    for(i=0; i<10; i++)
	if ( isostring[i] != '-' && 
	     ( isostring[i] > '9' || isostring[i] < '0' ) ) 
	    return 1;

    /* then, the position of - and \0 is fixed */
    if ( isostring[4] != '-' || isostring[7] != '-' || isostring[10] != '\0' )
	return 1;


    isostring[4] = isostring[7] = '\0';

    year =  atoi(isostring);
    month = atoi(isostring + 5);
    day =   atoi(isostring + 8);

    if ( year < 1970 || year >= 2020 ) {
	if (verbose) fprintf(stderr, "invalid year\n");
	return 1;
    }

    if ( month <= 0 || month > 12 ) {
	if (verbose) fprintf(stderr, "invalid month\n");
	return 1;
    }

    if ( day <= 0 || day > 31 ) {
	if (verbose) fprintf(stderr, "invalid day\n");
	return 1;
    }
	
    if (verbose) 
	fprintf(stderr, "year: %d - month: %d - day: %d\n", year, month, day);

    mytm->tm_year = year - 1900 ;
    mytm->tm_mon  = month - 1 ;
    mytm->tm_mday = day ;

    return 0; 

}



int main(int argc, char **argv) {

    int opt;

    time_t now, new;
    struct tm mytm;

    char date_format[100];

    short custom_date = 0;
    short iso_date = 0;
    short zero_time = 0;
    short pos_offset = 0;

    int sec_offset = 0;
    int min_offset = 0;
    int hour_offset = 0;

    
    while ((opt = getopt(argc,argv,"S:M:H:I:zpid:vh")) != -1) {

        switch(opt) {

	    case 'S': 
		sec_offset = atoi(optarg);
		break;

	    case 'M': 
		min_offset = atoi(optarg);
		break;

	    case 'H': 
		hour_offset = atoi(optarg);
		break;

	    case 'I':
		iso_date = 1;
		break;

	    case 'z':
		zero_time = 1;
		break;

	    case 'p':
		pos_offset = 1;
		break;

	    case 'i':
		custom_date=1;
		strcpy(date_format, "%F");
		break;

	    case 'd':
		custom_date=1;
		strcpy(date_format, optarg);
		break;

	    case 'v':
		verbose = 1;
		break;

	    case 'h':
		usage();
		return 1;
		
           default:
	       usage();
	       return 1;
	}
    }



    time( &now ); /* get current time_t val */

    /* fill struct from current time */
    mytm = *localtime( &now ); 

    if (iso_date) 
	if ( set_iso(&mytm,argv[optind]) != 0 ) {
	    fprintf(stderr, "invalid iso string/date - must be in YYYY-MM-DD format\n");
	    return 1;
	}
   

    if (zero_time) {

	if (verbose) fprintf(stderr, "zeroing time\n");

	mytm.tm_sec = 0;
	mytm.tm_min = 0;
	mytm.tm_hour = 0;

    }


    /* add user defined offsets */
    if (verbose)
	fprintf(stderr, "Using %s offsets\n", pos_offset ? "positive" : "negative");

    if (sec_offset) {
	if (verbose) fprintf(stderr, "seconds offset is : %d\n", sec_offset);
	mytm.tm_sec += pos_offset ?  sec_offset : - sec_offset ;
    }

    if (min_offset) {
	if (verbose) fprintf(stderr, "minutes offset is : %d\n", min_offset);
	mytm.tm_min += pos_offset ?  min_offset : - min_offset ;
    }

    if (hour_offset) {
	if (verbose) fprintf(stderr, "hours offset is : %d\n", hour_offset);
	mytm.tm_hour += pos_offset ?  hour_offset : - hour_offset ;
    }





    new = mktime( &mytm );

    if ( custom_date == 0 )

	printf("%s", ctime(&new) );

    else {

	char string[100];

	strftime(string, sizeof string, date_format, localtime(&new));

	printf("%s\n", string );
    }

    return 0;

}
