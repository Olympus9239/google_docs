import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone_flutter/colors.dart';
import 'package:google_docs_clone_flutter/repository/auth_repositor.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref){
        ref.read(authRepositoryProvider).signInWithGoogle();

  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   // ref.watch(authRepositoryProvider).signInWithGoogle();
    return  Scaffold(
        body: Center(
          child: ElevatedButton.icon(
            onPressed: ()=>signInWithGoogle(ref), 
             icon: Image.asset('assets/images/g_logo.png',height: 20,),
              label: Text("Sign in with Google",
              
              style: TextStyle(
                color: kBlackColor,
              ),
              
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kWhiteColor,
                minimumSize: const Size(150, 50),
              ),
            
            


              ),
              
        ),
    );
  }
}