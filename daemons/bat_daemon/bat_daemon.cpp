#include <iostream>
#include <fstream>
#include <string>
#include <unistd.h>

#include <sstream>

#include "daemon.cpp"

// int main()
// {
//     std::string path = "/path/to/directory";
//     for (const auto & entry : std::filesystem::directory_iterator(path))
//         std::cout << entry.path() << std::endl;
// }

class bat_daemon : public Daemon{

    private:
    long value;
    long full;

    long notif;
    bool notifSent;

    std::string statePrev;
    std::string state;


    std::string bat_l;   // battery
    std::string status_l;  // status file
    std::string now_l;   // actual charge
    std::string full_l;  // full charge

    unsigned int wait_time; // interval of time in which the daemon will sleep
    float percentage;       // percentage for the notification

    public:
    bat_daemon( std::string bat, int wait_time, float per ) : Daemon( ) {

        this->bat_l = bat;                          // main folder
        this->wait_time = wait_time;
        this->percentage = per;

        this->status_l  = bat_l + "/status";                  // status file
        this->now_l     = bat_l + "/energy_now";              // actual charge
        this->full_l    = bat_l + "/energy_full";             // full charge

        notify( "welcome" );

        this->full = string_to_long(get_file_value( this->full_l ));
        this->notif = full * this->percentage;

        this->statePrev = get_file_value( this->status_l );
        this->notifSent = true;

        this->start( this->wait_time );
    }

    void run()
    {
        value = string_to_long( get_file_value( this->now_l ) );
        state = get_file_value( this->status_l );

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
    }
    void notify( std::string txt )
    {
        system( ( (std::string) "notify-send "+txt ).c_str( )  );
    }

    std::string get_file_value ( std::string file_name ) {
        std::string value = "";

        std::ifstream myfile;
        myfile.open ( file_name );
        myfile >> value;
        myfile.close();
        return value;
    }

    inline long string_to_long(const std::string& s)
    {
        std::istringstream i(s);
        double x;
        i >> x;
        return x;
    }
};

int main(int argc, char *argv[])
{
    bat_daemon( argc > 0 ? argv[1] : "/sys/class/power_supply/BAT0" , 30, 0.1 );
    return EXIT_SUCCESS;
}

