dict = {}
dict1 = {
    "Ana": 15,
    "Viorel": 20,
    "Mitica": 14
}
dict2 = {
    "Ana": 15,
    "Alin": 10,
    "Miruna": 44
}
for k in dict1.keys():  # is there a function for this?
    if(dict2.get(k)):
        dict[k] = dict1[k]+dict2[k]
        dict2.pop(k)
    else:
        dict[k] = dict1[k]
for k in dict2.keys():
    dict[k] = dict2[k]
print(dict)
# dict1.update(dict2)
# dict = {**dict1, **dict2}# merge dict like a boss, dar nu cu valori, presupun ca val din dict2 ramane in caz de overlap
# print(dict)
# --------------------------------------------------
# def mergeDict(dict1, dict2): #Asta arata mai cool
#     ''' Merge dictionaries and keep values of common keys in list'''
#     dict3 = {**dict1, **dict2}
# asta face merge dar alea comune sunt suprapuse, nu stiu care valoare de la cheia k se pastreaza in dict 3
#     for key, value in dict3.items():
#         if key in dict1 and key in dict2:
#             dict3[key] = value + dict1[key]
#     return dict3

# print(mergeDict(dict1, dict2))
