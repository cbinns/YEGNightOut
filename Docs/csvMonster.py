#!/usr/local/bin/python3

def main():
    print("I'm the csvMonster, I like eating CSVs")
    f = open("FaFiFotography-YegFood.csv")
    lines = assertions(f)

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
