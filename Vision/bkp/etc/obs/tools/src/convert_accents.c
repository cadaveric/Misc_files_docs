/* ivan - feb 17 05 */

/* bug/limit: 
 *
 *   - it seems that char 'ÿ' is taken as EOF ; thus, if this char is 
 *     encountered in a file that is piped, the prog will exit 
 */

#include "stdio.h"
#include "string.h"

/* if you see an empty string here, your terminal is not set the right way */
static char accents[]   = "¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüış";

/* this string is one char longer because of the escape of '"' */
static char converted[] = "!c#oY|S\"ca<--R-o+23'uP-,1o>123?AAAAAAACEEEEIIIIDNOOOOOXOUUUUYPBaaaaaaaceeeeiiiionooooo/ouuuuyp";


int main () 
{

  register char c;
  register int i, found;

  while ( (c=getchar()) != EOF )
     {
       i=0;
       while ( c != accents[i] && accents[i] != '\0' ) 
	 i++;
       accents[i] == '\0' ? printf("%c",c) : printf("%c",converted[i]);
     }

  return 0;

}
