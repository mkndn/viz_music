// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Folder _$FolderFromJson(Map<String, dynamic> json) {
  return _Folder.fromJson(json);
}

/// @nodoc
mixin _$Folder {
  String get path => throw _privateConstructorUsedError;
  bool get hasContent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FolderCopyWith<Folder> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FolderCopyWith<$Res> {
  factory $FolderCopyWith(Folder value, $Res Function(Folder) then) =
      _$FolderCopyWithImpl<$Res, Folder>;
  @useResult
  $Res call({String path, bool hasContent});
}

/// @nodoc
class _$FolderCopyWithImpl<$Res, $Val extends Folder>
    implements $FolderCopyWith<$Res> {
  _$FolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? hasContent = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      hasContent: null == hasContent
          ? _value.hasContent
          : hasContent // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FolderCopyWith<$Res> implements $FolderCopyWith<$Res> {
  factory _$$_FolderCopyWith(_$_Folder value, $Res Function(_$_Folder) then) =
      __$$_FolderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, bool hasContent});
}

/// @nodoc
class __$$_FolderCopyWithImpl<$Res>
    extends _$FolderCopyWithImpl<$Res, _$_Folder>
    implements _$$_FolderCopyWith<$Res> {
  __$$_FolderCopyWithImpl(_$_Folder _value, $Res Function(_$_Folder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? hasContent = null,
  }) {
    return _then(_$_Folder(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      hasContent: null == hasContent
          ? _value.hasContent
          : hasContent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Folder implements _Folder {
  const _$_Folder({this.path = '', this.hasContent = false});

  factory _$_Folder.fromJson(Map<String, dynamic> json) =>
      _$$_FolderFromJson(json);

  @override
  @JsonKey()
  final String path;
  @override
  @JsonKey()
  final bool hasContent;

  @override
  String toString() {
    return 'Folder(path: $path, hasContent: $hasContent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Folder &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.hasContent, hasContent) ||
                other.hasContent == hasContent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path, hasContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FolderCopyWith<_$_Folder> get copyWith =>
      __$$_FolderCopyWithImpl<_$_Folder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FolderToJson(
      this,
    );
  }
}

abstract class _Folder implements Folder {
  const factory _Folder({final String path, final bool hasContent}) = _$_Folder;

  factory _Folder.fromJson(Map<String, dynamic> json) = _$_Folder.fromJson;

  @override
  String get path;
  @override
  bool get hasContent;
  @override
  @JsonKey(ignore: true)
  _$$_FolderCopyWith<_$_Folder> get copyWith =>
      throw _privateConstructorUsedError;
}
