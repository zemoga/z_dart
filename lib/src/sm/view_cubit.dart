import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../core.dart';
import 'rope.dart';

abstract class ViewCubit<T> extends Cubit<T> {
  ViewCubit(T state) : super(state);

  final _ropes = <Rope>[];
  final _ropeSubs = <StreamSubscription>[];

  @override
  Future<void> close() {
    for (var sub in _ropeSubs) {
      sub.cancel();
    }
    for (var rope in _ropes) {
      rope.close();
    }
    return super.close();
  }
}

extension RopeExt<I, O> on Rope<I, O> {
  void listenResource(
    ViewCubit cubit, {
    void Function(Resource<O> value)? onResource,
  }) {
    cubit._ropeSubs.add(stream.listen(onResource ?? (r) {}));
    cubit._ropes.add(this);
  }
}
