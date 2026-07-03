class EnvConfig {
  EnvConfig._();

  static const String environment = "DEV";

  static const String baseUrl =
      "https://berita-indo-api-next.vercel.app";

  static const String newsEndpoint =
      "/api/cnn-news/nasional";

  static bool get isProduction =>
      environment == "PROD";
}