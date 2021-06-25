

class CustomMarkerId {
  final String id;

  CustomMarkerId({required this.id});

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other.runtimeType != runtimeType) return false;

    // ignore: test_types_in_equals
    final CustomMarkerId typedOther = other as CustomMarkerId;
    return typedOther.id == this.id;

  }

  @override
  int get hashCode => id.hashCode;



}