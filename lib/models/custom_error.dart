import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errMsg;
  CustomError({
    this.errMsg = '',
  });

  @override
  List<Object> get props => [errMsg];

  @override
  String toString() => 'CustomError(errMsg: $errMsg)';

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'errMsg': errMsg});

    return result;
  }

  factory CustomError.fromJson(Map<String, dynamic> json) {
    return CustomError(
      errMsg: json['errMsg'] ?? '',
    );
  }
}
