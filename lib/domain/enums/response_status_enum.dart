enum ResponseStatusEnum {
  success(0),
  failure(1);

  const ResponseStatusEnum(this.statusCode);

  final int statusCode;
}
