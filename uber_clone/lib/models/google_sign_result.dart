


class GoogleSignInProgress {
  bool accountAuthentication = false, uberSignIn = false, savingData = false, storingPicture = false;
  GoogleSignInResult result = GoogleSignInResult.InProgress;




  void reset() {
    accountAuthentication = uberSignIn = savingData = storingPicture = false;
    result = GoogleSignInResult.InProgress;
  }

}



enum GoogleSignInResult {
  InProgress,
  Cancelled,
  Success
}