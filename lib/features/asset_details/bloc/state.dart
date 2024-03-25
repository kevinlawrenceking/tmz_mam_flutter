part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class AssetDetailsFailureState extends BlocState {
  final Failure failure;

  AssetDetailsFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class AssetDetailsLoadedState extends BlocState {
  final AssetDetailsModel model;

  AssetDetailsLoadedState({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}

class AssetDetailsLoadingState extends BlocState {}
