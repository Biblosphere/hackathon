class Config {
  const Config({
    required this.baseUrlV1,
    required this.baseUrlV2,
    required this.hostV1,
    required this.hostV2,
    required this.defaultHeaders,
  });

  factory Config.dev() {
    return const Config(
      baseUrlV1: 'https://us-central1-biblosphere-210106.cloudfunctions.net',
      baseUrlV2: 'https://hackathon.biblosphere.org:5001',
      hostV1: 'us-central1-biblosphere-210106.cloudfunctions.net',
      hostV2: 'hackathon.biblosphere.org:5001',
      defaultHeaders: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        //"Access-Control-Allow-Origin": "*",
        //"Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      },
    );
  }

  final String baseUrlV1;
  final String baseUrlV2;
  final String hostV1;
  final String hostV2;
  final Map<String, String> defaultHeaders;
}
