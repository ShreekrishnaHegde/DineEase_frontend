
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
  final SupabaseClient _supabaseClient=Supabase.instance.client;

  //Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(String email,String password) async{
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password
    );
  }
  //Sign Up with email and password
  Future<AuthResponse> signUpWithEmailPassword({
    required String email,
    required String password,
    required String fullname,
    required String role,
    }) async{
    final response= await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          "full-name":fullname,
          "role":role,
        },
    );
    return response;
  }
  //SignOut
  Future<void> signOut() async{
    return await _supabaseClient.auth.signOut();
  }
  //Get User email
  String? getCurrentUserEmail(){
    final session=_supabaseClient.auth.currentSession;
    final user=session?.user;
    return user?.email;
  }
}