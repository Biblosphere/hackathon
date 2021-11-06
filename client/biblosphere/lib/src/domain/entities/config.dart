import 'package:equatable/equatable.dart';

class Config {
  const Config({
    required this.apiConfigV1,
    required this.apiConfigV2,
  });

  factory Config.dev() {
    return const Config(
      apiConfigV1: ApiConfig(
        baseUrl: 'https://us-central1-biblosphere-210106.cloudfunctions.net',
        defaultHeaders: {
          'Host': 'us-central1-biblosphere-210106.cloudfunctions.net',
          // 'Accept': 'application/json',
          'Content-Type': 'application/json',
          // 'Access-Control-Allow-Origin': '*',
          // 'Access-Control-Allow-Methods': 'POST, GET',
        },
      ),
      apiConfigV2: ApiConfig(
        baseUrl: 'https://hackathon.biblosphere.org:5001',
        defaultHeaders: {
          'Host': 'hackathon.biblosphere.org:5001',
          // 'Accept': 'application/json',
          // 'Content-Type': 'application/json',
          // 'Access-Control-Allow-Origin': '*',
          // 'Access-Control-Allow-Methods': 'POST, GET',
        },
      ),
    );
  }

  final ApiConfig apiConfigV1;
  final ApiConfig apiConfigV2;
}

class ApiConfig extends Equatable {
  const ApiConfig({required this.baseUrl, required this.defaultHeaders});

  final String baseUrl;
  final Map<String, String> defaultHeaders;
  @override
  List<Object?> get props => [baseUrl, defaultHeaders];
}
