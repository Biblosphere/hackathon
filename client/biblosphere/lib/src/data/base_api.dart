import 'package:flutter/material.dart';

abstract class BaseApi {
  const BaseApi({required this.baseUrl, required this.defaultHeaders});

  @protected
  final String baseUrl;

  @protected
  final Map<String, String> defaultHeaders;
}
