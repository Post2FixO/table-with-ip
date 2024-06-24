#!/bin/bash

# Collect data into an array
data=$(ip -4 -o addr show scope global | awk '{ split($4, ip, "/"); printf "%s %s /%s %s\n", $2, ip[1], ip[2], $6 }')

# Determine the maximum length for each column, considering both data and header titles
max_lengths=($(echo "$data" | awk '
{
    # Check if the length of the current value in column 1 is greater than max1
    # If so, update max1 to this length
    if (length($1) > max1) max1 = length($1);
    if (length($2) > max2) max2 = length($2);
    if (length($3) > max3) max3 = length($3);
    if (length($4) > max4) max4 = length($4);
}
END {
    # Ensure each column is at least as wide as the header title
    max1 = (max1 > length("Interface") ? max1 : length("Interface"));
    max2 = (max2 > length("IP Address") ? max2 : length("IP Address"));
    max3 = (max3 > length("Subnet Mask") ? max3 : length("Subnet Mask"));
    max4 = (max4 > length("Broadcast") ? max4 : length("Broadcast"));
    # Print the maximum lengths of each column
    print max1, max2, max3, max4;
}'))

# Print the header with dynamic width and 4 spaces between columns
printf "%-${max_lengths[0]}s    %-${max_lengths[1]}s    %-${max_lengths[2]}s    %-${max_lengths[3]}s\n" "Interface" "IP Address" "Subnet Mask" "Broadcast"
printf "%-${max_lengths[0]}s    %-${max_lengths[1]}s    %-${max_lengths[2]}s    %-${max_lengths[3]}s\n" "---------" "----------" "-----------" "---------"

# Print the data with dynamic width and 4 spaces between columns
echo "$data" | awk -v max1=${max_lengths[0]} -v max2=${max_lengths[1]} -v max3=${max_lengths[2]} -v max4=${max_lengths[3]} '
{
    # Print each row with columns formatted to the calculated maximum widths
    # and separated by 4 spaces between each column
    printf "%-"max1"s    %-"max2"s    %-"max3"s    %-"max4"s\n", $1, $2, $3, $4;
}'
