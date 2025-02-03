import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_app/bloc/address/address_bloc.dart'; 
import 'package:book_app/bloc/address/address_event.dart'; 
import 'package:book_app/bloc/address/address_state.dart'; 

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Addresses'),
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is AddressLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddressLoadedState) {
              return ListView.builder(
                itemCount: state.addresses.length,
                itemBuilder: (context, index) {
                  final address = state.addresses[index];
                  return ListTile(
                    title: Text('${address['block']}, ${address['street']}'),
                    subtitle: Text('${address['city']}, ${address['pincode']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<AddressBloc>().add(DeleteAddressEvent(id: address['_id']));
                      },
                    ),
                    onTap: () {
                      showAddressModal(
                        context,
                        id: address['_id'],
                        block: address['block'],
                        street: address['street'],
                        city: address['city'],
                        pincode: address['pincode'],
                      );
                    },
                  );
                },
              );
            } else if (state is AddressErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No addresses available'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddressModal(context);
          },
          child: const Icon(Icons.add),
        ),
      );
  }

  void showAddressModal(BuildContext context, {String? id, String? block, String? street, String? city, String? pincode}) {
    final formKey = GlobalKey<FormState>();
    String newBlock = block ?? '', newStreet = street ?? '', newCity = city ?? '', newPincode = pincode ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Block/Home No.'),
                    initialValue: newBlock,
                    onSaved: (value) => newBlock = value ?? '',
                    validator: (value) => value!.isEmpty ? 'Please enter block/home no.' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Street Address'),
                    initialValue: newStreet,
                    onSaved: (value) => newStreet = value ?? '',
                    validator: (value) => value!.isEmpty ? 'Please enter street address' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'City'),
                    initialValue: newCity,
                    onSaved: (value) => newCity = value ?? '',
                    validator: (value) => value!.isEmpty ? 'Please enter city' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Pincode'),
                    initialValue: newPincode,
                    onSaved: (value) => newPincode = value ?? '',
                    validator: (value) => value!.isEmpty ? 'Please enter pincode' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (id == null) {
                          context.read<AddressBloc>().add(
                            CreateAddressEvent(
                              block: newBlock,
                              street: newStreet,
                              city: newCity,
                              pincode: newPincode,
                            ),
                          );
                        } else {
                          context.read<AddressBloc>().add(
                            UpdateAddressEvent(
                              id: id,
                              block: newBlock,
                              street: newStreet,
                              city: newCity,
                              pincode: newPincode,
                            ),
                          );
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(id == null ? 'Add Address' : 'Update Address'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}