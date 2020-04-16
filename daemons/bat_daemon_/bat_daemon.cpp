
/*
 * for this daemon the following was used as the skeleton for the daemonization:
 * https://stackoverflow.com/questions/17954432/creating-a-daemon-in-linux/17955149#17955149
 * Fork this code: https://github.com/pasce/daemon-skeleton-linux-c
 */


#include <iostream>
#include <string>

// enumeration-like structure
struct Meta{

    std::string bat     = "/sys/class/power_supply/BAT0";   // battery
    std::string stat    = bat + "/status";                  // status file
    std::string now     = bat + "/energy_now";              // actual charge
    std::string full    = bat + "/energy_full";             // full charge

    int stime           = 30;                               // interval of time in which the daemon will sleep
    float percentage    = 0.1;                              // percentage for the notification

}meta;

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

    fscanf( fd, "%s", value->c_str() );

    fclose( fd );
}

int main()
{
    notify( "welcome" );

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
        get_info( meta.stat, &state );

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

