// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StudentDetailsNotifier)
const studentDetailsProvider = StudentDetailsNotifierFamily._();

final class StudentDetailsNotifierProvider
    extends $NotifierProvider<StudentDetailsNotifier, StudentDetails> {
  const StudentDetailsNotifierProvider._({
    required StudentDetailsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'studentDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studentDetailsNotifierHash();

  @override
  String toString() {
    return r'studentDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StudentDetailsNotifier create() => StudentDetailsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudentDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudentDetails>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StudentDetailsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studentDetailsNotifierHash() =>
    r'c57b7940000bd9959ec101f29f9d1f1e5f30a332';

final class StudentDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          StudentDetailsNotifier,
          StudentDetails,
          StudentDetails,
          StudentDetails,
          int
        > {
  const StudentDetailsNotifierFamily._()
    : super(
        retry: null,
        name: r'studentDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StudentDetailsNotifierProvider call(int id) =>
      StudentDetailsNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'studentDetailsProvider';
}

abstract class _$StudentDetailsNotifier extends $Notifier<StudentDetails> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  StudentDetails build(int id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<StudentDetails, StudentDetails>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StudentDetails, StudentDetails>,
              StudentDetails,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
