fisier = input()
# fisier = "problema7.txt"
quantity = price = 0
money = 0
with open(fisier, 'r') as f:
    for text in f:
        for cuv in text.split():
            decimal = 0
            test = cuv.split(".")
            if len(test) == 2:
                decimal = int(test[0])+0.1*int(test[1])
                # print(decimal)
            elif test[0].isdecimal():
                decimal = int(test[0])
            if(decimal):
                if(quantity == 0):
                    quantity = decimal
                elif(price == 0):
                    price = decimal
            if quantity and price:
                money += price*quantity
                quantity = price = 0

print(money)
