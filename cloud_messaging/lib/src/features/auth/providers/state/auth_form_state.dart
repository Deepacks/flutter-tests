import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_form_state.freezed.dart';

@freezed
class AuthFormState with _$AuthFormState {
  const factory AuthFormState.initial() = _Initial;

  const factory AuthFormState.loading() = _Loading;

  const factory AuthFormState.error({
    @Default('Something went wrong') String message,
  }) = _Error;
}
