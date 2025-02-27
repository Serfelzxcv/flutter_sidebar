import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

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
    return DataTable2(
      // Indica cuántas filas superiores quieres dejar fijas (cabeceras).
      fixedTopRows: 1,

      // Ajusta el ancho mínimo o elimina si no deseas restricción.
      minWidth: 600,
      // Controla el espacio entre columnas.
      columnSpacing: 20,

      // Altura de la cabecera y de cada fila (opcionales).
      headingRowHeight: 56,
      dataRowHeight: 40,

      // Estilo para la cabecera (similar a tu tabla anterior).
      headingRowColor: MaterialStateProperty.resolveWith(
        (states) => Colors.blueAccent,
      ),
      headingTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),

      // Borde y color de filas
      dataRowColor: MaterialStateProperty.resolveWith(
        (states) => Colors.grey[200]!,
      ),
      border: TableBorder.all(color: Colors.blue, width: 1),

      // Generamos las columnas en base a [columns].
      columns: columns.map(
        (col) {
          return DataColumn2(
            // `DataColumn2` nos permite más flexibilidad; 
            // ajusta `size` según tu preferencia (S, M, L...).
            size: ColumnSize.M,
            label: Center(child: Text(col)),
          );
        },
      ).toList(),

      // Generamos las filas en base a [rows].
      rows: rows.map((rowData) {
        return DataRow2(
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
    );
  }
}
