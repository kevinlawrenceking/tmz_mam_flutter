part of 'global_bloc.dart';

@immutable
abstract class GlobalBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends GlobalBlocState {}

class DownloadSelectedAssetsState extends GlobalBlocState {}

class ResetState extends GlobalBlocState {}
