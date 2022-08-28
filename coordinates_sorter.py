def getLineNumbers(line):
    coma = 0
    numbers = ["", "", ""]
    for i in line:
        if i != ',':
            if i == ' ' and coma >= 3 or i == '\n':
                break
            if i == ' ':
                continue
            numbers[coma] = numbers[coma] + i
        else:
            coma += 1
    
    numbers[0] = int(numbers[0])
    numbers[1] = int(numbers[1])
    numbers[2] = int(numbers[2])
    return numbers



# opening file
file = open('model.txt', 'r')
lines = file.readlines()

# generating int coordinates from file
coordinates = []
for i in lines:
    coordinates.append(getLineNumbers(i))

# finding the lowest coordinate in term of Y first, then X then Z
lowestX = 99999
lowestY = 99999
lowestZ = 99999
index = -1
for i in range(len(coordinates)):
    if coordinates[i][1] < lowestY:
        lowestX = coordinates[i][0]
        lowestY = coordinates[i][1]
        lowestZ = coordinates[i][2]
        index = i
        continue
    if coordinates[i][1] == lowestY:
        if coordinates[i][0] < lowestX:
            lowestX = coordinates[i][0]
            lowestY = coordinates[i][1]
            lowestZ = coordinates[i][2]
            index = i
            continue
        if coordinates[i][0] == lowestX:
            if coordinates[i][2] < lowestZ:
                lowestX = coordinates[i][0]
                lowestY = coordinates[i][1]
                lowestZ = coordinates[i][2]
                index = i
                continue

# sorting all coordinates by proximity from last cube in sorted_coords, the first one being the one we found
total_len_coordinates = len(coordinates)
print(coordinates[index])

sorted_coords = []
sorted_coords.append(coordinates[index])
del coordinates[index]

while len(coordinates) > 0:
    print(str((len(coordinates) / total_len_coordinates) * 100) + " %")
    X = sorted_coords[-1][0]
    Y = sorted_coords[-1][1]
    Z = sorted_coords[-1][2]
    closest_index = 0
    closest_dist = (X - coordinates[0][0]) * (X - coordinates[0][0]) + (Y - coordinates[0][1]) * (Y - coordinates[0][1]) + (Z - coordinates[0][2]) * (Z - coordinates[0][2])

    for i in range(len(coordinates)):
        dist = (X - coordinates[i][0]) * (X - coordinates[i][0]) + (Y - coordinates[i][1]) * (Y - coordinates[i][1]) + (Z - coordinates[i][2]) * (Z - coordinates[i][2])
        if dist <= closest_dist or coordinates[i][1] < coordinates[closest_index][1]:
            if coordinates[i][1] < coordinates[closest_index][1]:
                closest_index = i
                closest_dist = dist
                continue
            if coordinates[i][1] <= coordinates[closest_index][1] and coordinates[i][0] < coordinates[closest_index][0]:
                    closest_index = i
                    closest_dist = dist
                    continue
            if coordinates[i][1] <= coordinates[closest_index][1] and coordinates[i][0] <= coordinates[closest_index][0] and coordinates[i][2] < coordinates[closest_index][2]:
                    closest_index = i
                    closest_dist = dist
                    continue
    sorted_coords.append(coordinates[closest_index])
    del coordinates[closest_index]

# output in other file
with open("model_sorted.txt", "w") as filew:
    for i in sorted_coords:
        strg = str(i[0]) + " " + str(i[1]) + " " + str(i[2]) + "\n"
        filew.write(strg)