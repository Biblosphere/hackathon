import 'package:biblosphere/src/domain/entities/config.dart';
import 'package:flutter/material.dart';

abstract class BaseApi {
  const BaseApi({required this.config});

  @protected
  final ApiConfig config;
}
