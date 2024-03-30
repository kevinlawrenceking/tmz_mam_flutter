part of 'global_bloc.dart';

@immutable
abstract class GlobalBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DownloadSelectedAssetsEvent extends GlobalBlocEvent {}
