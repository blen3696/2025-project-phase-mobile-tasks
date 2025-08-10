import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.signup(name, email, password);
  }
}
