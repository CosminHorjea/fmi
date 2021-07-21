#Examen Retele

- Cateva intrebari DNS
- Diferente UDP TCP
- intrebari generale despre sockets
- "nu are sens sa va dau sa calculati biti(checksum)"
- Rolul anumitor campuri din header
	"ce rol are campul data offest, cati octeti are campul length"
- O sa fie suficient de multe intrebari a i cei care cauta pe net sa nu aiba timp-cei care cauta pe net sa poata sa ia 5
- contorizare pe intrebare ? nu stie sigur
- Important UDP/TCP (toti ar trebui sa stie)
- Cum functioneaza un DNS, ce face HTTPS
(Curs 3/4 pare important)
- Controlul conditionarii (sau congestonarii)(Curs 8)
- Path MTU Discovery| Fragmentarea de la nivelul de IT (curs 9)
- ICMP, Traceroute
- Rutare (Generalitati -> Distance vetor routing )(11)
- Autonomous Systems| BGP(nu chiar multe la BGP, sa stii doar la ce se refera)
- La alte examene stiu ca erau probleme cu CRC, dar el nu a pomenit nimic de asta

Intrebari de pe Teams:

-> Pentru ce este folosita metoda HTTP GET?
	*Metoda HTTP GET se folosente pentru a lua un document specificat prin URL
-> Ce contine un raspuns HTTP ?
	*Un raspuns HTTP contine versiunea de HTTP folosita , codul care denota statusul cererii, si un text care ne spune daca cererea a fost acceptata.Dupa acestea un raspuns HTTP poate contine mai multe MESSAGE HEADERS, spre exemplu Location care ne spune ca informatia pe care am cerut-o se afla la alta adresa 
-> Dați exemple și explicați cinci tipuri de DNS record types.
	* 	PTR- ip to name address este un ip mapat la un domain name (reverse lookup)
		A- name to address mapping
		NS- numele de domeniu pentru un host care se ocupa cu rezolvarea numelor de domeniu
		CNAME- Canonical name, este folosit ca alias pentru alt domain name
		MX - mail server
		aaaa- doamin name to ipv6
-> DNS folosește UDP în loc de TCP, iar UDP nu are un mecanism de control al fl uxului. Argumentați dacă ar putea fi asta o problemă pentru DNS.
	*Cererrile de tip DNS sunt in genereal foarte mici iar serverele dns nu au nevoie de o conexiune permanenta, deci nu pot transimte atat de multe date incat sa incarce foarte mult reteaua, in concluzie UDP este mai benefic pentru acestea
-> Ce este un port UDP?
	* Un port UDP este o coada pe server si client in care sosesc pachetele udp
-> Data offset numără rânduri de 32 de octeți în headerul TCP. (True / False)
	* da, Mai precis Data offset se refera la locul in pachetul TCP de unde incepe sectiunea cu date, inainte de asta se afla headerul apchetului su informatii specifice protocolului TCP(In contextul pachetului TCP, acesta se numeste HdrLen)
-> TCP si UDP folosesc acelasi Checksum?
	* Da, desi pare ca TCP este mult mai sofistica decat UDP, folosesc acelasi algoritm de checksum