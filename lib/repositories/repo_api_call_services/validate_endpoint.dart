class ValidateEndPoint {
  static void validateEndpoint(String endpoint) {
    if (!endpoint.startsWith("http://")) {
      throw Exception("Insecure endpoint detected. Only HTTPS is allowed.");
    }
  }
}
