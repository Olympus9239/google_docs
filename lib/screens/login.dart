import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone_flutter/colors.dart';
import 'package:google_docs_clone_flutter/repository/auth_repositor.dart';
import 'package:google_docs_clone_flutter/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref,BuildContext context)async{
      final sMessenger=ScaffoldMessenger.of(context);
      final navigator=Navigator.of(context);
     final errorModel= await ref.read(authRepositoryProvider).signInWithGoogle();
      if(errorModel.error==null){
        ref.read(userProvider.notifier).update((state) => errorModel.data);
        navigator.push(MaterialPageRoute(builder: (context)=>const HomeScreen()));
      }else{
         sMessenger.showSnackBar(
          SnackBar(content: Text(errorModel.error!))
         );
      }

  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   // ref.watch(authRepositoryProvider).signInWithGoogle();
    return  Scaffold(
        body: Center(
          child: ElevatedButton.icon(
            onPressed: ()=>signInWithGoogle(ref,context), 
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