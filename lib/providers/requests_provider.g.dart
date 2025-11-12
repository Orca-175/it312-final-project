// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RequestsNotifier)
const requestsProvider = RequestsNotifierFamily._();

final class RequestsNotifierProvider
    extends $NotifierProvider<RequestsNotifier, Requests> {
  const RequestsNotifierProvider._({
    required RequestsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'requestsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$requestsNotifierHash();

  @override
  String toString() {
    return r'requestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RequestsNotifier create() => RequestsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Requests value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Requests>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RequestsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$requestsNotifierHash() => r'5aeccce60fecded883b92bd69746d8f9c2f3577e';

final class RequestsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          RequestsNotifier,
          Requests,
          Requests,
          Requests,
          int
        > {
  const RequestsNotifierFamily._()
    : super(
        retry: null,
        name: r'requestsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RequestsNotifierProvider call(int id) =>
      RequestsNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'requestsProvider';
}

abstract class _$RequestsNotifier extends $Notifier<Requests> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  Requests build(int id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<Requests, Requests>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Requests, Requests>,
              Requests,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
