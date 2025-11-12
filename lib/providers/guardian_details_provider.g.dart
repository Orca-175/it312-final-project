// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardian_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GuardianDetailsNotifier)
const guardianDetailsProvider = GuardianDetailsNotifierFamily._();

final class GuardianDetailsNotifierProvider
    extends $NotifierProvider<GuardianDetailsNotifier, GuardianDetails> {
  const GuardianDetailsNotifierProvider._({
    required GuardianDetailsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'guardianDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$guardianDetailsNotifierHash();

  @override
  String toString() {
    return r'guardianDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GuardianDetailsNotifier create() => GuardianDetailsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuardianDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuardianDetails>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GuardianDetailsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$guardianDetailsNotifierHash() =>
    r'6abb24e26c64ba91cd92737d73ffd29d22a44e8d';

final class GuardianDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GuardianDetailsNotifier,
          GuardianDetails,
          GuardianDetails,
          GuardianDetails,
          int
        > {
  const GuardianDetailsNotifierFamily._()
    : super(
        retry: null,
        name: r'guardianDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GuardianDetailsNotifierProvider call(int id) =>
      GuardianDetailsNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'guardianDetailsProvider';
}

abstract class _$GuardianDetailsNotifier extends $Notifier<GuardianDetails> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  GuardianDetails build(int id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<GuardianDetails, GuardianDetails>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GuardianDetails, GuardianDetails>,
              GuardianDetails,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
