/// Short-lived access token lifespan (Issue #120: "Access Token
/// (JWT): Short lifespan (15 mins)").
class ComputeAccessTokenExpiry {
  static const lifespan = Duration(minutes: 15);

  static DateTime call(DateTime issuedAt) => issuedAt.add(lifespan);
}
