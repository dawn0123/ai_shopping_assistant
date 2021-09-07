import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

late GoogleSignIn googleSignIn = GoogleSignIn();

String? imageUrl;
String? name;

String? uid;

String? userEmail;

String? location;
String? province;

FirebaseAuth _auth = FirebaseAuth.instance;

Future getUser() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool authSignedIn = prefs.getBool('auth') ?? false;

  final User? user = _auth.currentUser;

  if (authSignedIn == true) {
    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;
    }
  }
}

Future<User?> registerWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();
  User? user;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;
    }

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('An account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }

  return user;
}

void resetPassword(String email){
  _auth.sendPasswordResetEmail(email: email);
}

Future<User?> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();
  User? user;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth', true);

      await FirebaseFirestore.instance
          .collection('Users').doc(uid).collection('info').doc(uid).get()
          .then((DocumentSnapshot ds) => {
        location = ds.get('location'),
        province = ds.get('province')
      });

    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}

Future<User?> signInWithGoogle(loc, prov) async {
  // Initialize Firebase
  await Firebase.initializeApp();
  User? user;

  location = loc;
  province = prov;

  // The `GoogleAuthProvider` can only be used while running on the web
  GoogleAuthProvider authProvider = GoogleAuthProvider();

  try {
    final UserCredential userCredential =
    await _auth.signInWithPopup(authProvider);

    user = userCredential.user;
  } catch (e) {
    print(e);
  }

  if (user != null) {
    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid).get()
        .then((DocumentSnapshot documentSnapshot) =>
    {
      if(!documentSnapshot.exists){
        print("user added"),
        FirebaseFirestore.instance.collection('Users').doc(uid).collection("info").doc(uid).set(
            {
              'fname': name!.split(" ")[0],
              'lname':name!.split(" ")[1],
              'email':userEmail,
              'bday':"*missing",
              'location': location,
              'province' : province
            }
        )
      }
      else{
        print("user exists in database")
      }
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);
  }

  return user;
}

Future<String> signOut() async {
  try {
    await _auth.signOut().then((value) => {
    if(uid != null)
      uid = null,
    if(userEmail != null)
      userEmail = null,
    if(name != null)
      name = null,
    if(imageUrl != null)
      imageUrl = null
  });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);
  return 'User signed out';
  }
  catch (e) {
    print("Sign out error: $e");
    return 'Error signing out. Try again.';
  }
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;

  print("User signed out of Google account");
}