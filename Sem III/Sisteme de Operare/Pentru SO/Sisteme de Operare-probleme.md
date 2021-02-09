Sisteme de Operare

1. 10 p Diferenta dintr-o pagina si un segment, un exemplu

un program se imparte in pagini si intra in memoria principala (nu l-a mai scris dar e in curs)

2. Este data o "arborescenta :)" si spunem sa scriem o secventa de cod care reproduce secventa de cod de mai sus
http://prntscr.com/wln6um

fork,wait,if-uri

pid_t pid 2 = fork();
if(pid2 == 0){//daca sunt copil
	pid_t pid5 = fork();
	if(pid5){
		pid_t pid6 = fork()
	}
} else{//parinte
	pid_t pid3 = fork();
	if(pid3 == 0){
		pid_t pid7 = fork();
	}else{
		pid_t pid4 = fork();
		//exit(); sau pot sa nu mai fac
	}
}
(ajuta foarte mult diagrama)
-- nu e nevoie de wait sau exit
http://prntscr.com/wlnbjf

3. Fie solutia problemei bounded buffer si implmentarea
http://prntscr.com/wlnhm3
do{                          do{
	wait(empty);                 wait(full);
	wait(mutex);                 wait(mutex);
	/*PRODUCE ITEM*/             /*CONSUME ITEM*/
	signal(mutex);               signal(mutex);
	signal(full);                signal(empty);
}while(true);				}while(true); 

							mutex = 1
							empty=n
							full = 0
3 intrebari (15p)

1. care este rolul lui empty?
2. sa adaugam cod pentru consumator
3. sa aratam daca solutia satisface timp finit de asteptare

1. empty se asigura sa existe sloturi unde sa puna producatorul ce produce
consumatorul elibereaza memoria din buffer
sau empty=nr de pozitii libere in buffer
2. "sa facem ceva cu bufferul" (5pct gratuire :))
3. nu stiu ce a zis, doar ca nu avem timp finit de asteptare
 -- dam un contraexemplu,
 -- sau aceasta bucla infinita poate sa tina acelasi proces fara a da drept altui producator
 -- daca avem n+1 producatori cum ma asigur ca toti nu asteapta la wait() in prima parte (sau ca unul nu sta permanent acolo)?

 P0,P1-producatori      C0,C1,.....-consumatori

cand p0 intra pe procesor el se poate invarti pe bucla 1 cat vrea daca il lasa alg de scheduleing
--deci se poate intampla ca P0 sa umple toate resursele iar atunci cand un consumator da release la o resursa, un alg de schedueling prost poate sa il lase tot pe P0 sa ia mutex-ul ,deci P1 intra in starving.

4. Alg de schedueling
http://prntscr.com/wlnr4s

Process    t   CPU
------------------
P0         0    4 / => 1 / t=4 (cand isi termina executia)
P1         3    2 / => 1 / t=6
P2         4    2
P3         5    1// 
P4         7    2

1. diagrama Grantt in umra alg sjf non premptive
2. aceeasi diagrama in produl emptive
3. timp mediu de asteptare

#SJF premptive

P0   P0  P1 P1  P3  P2  P4   |
-------------------------------------
0    3   4  5   6   7   9    11

--cand ajungem la un timp t , vad care proces are cel mai putin de executat
si executam acel proces, gen la t=3 am p0 si p1 unde p0 mai are 1 de executatdei executam p0 si pe p1 la 4

http://prntscr.com/wlnwgu

#SJF Nonpreemptive

Process    t   CPU
------------------
P0         0    4 
P1         3    2 
P2         4    2
P3         5    1 
P4         7    2

-- o data ce am luat o decizie aia e (nu poate sa fie intrerupt)

P0   P1   P3  P2   P4   |
--------------------------
0    4    6    7    9   11  
http://prntscr.com/wlnye2

3.Timp mediu de asteptare:
[0+(4-3)+(6-5)+(7-4)+(9-7)]/5


Asta e un examen

Alte subiecte posibile
--la 2 in loc sa avem arborele aveam cod si trebuia sa zicem noi cate procese/threaduri sunt
--la 3 cred fie solutia cititorilor scriitorilor


Alt 4) Fie urmatoare coada de asteptare a paginilor

1 2 3 2 4 3 6 4 5 4 6 2 1
Folosind algoritmul LRU care este numarul minim de frame-uri necesar a i sa nu se produce nici-un page frouning(?)
n=6 ca sa incapa fiecare pagina intr-un frame

-- cu arata aplicarea alg LRU pentru n-2 frameuri
						<-
	|1 2 3 2 4 3 6 4 5 4 6 2 1
-------------------------------
   1|1 1 1   1   6   6     6 6 
   2|  2 2   2   2   5     5 1
   3|    3   3   3   3     2 2
   4|        4   4   4     4 4

   cand ajung la o pagina noua care nu e in aia de jos o scot pe aia care nu a mai fost folosita de cel mai mult timp