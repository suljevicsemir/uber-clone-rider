





enum FirestoreResults {
  Ok,
  Error,
  Timeout
}

class FirestoreResult<T> {
  final T value;

  FirestoreResult({
    required this.value,
  });
}


