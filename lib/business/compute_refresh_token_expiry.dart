/// Long-lived refresh token lifespan (Issue #120, acceptance
/// criterion: "logged into the Flutter App remains logged in for 30
/// days unless they manually log out").
class ComputeRefreshTokenExpiry {
  static const lifespan = Duration(days: 30);

  static DateTime call(DateTime issuedAt) => issuedAt.add(lifespan);
}
