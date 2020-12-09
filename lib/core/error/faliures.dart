import 'package:equatable/equatable.dart';
//second
abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super([properties]);
}

class SelectionFailure extends Failure{}
class ServerFailure extends Failure{}
class NetworkFailure extends Failure{}