import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmz_damz/data/models/collection.dart';

class CollectionDetails extends StatelessWidget {
  final CollectionModel model;

  const CollectionDetails({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FixedColumnWidth(10.0),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const TableCell(
              child: Opacity(
                opacity: 0.4,
                child: Text('CREATED AT'),
              ),
            ),
            const TableCell(child: SizedBox()),
            TableCell(
              child: Text(
                DateFormat.yMMMMd().add_jms().format(model.createdAt.toLocal()),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Opacity(
                opacity: 0.4,
                child: Text('OWNED BY'),
              ),
            ),
            const TableCell(child: SizedBox()),
            TableCell(
              child: Text(
                '${model.ownedBy.firstName} '
                '${model.ownedBy.lastName}',
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Opacity(
                opacity: 0.4,
                child: Text('TYPE'),
              ),
            ),
            const TableCell(child: SizedBox()),
            TableCell(
              child: Text(
                model.isPrivate ? 'PRIVATE' : 'PUBLIC',
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Opacity(
                opacity: 0.4,
                child: Text('TOTAL ASSETS'),
              ),
            ),
            const TableCell(child: SizedBox()),
            TableCell(
              child: Text(
                model.totalAssets.toString(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
