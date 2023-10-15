class AuthenticationService {
  Future login(String email, String password) {
    return Future.delayed(
      const Duration(seconds: 15),
      () {},
    );
  }
}
