#Retele 2021

##Lab 1
LAN 
192.168.10.0/24

- ip-urile nu se schimba (ca CNP-ul)
- invatam cum sa calculam ip-uri
LAN (Local area network)
MAN (MEtropolian area network) - cum e reteau din univeristate
WAN (Wide are network)
WLAN (Wireless LAN)

Informatia intra doar prin Default GAteway (cel mai mic ip din range)
URL-uniform resource locator
DNS - Domain name Service (cel mai mare ip din range)

Email - pentru intrare si iesire e ip-ul de la dns

Consola:
- enable
- configure terminal
- interface vlan 1
- ip adress 192.168.10.2 255.255.255.0
- no shutdown

din computer -> command prompt
ping 192.168.10.2