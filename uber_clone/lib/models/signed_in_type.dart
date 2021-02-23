enum SignedInType {
  Google,
  Facebook
}

extension typeConversion on SignedInType {
  String parseSignedInType() {
    return this.toString().split(".")[1];
  }
}