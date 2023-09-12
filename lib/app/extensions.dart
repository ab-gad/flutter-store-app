// Null-protect extensions
extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NonNullBool on bool? {
  bool orFalse() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}

extension NonNullList on List? {
  List orEmptyList() {
    if (this == null) {
      return [];
    } else {
      return this!;
    }
  }
}
