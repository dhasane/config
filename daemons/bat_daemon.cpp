
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

#include <iostream>
#include <string>

// enumeration-like structure
struct Meta{

    std::string bat     = "/sys/class/power_supply/BAT0";   // battery
    std::string status  = bat + "/status";                  // status file
    std::string now     = bat + "/energy_now";              // actual charge
    std::string full    = bat + "/energy_full";             // full charge

    int stime           = 30;                               // interval of time in which the daemon will sleep
    float percentage    = 0.1;                              // percentage for the notification

}meta;


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


void notify( std::string txt )
{
    system( ( (std::string) "notify-send "+txt ).c_str(  )  );
}

void get_value( std::string loc, long * value )
{
    FILE* fd = fopen( loc.c_str() , "r" );
    char val[255];

    fscanf( fd, "%s", val );
    *value = strtol(val, (char **)NULL, 10);

    fclose( fd );
}

void get_info( std::string loc, std::string * value )
{
    FILE* fd = fopen( loc.c_str() , "r" );

    fscanf( fd, "%s", value );

    fclose( fd );
}

int main()
{
    notify( "welcome" );
    skeleton_daemon();

    long value;
    long full;

    get_value( meta.full, &full );

    long notif = full * meta.percentage;

    bool notifSent = false;

    std::string statePrev = "";
    std::string state;

    while (1)
    {
        get_value( meta.now, &value );
        get_info( meta.status, &state );

        if ( value < notif && !notifSent)
        {
            notify( "-u critical '10% remaining'" );
            notifSent = true;
        }
        else if( notifSent && value > notif )
        {
            notifSent = false;
        }

        if ( statePrev.compare( state ) != 0 )
        {
            notify( state );
            statePrev = state ;
        }

        notify( state );

        usleep (meta.stime);
    }

    return EXIT_SUCCESS;
}
