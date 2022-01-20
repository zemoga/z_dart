import 'package:bloc/bloc.dart';
import 'package:z_dart/core.dart';

extension ResourceEmitter<State> on Emitter<State> {
  /// Subscribes to the provided [stream] and invokes the [onResource] callback
  /// when the [stream] emits new data.
  ///
  /// [onEachAsResource] completes when the event handler is cancelled or when
  /// the provided [stream] has ended.
  Future<void> onEachAsResource<T>(
    Stream<T> stream, {
    required void Function(Resource<T> resource) onResource,
  }) {
    onResource(Resource.loading());
    return onEach<T>(
      stream,
      onData: (data) {
        onResource(Resource.data(data));
      },
      onError: (error, _) {
        final _error = error is Exception ? error : Exception(error.toString());
        onResource(Resource.error(_error));
      },
    );
  }

  /// Subscribes to the provided [stream] and invokes the [onResource] callback
  /// when the [stream] emits new data and the result of [onResource] is emitted.
  ///
  /// [forEachAsResource] completes when the event handler is cancelled or when
  /// the provided [stream] has ended.
  Future<void> forEachAsResource<T>(
    Stream<T> stream, {
    required State Function(Resource<T> resource) onResource,
  }) {
    return onEachAsResource<T>(
      stream,
      onResource: (resource) => call(onResource(resource)),
    );
  }
}
