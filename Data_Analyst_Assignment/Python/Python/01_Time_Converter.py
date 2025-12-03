s = input("Enter string: ")
 new= ""

for i in s:
    if i  not in new:
        new+=i

print(new)
