#!/usr/bin/bash

# # Define the clock
# Clock() {
#         DATETIME=$(date "+%a %b %d, %T")
#
#         echo -n "$DATETIME"
# }
#
# # Print the clock
#
# while true; do
#         echo "%{c}%{F#FFFF00}%{B#0000FF} $(Clock) %{F-}%{B-}"
#         sleep 1
# done
#Define the battery
Battery() {
        BATPERC=$(acpi --battery | cut -d, -f2)
        echo "$BATPERC"
}

# Print the percentage
while true; do
        echo "%{r}$(Battery)"
        sleep 1;
done
