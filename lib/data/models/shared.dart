enum ComparisonMethodEnum {
  unknown,
  equal,
  notEqual,
  contains,
  beginsWith,
  endsWith;

  static ComparisonMethodEnum? fromJsonDtoValue(
    String? value,
  ) {
    return {
      'EQ': ComparisonMethodEnum.equal,
      'NQ': ComparisonMethodEnum.notEqual,
      'CONTAINS': ComparisonMethodEnum.contains,
      'BEGINS_WITH': ComparisonMethodEnum.beginsWith,
      'ENDS_WITH': ComparisonMethodEnum.endsWith,
    }[value?.toUpperCase()];
  }

  String? toJsonDtoValue() {
    return {
      ComparisonMethodEnum.equal: 'EQ',
      ComparisonMethodEnum.notEqual: 'NQ',
      ComparisonMethodEnum.contains: 'CONTAINS',
      ComparisonMethodEnum.beginsWith: 'BEGINS_WITH',
      ComparisonMethodEnum.endsWith: 'ENDS_WITH',
    }[this];
  }
}

enum SortDirectionEnum {
  ascending,
  descending,
}
