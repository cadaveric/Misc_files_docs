/* ivan - dec 15 2003
 *  
 * used a part of nagios plugin check_tcp
 *
 * it's now very shitty compared to the original check_tcp, but 
 * i stripped all the things i didn't need; but now, it compiles fine
 * and doesn't need the thousand things nagio needs
 *
 */



#include <stdio.h>
#include <stdlib.h>

#include <errno.h>
#include <string.h>  /* for bzero func */

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

/* that's for our alarm stuff */
#include <unistd.h>
#include <sys/time.h>
#include <signal.h>


#define STATE_OK       0
#define STATE_CRITICAL 1
#define STATE_UNKNOWN  2

#define FALSE 0
#define TRUE 1

/*#define DEBUG*/


int socket_timeout=3;


int
my_connect (char *host_name, int port, int *sd, char *proto)
{
  struct sockaddr_in servaddr;
  struct hostent *hp;
  struct protoent *ptrp;
  int result;

  bzero ((char *) &servaddr, sizeof (servaddr));
  servaddr.sin_family = AF_INET;
  servaddr.sin_port = htons (port);

  /* try to bypass using a DNS lookup if this is just an IP address */
  if (!inet_aton (host_name, &servaddr.sin_addr)) {

    /* else do a DNS lookup */
    hp = gethostbyname ((const char *) host_name);
    if (hp == NULL) {
      printf ("Invalid host name '%s'\n", host_name);
      return STATE_UNKNOWN;
    }
                
    memcpy (&servaddr.sin_addr, hp->h_addr, hp->h_length);
  }

  /* map transport protocol name to protocol number */
  if ((ptrp = getprotobyname (proto)) == NULL) {
    printf ("Cannot map \"%s\" to protocol number\n", proto);
    return STATE_UNKNOWN;
  }

  /* create a socket */
  *sd =
    socket (PF_INET, (!strcmp (proto, "udp")) ? SOCK_DGRAM : SOCK_STREAM,
	    ptrp->p_proto);
  if (*sd < 0) {
    printf ("Socket creation failed\n");
    return STATE_UNKNOWN;
  }

  /* open a connection */
  result = connect (*sd, (struct sockaddr *) &servaddr, sizeof (servaddr));
  if (result < 0) {
    switch (errno) {
    case ECONNREFUSED:
      printf ("Connection refused by host\n");
      break;
    case ETIMEDOUT:
      printf ("Timeout while attempting connection\n");
      break;
    case ENETUNREACH:
      printf ("Network is unreachable\n");
      break;
    default:
      printf ("Connection refused or timed out\n");
    }
                
    return STATE_CRITICAL;
  }

  return STATE_OK;
}



void socket_timeout_alarm_handler (int sig)
{

  printf ("Timeout after %d seconds\n", socket_timeout);

  exit (STATE_CRITICAL);
}



int
is_hostname (char *s1)
{
  if (strlen (s1) > 63)
    return FALSE;
  if (strcspn
      (s1,
       "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUWVXYZ0123456789-.") !=
      0) return FALSE;
  if (strspn (s1, "0123456789-.") == 1)
    return FALSE;
  while ((s1 = index (s1, '.'))) {
    s1++;
    if (strspn (s1, "0123456789-.") == 1) {
      printf ("%s\n", s1);
      return FALSE;
    }
  }
  return TRUE;
}




int
is_dotted_quad (char *address)
{
  int o1, o2, o3, o4;
  char c[1];

  if (sscanf (address, "%d.%d.%d.%d%c", &o1, &o2, &o3, &o4, c) != 4)
    return FALSE;
  else if (o1 > 255 || o2 > 255 || o3 > 255 || o4 > 255)
    return FALSE;
  else if (o1 < 0 || o2 < 0 || o3 < 0 || o4 < 0)
    return FALSE;
  else
    return TRUE;
}

int
is_host (char *address)
{
  if (is_dotted_quad (address) || is_hostname (address))
    return (TRUE);
  return (FALSE);
}






int main (int argc, char **argv)
{
  int result;
  char *status = "";
  struct timeval tv;

  int sd=0;

  int server_port = 23;
  char *server_address = NULL;

  int proto_udp=0;


  /* Usage: thisprog host port tcp/udp socket_timeout */
  /*  eg. thisprog 192.168.19.1 22 tcp 3 */
  if (argc != 5) {
    printf("Usage: %s host port tcp/udp socket_timeout\n",argv[0]);
    exit (STATE_CRITICAL);
  }
  server_address=argv[1];
  if ( is_host(server_address) == FALSE ) {
    printf("Invalid host: %s\n",server_address);
    exit (STATE_CRITICAL);
  }

  server_port=atoi(argv[2]);

  if (server_port == 0) {
    printf("Invalid numeric port: %s \n",argv[2]);
    exit (STATE_CRITICAL);
  }

  if (strstr (argv[3], "udp"))
    proto_udp=1;

  socket_timeout=atoi(argv[4]);

  if (socket_timeout == 0) {
    printf("Invalid numeric timeout: %s \n",argv[4]);
    exit (STATE_CRITICAL);
  }

	
#ifdef DEBUG
  printf("Using: host %s\n",server_address);
  printf("Using: port %d\n",server_port);
  if (proto_udp == 1 )
    printf("Using: proto udp\n");
  else
    printf("Using: proto tcp\n");
  printf("Using: socket timeout: %d\n",socket_timeout);
#endif

  /* initialize alarm signal handling */
  signal (SIGALRM, socket_timeout_alarm_handler);

  /* set socket timeout */
  alarm (socket_timeout);

  /* try to connect to the host at the given port number */
  gettimeofday (&tv, NULL);
  {
    if (proto_udp == 1)
      result = my_connect (server_address, server_port, &sd, "udp");
    else													/* default is TCP */
      result = my_connect (server_address, server_port, &sd, "tcp");
  }

  if (result == STATE_CRITICAL)
    return STATE_CRITICAL;


  /* close the connection */
  if (sd)
    close (sd);


  /* reset the alarm */
  alarm (0);

  if (status && strlen(status) > 0)
    printf (" [%s]", status);

  return result;

}
