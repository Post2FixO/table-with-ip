# Network Information Table Script

Displays network interfaces information in a neat table (with `awk`) using the existing 'ip' command (`iproute2`).

## Features

- Collect IPv4 address information for all network interfaces.
- Display a table with columns for Interfaces, IP Addresses, Subnet Masks, and Broadcasts.
- Ensures columns begin 4 spaces after the longest entry in the previous column (including the headers).

## Usage

You can use tis as a script or by pasting the entire content into your terminal.

### Run as a Script

1. Save the script to a file (e.g. `network_info.sh`).
2. Make the script executable:
    ```sh
    chmod +x network_info.sh
    ```
3. Navigate to the scripts directory
4. Run the script:
    ```sh
    ./network_info.sh
    ```

## Example Output

```sh
Interface          IP Address       Subnet Mask    Broadcast     
---------          ----------       -----------    ---------     
wlp2s0             192.168.1.246    /24            192.168.1.255 
br-3dc569643e0f    172.18.0.1       /16            172.18.255.255
docker0            172.17.0.1       /16            172.17.255.255
br-e8b59e2e3d95    192.168.49.1     /24            192.168.49.255
vboxnet0           192.168.56.1     /24            192.168.56.255
```
