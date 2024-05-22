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
        1: FixedColumnWidth(20.0),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const Opacity(
              opacity: 0.4,
              child: Text('CREATED AT'),
            ),
            const SizedBox.shrink(),
            Text(
              DateFormat.yMMMMd().add_jms().format(model.createdAt.toLocal()),
            ),
          ],
        ),
        TableRow(
          children: [
            const Opacity(
              opacity: 0.4,
              child: Text('OWNED BY'),
            ),
            const SizedBox.shrink(),
            Text(
              '${model.ownedBy.firstName} '
              '${model.ownedBy.lastName}',
            ),
          ],
        ),
        TableRow(
          children: [
            const Opacity(
              opacity: 0.4,
              child: Text('TYPE'),
            ),
            const SizedBox.shrink(),
            Text(
              model.isPrivate ? 'PRIVATE' : 'PUBLIC',
            ),
          ],
        ),
        TableRow(
          children: [
            const Opacity(
              opacity: 0.4,
              child: Text('TOTAL ASSETS'),
            ),
            const SizedBox.shrink(),
            Text(
              model.totalAssets.toString(),
            ),
          ],
        ),
      ],
    );
  }
}
