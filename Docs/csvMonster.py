#!/usr/local/bin/python3

def main():
    # print("I'm the csvMonster, I like eating CSVs")
    f = open("FaFiFotography-YegFood.csv")
    lines = assertions(f)  # get data in list, strip surrounding, and run assertions

    uniqueRestaurantNamesAndAddresses = set()

    for l in lines:
        uniqueRestaurantNamesAndAddresses.add((l[0], l[1]))

    uniqueRestaurantNamesAndAddresses = list(uniqueRestaurantNamesAndAddresses)

    for index in range(len(uniqueRestaurantNamesAndAddresses)):
        name = uniqueRestaurantNamesAndAddresses[index][0]
        address = uniqueRestaurantNamesAndAddresses[index][1]
        print("insert into restaurant(rid,name,address) values ("
                + str(index) + ',"' + name + '","' + address + '");')

    for l in lines:
        name = l[0]
        address = l[1]
        day = l[2]
        desc = l[3]
        t = (name,address)
        index = find(name, uniqueRestaurantNamesAndAddresses)
        if(index >= 0):
            print('insert into special(day,description,restaurant_id) values ("'
                    + day + '","' + desc + '",' + str(index) + ');')

def find(name, l):
    for index in range(len(l)):
        n = l[index][0]
        if(n == name):
            return index
    return -1

def assertions(f):
    lines = []
    for line in f:
        l = line.split(",")
        assert(len(l) == 4)

        for index in range(len(l)):
            l[index] = l[index].strip()

        # l = [place, address, day, desc]
        day = l[2]
        days = set(['Monday'
                   ,'Tuesday'
                   ,'Wednesday'
                   ,'Thursday'
                   ,'Friday'
                   ,'Saturday'
                   ,'Sunday'
                   ,'Weekdays'
                   ,'Weekends'
                   ,'Everyday'])
        assert(day in days)

        lines.append(l)
    # if it passes all assertions return the list of lines
    return lines

if __name__ == "__main__":
    main()
