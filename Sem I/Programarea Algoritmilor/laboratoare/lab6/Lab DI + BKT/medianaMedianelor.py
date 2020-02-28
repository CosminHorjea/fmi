def medOfMeds(l):
    if len(l) <= 5:
        return l[len(l)//2]
    else:
        chunks = [sorted(l[i:i+5]) for i in range(0, len(l), 5)]

        meds = [chunk[len(chunk)//2] for chunk in chunks]

        return medOfMeds(meds)


ls = [17, 4, 10, 2, 9, 3, 15, 34, 21, 7, 7, 2, 17, 4, 10, 2, 9, 8,
      3, 15, 34, 21, 7, 7, 2, 17, 4, 10, 2, 9, 3, 15, 34, 21, 7, 7, 2]
print(medOfMeds(ls))
