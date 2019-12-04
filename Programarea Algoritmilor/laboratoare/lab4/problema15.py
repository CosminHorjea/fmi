import re


def avg(l):
    suma = 0
    for i in l:
        suma += i
    return suma/len(l)


f = open("ping.in", 'r')
g = open("ping.out", 'w')
text = f.read()
f.close()
pattern = re.findall('time=.*ms', text)
times = []
for i in pattern:
    times.append(float(i[5:11]))
print(min(times))
g.write("Timp minim: "+str(min(times))+" ms\n")
print(max(times))
g.write("Timp maxim: "+str(max(times))+" ms\n")
print(avg(times))
g.write("Timp mediu: "+str(avg(times))[:6]+" ms\n")
dns = re.findall('([a-z]+[\.]+[a-z].*)\w+', text)
print(dns[0].split()[0])  # asta chiar nu e cute
g.write("IP: "+dns[0].split()[0]+'\n')
ip = re.findall(
    '\d+\.\d+\.\d+\.\d+', text)
print(ip[0])
g.write("DNS: "+ip[0])
