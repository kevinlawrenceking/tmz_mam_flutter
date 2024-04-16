import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/shared/widgets/copy_text.dart';

class PhotoInfo extends StatelessWidget {
  final AssetDetailsModel? model;

  const PhotoInfo({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0x20000000),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000.0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(10.0),
                    2: FlexColumnWidth(),
                    3: FixedColumnWidth(10.0),
                    4: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'TECHNICAL ID',
                            value: model?.id ?? '',
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(width: 10.0),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'ORIGINAL FILE NAME',
                            value: model?.originalFileName ?? '',
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(width: 10.0),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: false,
                            label: 'STATUS',
                            value: () {
                              switch (model?.status) {
                                case AssetStatusEnum.available:
                                  return 'Available';
                                case AssetStatusEnum.deleted:
                                  return 'Deleted';
                                case AssetStatusEnum.processing:
                                  return 'Processing';
                                default:
                                  return '-';
                              }
                            }(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(10.0),
                    2: FlexColumnWidth(),
                    3: FixedColumnWidth(10.0),
                    4: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'CREATED BY',
                            value: () {
                              if (model?.createdBy != null) {
                                final firstName = model!.createdBy.firstName;
                                final lastName = model!.createdBy.lastName;
                                return '$firstName $lastName';
                              } else {
                                return '';
                              }
                            }(),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(width: 10.0),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'CREATED',
                            value: (() {
                              if (model?.createdAt != null) {
                                return DateFormat.yMd()
                                    .add_jms()
                                    .format(model!.createdAt.toLocal());
                              } else {
                                return '-';
                              }
                            })(),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'UPDATED',
                            value: (() {
                              if (model?.updatedAt != null) {
                                return DateFormat.yMd()
                                    .add_jms()
                                    .format(model!.updatedAt.toLocal());
                              } else {
                                return '-';
                              }
                            })(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else if (constraints.maxWidth > 700.0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(10.0),
                    2: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'TECHNICAL ID',
                            value: model?.id ?? '',
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(width: 10.0),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'ORIGINAL FILE NAME',
                            value: model?.originalFileName ?? '',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1.5),
                    1: FixedColumnWidth(10.0),
                    2: FlexColumnWidth(0.5),
                    3: FixedColumnWidth(10.0),
                    4: FlexColumnWidth(),
                    5: FixedColumnWidth(10.0),
                    6: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'CREATED BY',
                            value: () {
                              if (model?.createdBy != null) {
                                final firstName = model!.createdBy.firstName;
                                final lastName = model!.createdBy.lastName;
                                return '$firstName $lastName';
                              } else {
                                return '';
                              }
                            }(),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(width: 10.0),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: false,
                            label: 'STATUS',
                            value: () {
                              switch (model?.status) {
                                case AssetStatusEnum.available:
                                  return 'Available';
                                case AssetStatusEnum.processing:
                                  return 'Processing';
                                default:
                                  return '-';
                              }
                            }(),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(width: 10.0),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'CREATED',
                            value: (() {
                              if (model?.createdAt != null) {
                                return DateFormat.yMd()
                                    .add_jms()
                                    .format(model!.createdAt.toLocal());
                              } else {
                                return '-';
                              }
                            })(),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'UPDATED',
                            value: (() {
                              if (model?.updatedAt != null) {
                                return DateFormat.yMd()
                                    .add_jms()
                                    .format(model!.updatedAt.toLocal());
                              } else {
                                return '-';
                              }
                            })(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCell(
                  context: context,
                  theme: theme,
                  canCopy: true,
                  label: 'TECHNICAL ID',
                  value: model?.id ?? '',
                ),
                _buildCell(
                  context: context,
                  theme: theme,
                  canCopy: true,
                  label: 'ORIGINAL FILE NAME',
                  value: model?.originalFileName ?? '',
                ),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(10.0),
                    2: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'CREATED BY',
                            value: () {
                              if (model?.createdBy != null) {
                                final firstName = model!.createdBy.firstName;
                                final lastName = model!.createdBy.lastName;
                                return '$firstName $lastName';
                              } else {
                                return '';
                              }
                            }(),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(width: 10.0),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: false,
                            label: 'STATUS',
                            value: () {
                              switch (model?.status) {
                                case AssetStatusEnum.available:
                                  return 'Available';
                                case AssetStatusEnum.processing:
                                  return 'Processing';
                                default:
                                  return '-';
                              }
                            }(),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'CREATED',
                            value: (() {
                              if (model?.createdAt != null) {
                                return DateFormat.yMd()
                                    .add_jms()
                                    .format(model!.createdAt.toLocal());
                              } else {
                                return '-';
                              }
                            })(),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(),
                        ),
                        TableCell(
                          child: _buildCell(
                            context: context,
                            theme: theme,
                            canCopy: true,
                            label: 'UPDATED',
                            value: (() {
                              if (model?.updatedAt != null) {
                                return DateFormat.yMd()
                                    .add_jms()
                                    .format(model!.updatedAt.toLocal());
                              } else {
                                return '-';
                              }
                            })(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCell({
    required BuildContext context,
    required ThemeData theme,
    required bool canCopy,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: 0.4,
            child: Text(
              label,
              maxLines: 1,
              softWrap: false,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          canCopy
              ? CopyText(
                  value,
                  maxLines: 1,
                  softWrap: false,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    value,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
