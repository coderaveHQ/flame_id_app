import 'package:equatable/equatable.dart';

enum SignInStatus { initial, loading, success, failure }

class SignInState extends Equatable {

  final SignInStatus status;
  final Object? error;

  const SignInState({
    this.status = SignInStatus.initial,
    this.error
  });

  SignInState copyWith({
    SignInStatus? status,
    Object? error,
    bool removeError = false
  }) {
    return SignInState(
      status: status ?? this.status,
      error: removeError ? null : error ?? this.error
    );
  }

  bool get isLoading => status == SignInStatus.loading;

  bool get hasError => error != null;

  @override
  List<Object?> get props => [ 
    status, 
    error 
  ];
}
