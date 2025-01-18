class SanitizeHeaders {
   static Map<String, String>? sanitizeHeaders(Map<String, String>? headers) {
    if (headers == null) return null;

    final sanitized = Map<String, String>.from(headers);
    if (sanitized.containsKey("Authorization")) {
      sanitized["Authorization"] = "*****"; // Mask sensitive tokens
    }

    return sanitized;
  }
}