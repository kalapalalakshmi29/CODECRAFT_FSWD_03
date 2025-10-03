import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    final result = await ApiService.login(email, password);
    
    if (result['success']) {
      _currentUser = User.fromJson(result['user']);
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    final result = await ApiService.register(name, email, phone, password);
    
    if (result['success']) {
      _currentUser = User.fromJson(result['user']);
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() async {
    await ApiService.logout();
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> addAddress(Address address) async {
    if (_currentUser != null) {
      final success = await ApiService.addAddress(address);
      if (success) {
        // Refresh user data
        final updatedUser = await ApiService.getProfile();
        if (updatedUser != null) {
          _currentUser = updatedUser;
          notifyListeners();
        }
      }
    }
  }

  Address? get defaultAddress {
    if (_currentUser?.addresses.isNotEmpty == true) {
      try {
        return _currentUser!.addresses.firstWhere((addr) => addr.isDefault);
      } catch (e) {
        return _currentUser!.addresses.first;
      }
    }
    return null;
  }

  Future<void> loadUserProfile() async {
    final user = await ApiService.getProfile();
    if (user != null) {
      _currentUser = user;
      _isLoggedIn = true;
      notifyListeners();
    }
  }
}