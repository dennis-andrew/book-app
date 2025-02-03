abstract class AddressEvent {}

class FetchAddressesEvent extends AddressEvent {}

class CreateAddressEvent extends AddressEvent {
  final String block;
  final String street;
  final String city;
  final String pincode;

  CreateAddressEvent({required this.block, required this.street, required this.city, required this.pincode});
}

class UpdateAddressEvent extends AddressEvent {
  final String id;
  final String block;
  final String street;
  final String city;
  final String pincode;

  UpdateAddressEvent({required this.id, required this.block, required this.street, required this.city, required this.pincode});
}

class DeleteAddressEvent extends AddressEvent {
  final String id;

  DeleteAddressEvent({required this.id});
}
