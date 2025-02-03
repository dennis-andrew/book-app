import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final String baseUrl = 'https://crudcrud.com/api/2b433206bafd4ea1b908d67db5206f7c/addresses';

  AddressBloc() : super(AddressInitialState()) {
    on<FetchAddressesEvent>(_onFetchAddresses);
    on<CreateAddressEvent>(_onCreateAddress);
    on<UpdateAddressEvent>(_onUpdateAddress);
    on<DeleteAddressEvent>(_onDeleteAddress);
  }

  void _onFetchAddresses(event, emit) async {
    emit(AddressLoadingState());
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> addresses = json.decode(response.body);
        emit(AddressLoadedState(addresses: addresses));
      } else {
        emit(AddressErrorState(message: 'Failed to load addresses'));
      }
    } catch (e) {
      emit(AddressErrorState(message: e.toString()));
    }
  }

  void _onCreateAddress(CreateAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'block': event.block,
          'street': event.street,
          'city': event.city,
          'pincode': event.pincode,
        }),
      );

      if (response.statusCode == 201) {
        add(FetchAddressesEvent());  // Refresh the address list
      } else {
        emit(AddressErrorState(message: 'Failed to create address'));
      }
    } catch (e) {
      emit(AddressErrorState(message: e.toString()));
    }
  }

  void _onUpdateAddress(UpdateAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${event.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'block': event.block,
          'street': event.street,
          'city': event.city,
          'pincode': event.pincode,
        }),
      );

      if (response.statusCode == 200) {
        add(FetchAddressesEvent());  // Refresh the address list
      } else {
        emit(AddressErrorState(message: 'Failed to update address'));
      }
    } catch (e) {
      emit(AddressErrorState(message: e.toString()));
    }
  }

  void _onDeleteAddress(DeleteAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    try {
      final response = await http.delete(Uri.parse('$baseUrl/${event.id}'));
      if (response.statusCode == 200) {
        add(FetchAddressesEvent());  // Refresh the address list
      } else {
        emit(AddressErrorState(message: 'Failed to delete address'));
      }
    } catch (e) {
      emit(AddressErrorState(message: e.toString()));
    }
  }
}
