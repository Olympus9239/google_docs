import 'dart:convert';

import 'package:google_docs_clone_flutter/constants.dart';
import 'package:google_docs_clone_flutter/models/error_model.dart';
import 'package:google_docs_clone_flutter/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
    (ref) => AuthRepository(googleSignIn: GoogleSignIn(), client: Client()));

    final userProvider=StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  AuthRepository({required Client client, required GoogleSignIn googleSignIn})
      : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error=ErrorModel(error: 'Some unexpected error occured', data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        // print(user.email);
        // print(user.displayName);
        // print(user.photoUrl);
        final userAcc = UserModel(
          email: user.email,
          name: user.displayName!,
          profilePic: user.photoUrl!,
          uid: '',
          token: '',
        );
        var res = await _client.post(Uri.parse('$host/api/signup'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });
            switch(res.statusCode){
              case 200:
              final newUser=userAcc.copyWith(
                uid: jsonDecode(res.body)['user']['_id'],
              );
              error=ErrorModel(error: null, data: newUser);
              break;
              default:
              throw 'some Error Occuered';
              // add more cases for production level apps like case 300,400 etc etc
            }
      }
    } catch (e) {
     error=ErrorModel(error: e.toString(), data:null);

    }
    return error;
  }
}
