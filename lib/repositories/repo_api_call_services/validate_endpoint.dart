class ValidateEndPoint{
  static void validateEndpoint(String endpoint) {
    if (!endpoint.startsWith("https://")) {
      throw Exception("Insecure endpoint detected. Only HTTPS is allowed.");
    }
  }
}