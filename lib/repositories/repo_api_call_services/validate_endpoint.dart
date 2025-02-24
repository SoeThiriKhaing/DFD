class ValidateEndPoint {
  static void validateEndpoint(String endpoint) {
    if (!endpoint.startsWith("http://") && !endpoint.startsWith("https://")) {
      throw Exception("Insecure endpoint detected. Only HTTP and HTTPS are allowed.");
    }
  }
}
