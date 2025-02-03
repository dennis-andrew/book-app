abstract class AddressState {}

class AddressInitialState extends AddressState {}

class AddressLoadingState extends AddressState {}

class AddressLoadedState extends AddressState {
  final List<dynamic> addresses;

  AddressLoadedState({required this.addresses});
}

class AddressErrorState extends AddressState {
  final String message;

  AddressErrorState({required this.message});
}
