import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/address.dart';
import '../../../data/repositories/addresses_repository.dart';

final addressesRepositoryProvider = Provider<AddressesRepository>((ref) {
  return AddressesRepository();
});

final addressesProvider = StreamProvider<List<Address>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream.value([]);
  }
  final repository = ref.watch(addressesRepositoryProvider);
  return repository.streamUserAddresses(user.uid);
});