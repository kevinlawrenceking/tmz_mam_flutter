class InventoryMetadataModel {
  final int orderNo;
  final String? label;
  final String? value;

  InventoryMetadataModel({
    required this.orderNo,
    required this.label,
    required this.value,
  });

  static InventoryMetadataModel fromJson(Map<String, dynamic> json) {
    return InventoryMetadataModel(
      orderNo: json['orderNo'] as int,
      label: json['label'],
      value: json['value'],
    );
  }
}
