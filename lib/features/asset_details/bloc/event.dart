part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAssetDetailsEvent extends BlocEvent {
  final String assetID;

  LoadAssetDetailsEvent({
    required this.assetID,
  });

  @override
  List<Object?> get props => [assetID];
}
