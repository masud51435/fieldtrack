/// The base class for all UseCases.
/// [Type] is what the UseCase returns.
/// [Params] is what the UseCase requires to run.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Use this when a UseCase doesn't require any parameters.
class NoParams {}
