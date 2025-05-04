# Ouster Network Configuration Documentation

## Introduction

This document provides detailed instructions for configuring the network settings to use an Ouster LiDAR sensor. Proper network configuration is critical to ensure seamless communication between the sensor and the client machine for data collection and visualization.

---

## Prerequisites

Before beginning, ensure you have:

- An Ouster LiDAR sensor.
- A client machine with a compatible operating system (Linux, Windows, or macOS).
- Ethernet cables (Cat 5e or higher) to support 1 Gbps Ethernet.
- A compatible network switch if using multiple devices.
- Administrative access to configure network settings on both the sensor and the client machine.

---

## Network Setup



### 1. Physical Connections

1. Connect the Ouster sensor to the network switch or directly to the client machine using a high-quality Ethernet cable.
2. Ensure the cable is properly seated in the ports.
3. If using a switch, ensure the switch supports 1 Gbps Ethernet on all ports.

---

### 2. Setting Up the Client Machine

#### Linux Configuration (Example: Ubuntu)

1. Identify the network interface connected to the sensor:

   ```bash
   ip link show
   ```

2. Flush any existing IP addresses from the interface:

   ```bash
   sudo ip addr flush dev <interface_name>
   ```

   Replace `<interface_name>` with the actual interface name (e.g., `enp2s0`).

3. Assign a static IP to the interface:

   ```bash
   sudo ip addr add 10.5.5.1/24 dev <interface_name>
   ```

4. Bring the interface up:

   ```bash
   sudo ip link set <interface_name> up
   ```

5. Verify the configuration:

   ```bash
   ip addr show dev <interface_name>
   ```

---

### 3. Discovering the Sensor's IP Address

1. Use a tool like `dnsmasq` to dynamically assign IPs and listen for the sensor:
   ```bash
   sudo dnsmasq -C /dev/null -kd -F 10.5.5.50,10.5.5.100 -i <interface_name> --bind-dynamic
   ```
2. Ping potential IPs in the range to locate the sensor:
   ```bash
   ping 10.5.5.92
   ```
   Replace `10.5.5.92` with the detected IP address of the sensor.

Alternatively, you can use the hostname format:
   - `http://os-992041000593.local`

   In this example, `992041000593` is the serial number of the Ouster sensor. Replace this with the actual serial number of your sensor, which can be found on a sticker affixed to the top of the sensor.

   **Note:** Ensure not to use `https://` in the hostname as it will result in an error. The correct format is `http://os-<serial_number>.local`.

---

### 4. Ouster Sensor Web Interface

1. Open a web browser and navigate to the sensor’s detected IP address (e.g., `http://10.5.5.92`) or hostname (e.g., `http://os-992041000593.local`).
2. Log in to the sensor (if required) using default credentials.
3. Verify the current network settings and update them if necessary:
   - **Destination IP**: Set to the client machine's IP (`10.5.5.1`).
   - **Destination Port (LiDAR Data)**: Choose a port (e.g., `7502`).
   - **Destination Port (IMU Data)**: Choose a port (e.g., `7503`).

---

### 5. Firewall and Network Policies

- Ensure that UDP traffic is allowed on the chosen ports (e.g., `7502`, `7503`) on the client machine.
- Linux:
  ```bash
  sudo ufw allow 7502/udp
  sudo ufw allow 7503/udp
  ```
- Windows:
  - Open **Windows Defender Firewall**.
  - Create new inbound rules for the required ports.

---

### 6. Testing the Connection

1. Ping the sensor from the client machine to verify connectivity:
   ```bash
   ping <sensor_ip>
   ```
2. Use `tcpdump` or `wireshark` to monitor incoming UDP packets:
   ```bash
   sudo tcpdump -i <interface_name> udp port 7502
   ```

---

## Troubleshooting

- **Issue:** Unable to ping the sensor.
  - **Solution:** Check the cable connection, IP settings, and ensure the interface is up.
- **Issue:** No data received on the client.
  - **Solution:** Verify UDP destination IP and ports in the sensor’s configuration.

---