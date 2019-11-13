magazine = {}

with open('problema8.txt', 'r') as f:
    for row in f:
        row = row.split()
        magazine[row[0]] = row[1:]

# print(magazine)
# b) -------------
s = set()
for k in magazine.keys():
    if len(s) == 0:
        # s.add(*magazine[k])
        s = set(magazine[k]).copy()

    else:
        s = s.intersection(set(magazine[k]))
    if(len(s) == 0):
        break
# print(s)
# c) -------------------
s2 = set()
for k in magazine.keys():
    s2.update(set(magazine[k]))
# print(s2)#------------
# d) -------------------
for k in magazine.keys():
    ns = set()
    for l in magazine.keys():
        if magazine[k] is not magazine[l]:
            ns = set(magazine[k])
            for i in magazine[l]:
                if i in ns:
                    ns.remove(i)
    # print(k, *ns)
