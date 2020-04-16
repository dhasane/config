
/*
 * for this daemon the following was used as the skeleton for the daemonization:
 * https://stackoverflow.com/questions/17954432/creating-a-daemon-in-linux/17955149#17955149
 * Fork this code: https://github.com/pasce/daemon-skeleton-linux-c
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/stat.h>
#include <string.h>
#include <stdbool.h>


#define _BAT "/sys/class/power_supply/BAT*"                 // battery
#define _status "/sys/class/power_supply/BAT*/status"       // status file
#define _now "/sys/class/power_supply/BAT*/energy_now"      // actual charge
#define _full "/sys/class/power_supply/BAT*/energy_full"    // full charge

#define stime 30        // interval of time in which the daemon will sleep
#define percentage 0.1  // percentage for the notification

static void skeleton_daemon()
{
    pid_t pid;

    /* Fork off the parent process */
    pid = fork();

    /* An error occurred */
    if (pid < 0)
        exit(EXIT_FAILURE);

    /* Success: Let the parent terminate */
    if (pid > 0)
        exit(EXIT_SUCCESS);

    /* On success: The child process becomes session leader */
    if (setsid() < 0)
        exit(EXIT_FAILURE);

    /* Catch, ignore and handle signals */
    //TODO: Implement a working signal handler */
    signal(SIGCHLD, SIG_IGN);
    signal(SIGHUP, SIG_IGN);

    /* Fork off for the second time*/
    pid = fork();

    /* An error occurred */
    if (pid < 0)
        exit(EXIT_FAILURE);

    /* Success: Let the parent terminate */
    if (pid > 0)
        exit(EXIT_SUCCESS);

    /* Set new file permissions */
    umask(0);

    /* Change the working directory to the root directory */
    /* or another appropriated directory */
    chdir("/");

    /* Close all open file descriptors */
    int x;
    for (x = sysconf(_SC_OPEN_MAX); x>=0; x--)
    {
        close (x);
    }

}

void notify( char * txt )
{
    char command[50];
    strcpy( command , "notify-send " );
    strcat( command , txt );
    system( command );
}

void get_value( char * loc, long * value )
{
    FILE* fd = fopen( loc , "r" );
    char val[255];

    fscanf( fd, "%s", val );
    *value = strtol(val, (char **)NULL, 10);

    fclose( fd );
}

void get_info( char * loc, char * value )
{
    FILE* fd = fopen( loc , "r" );

    fscanf( fd, "%s", value );

    fclose( fd );
}

int main()
{
    skeleton_daemon();

    notify("welcome");
    long value;
    long full;

    get_value( _full, &full );

    long notif = full*percentage;

    bool notifSent = false;

    char statePrev[15] = "";
    char state[15];

    while (1)
    {
        get_value( _now, &value );
        get_info( _status, state );

        notify(state);

        if ( value < notif && !notifSent)
        {
            notify( "-u critical '10% remaining'" );
            notifSent = true;
        }
        else if( notifSent && value > notif )
        {
            notifSent = false;
        }

        if ( strcmp( statePrev , state ) != 0 )
        {
            notify( state );
        }

        strcpy( statePrev, state );
        sleep (stime);
    }

    return EXIT_SUCCESS;
}

