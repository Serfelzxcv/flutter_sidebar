import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  /// Lista con los títulos de cada columna.
  final List<String> columns;

  /// Lista de filas, donde cada elemento (fila) es a su vez
  /// una lista de valores en el mismo orden de `columns`.
  final List<List<dynamic>> rows;

  const DataTableWidget({
    Key? key,
    required this.columns,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical, // Permite scroll vertical si hay muchas filas
          child: DataTable(
            columnSpacing: constraints.maxWidth * 0.1,
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.blueAccent),
            headingTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            dataRowColor: MaterialStateColor.resolveWith(
              (states) => Colors.grey[200]!,
            ),
            border: TableBorder.all(
              color: Colors.blue,
              width: 1,
            ),
            // Generamos las columnas en base a la lista [columns]
            columns: columns
                .map(
                  (col) => DataColumn(
                    // Puedes decidir si alguna columna es numeric según el caso.
                    // Aquí se pone false como ejemplo genérico.
                    label: Expanded(
                      child: Center(child: Text(col)),
                    ),
                    numeric: false,
                  ),
                )
                .toList(),
            // Generamos las filas en base a la lista [rows]
            rows: rows.map((rowData) {
              return DataRow(
                cells: rowData.map((cellValue) {
                  return DataCell(
                    Center(
                      child: Text(
                        cellValue.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
