import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'login_model.g.dart';

@freezed
class Login with _$Login {
  const factory Login({
    required int id,
    required String userName,
    required String email,
    required String token,
  }) = _Login;

  factory Login.fromJson(Map<String, Object?> json) => _$LoginFromJson(json);
}
