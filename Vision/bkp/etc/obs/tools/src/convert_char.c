/* 
 * ivan - feb 26 2006 
 * 
 * a function to replace "special" characters
 *
 * default replacement char: dash '-'
 *
*/



#include "stdio.h"
#include "string.h"
#include <unistd.h>  /* getopt */

extern int optind;
extern char *optarg;

void usage() 
{
	fprintf(stderr, "Usage: convert_char [ -c char ] [ string [string2 [...] ] ]\n\n");

	fprintf(stderr, " -c char : replacement char (default: '-')\n\n");

	fprintf(stderr, "if no string is provided, read from stdin\n");
	fprintf(stderr, "(othwerise don't forget -- if string may begin with dashes)\n\n");

}




void replace_char(char c, char repl_char) {

	if ((c >= '0' && c <= '9') 
		|| (c >= 'A' && c <= 'Z') 
		|| (c >= 'a' && c <= 'z')
		|| c == '.'
		|| c == '-'
		|| c == repl_char
		|| c == '\n')

		printf ("%c", c);

	else

		printf ("%c", repl_char);

}


int main (int argc, char **argv) {

	register char c;
	register char repl_char = '-';

	int opt;	

	while ((opt = getopt(argc,argv,"hc:")) != -1) {

		switch(opt) {

			case 'h':
				usage();
				return 0;

			case 'c': 
				/* getopt should check for NULL string */
				repl_char = optarg[0];
				break;
			default:
				usage();
				return 1;
		}
	}

	/* does the user provide some args to convert, or is it from stdin ? */	
	if ( argc != optind ) {

		int i,j;

		for (i=optind; i<argc; i++) {

			if ( i != optind )
				printf(" ");

			j=0;
			while ( (c = argv[i][j++] ) != '\0' )
				replace_char (c, repl_char);

		}
	
	}
	else
		while ( (c = getchar ()) != EOF )
			replace_char (c, repl_char);


	printf ("\n");

	return 0;

}
