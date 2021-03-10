from itertools import accumulate


def leerData():
    title = []
    columnas = []

    data = []

    with open('tables_info.txt', "r") as archivo_lectura:
        documento = []
        for line in archivo_lectura.readlines():
            documento.append(line)
        idx = 0
        saltos = []
        saltos_2 = []
        for line in documento:
            idx += 1
            if line[0:13] == 'Sample table:':
                title.append(line[14:31].strip("\n"))
                columnas.append(documento[idx+1])
                saltos.append(documento.index(line)-1)
            elif "--+--" in line:
                saltos_2.append(documento.index(line)+1)
        for i in range(len(saltos)-1):
            data.append(documento[saltos_2[i]:saltos[i+1]])
        data.append(documento[saltos[-1]:len(documento)])
        return title, columnas, data, len(documento)


def OrderInfo(data, longitudes):

    new_data = []
    for j in range(len(data)):
        for elemento in data[j]:
            elemento = elemento.strip(" ")
            elemento = elemento.replace("|", ",")
            elemento = elemento.replace("          ", "")
            elemento = elemento.replace(" ", "")
            elemento = elemento.strip("\n")
            new_data.append(elemento)

    data_final = []
    for j in range(len(data)-1):
        data_final.append(new_data[longitudes[j]:longitudes[j+1]])

    data_final.append(new_data[longitudes[-2]:len(new_data)])

    return data_final


def changeToTuple(data_list, longitudes):
    data_tuple = []
    for i in range(len(data_list)):
        for elemento in data_list[i]:
            data_tuple.append(tuple(elemento.split(",")))

    data_final_2 = []

    for j in range(len(data)-1):
        data_final_2.append(data_tuple[longitudes[j]:longitudes[j+1]])

    data_final_2.append(data_tuple[longitudes[-2]:len(data_tuple)])

    return data_final_2


def calculateLong(data):
    longitudes = []
    for logn in data:
        longitudes.append(len(logn))
    longitudes = list(accumulate(longitudes))
    longitudes.insert(0, 0)
    return longitudes


def writeSQL(dict_final, data_tuples, columnas):
    fisrt_line = "INSERT INTO"
    second_line = "VALUES"

    keys = dict_final.keys()

    indice = 0
    for key in keys:
        f = open(f'sql_table_{key}.sql', "w")
        f.writelines(
            f'{fisrt_line} {key} {columnas[indice]}{second_line} {data_tuples[indice]}')
        indice += 1
        f.close()
    return None


def AddColumns(tables):

    new_table = []
    for column in tables:
        new_table.append(tuple(column.strip("\n").split("|")))


    return new_table


if __name__ == "__main__":
    tables = leerData()

    # Extraer info
    dict_tables = dict(zip(tables[0], tables[1]))
    data = tables[2]
    longitud_doc = tables[3]



    columnas = AddColumns(tables[1])

    longitudes_data = calculateLong(data)

    data_list = OrderInfo(data, longitudes_data)

    data_tuple = changeToTuple(data_list, longitudes_data)

    writeSQL(dict_tables, data_tuple, columnas)
