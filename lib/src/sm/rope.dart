import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../core.dart';

@Deprecated(
  'Use `on<Event>` mechanism together with'
  '`Emitter.forEachAsResource<T>` extension',
)
abstract class Rope<I, O> extends Bloc<I, Resource<O>> {
  Rope() : super(Resource.initial());

  void execute(I param) => super.add(param);

  @override
  Stream<Transition<I, Resource<O>>> transformEvents(
    Stream<I> events,
    transitionFn,
  ) {
    return events.switchMap(transitionFn);
  }

  @override
  Stream<Resource<O>> mapEventToState(I event) {
    return operation(event)
        .map((event) => Resource.data(event))
        .onErrorReturnWith(
          (error, _) => Resource.error(
            error is Exception ? error : Exception(error.toString()),
          ),
        )
        .startWith(Resource.loading());
  }

  Stream<O> operation(I param);
}

@Deprecated(
  'Use `on<Event>` mechanism together with'
  '`Emitter.forEachAsResource<T>` extension',
)
class SimpleRope<I, O> extends Rope<I, O> {
  final Stream<O> Function(I) operationMapper;

  SimpleRope._(this.operationMapper) : super();

  SimpleRope.flow(
    Stream<O> Function(I input) operationMapper,
  ) : this._(operationMapper);

  SimpleRope.single(
    Future<O> Function(I input) operationMapper,
  ) : this._((param) => operationMapper(param).asStream());

  @override
  Stream<O> operation(I param) => operationMapper(param);
}
