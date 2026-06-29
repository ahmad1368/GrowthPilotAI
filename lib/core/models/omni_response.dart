// lib/core/models/omni_response.dart

import 'dart:async';

/// این خط جادویی، Future و OmniResponse را ادغام می‌کند
typedef OmniResult<T> = Future<OmniResponse<T>>;

class OmniResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  final int statusCode;

  OmniResponse(
      {this.data, this.message, required this.success, this.statusCode = 200});

  factory OmniResponse.success(T data, {String? message}) =>
      OmniResponse(success: true, data: data, message: message);

  factory OmniResponse.error(String message, {int statusCode = 500}) =>
      OmniResponse(success: false, message: message, statusCode: statusCode);
}
