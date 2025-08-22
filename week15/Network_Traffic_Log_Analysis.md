# Network Traffic and Log Analysis

## Task Overview

This task focuses on monitoring and analyzing network activity to
identify unusual behavior and potential security incidents. Two main
steps are included:

### a. Analyze Network Traffic with Wireshark

-   Use Wireshark or similar packet capture tools to monitor live
    network traffic.
-   Capture packets on specific interfaces to detect anomalies such as:
    -   Unexpected protocols in use.
    -   Unusually high traffic volumes (possible DoS/DDoS activity).
    -   Suspicious IP addresses or domains.
    -   Repeated failed connection attempts (brute force indicators).
-   Apply display filters (e.g., `http`, `dns`, `tcp.port==80`) to focus
    on relevant traffic.
-   Export and document packet captures for further investigation.

### b. Analyze Network Logs and Events

-   Collect and review logs from firewalls, IDS/IPS, servers, or
    application systems.
-   Look for patterns such as:
    -   Multiple failed logins from the same IP.
    -   Access attempts to restricted resources.
    -   Configuration changes outside working hours.
-   Correlate log data with packet captures to verify incidents.
-   Document all findings with timestamps, IPs, and type of suspicious
    activity.

## Deliverables

1.  Network traffic analysis report from Wireshark (screenshots, filters
    used, and findings).\
2.  Log analysis summary highlighting key anomalies and possible
    security incidents.\
3.  Documentation of steps taken, tools used, and lessons learned.

## Conclusion

By combining packet capture analysis with log review, potential threats
can be identified and investigated effectively. This approach
strengthens incident detection and supports proactive network defense.
