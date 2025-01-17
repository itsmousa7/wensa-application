import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wensa/favorite.dart';
import 'login.dart';
import 'package:image_picker/image_picker.dart';
import 'navigationbar.dart';
import 'main.dart';

class Profilepage extends StatefulWidget {


   Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final TextEditingController _nameController = TextEditingController();


  late User loggedInUser;
  String? uidT;
  String? userName;
  String? imageUrl;
  File? selectedImage;
  bool isLoading = true;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        uidT = loggedInUser.uid;
        await fetchUserProfile();
      }
    } catch (e) {
      print('Error getting current user: $e');
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      final userDoc = await _firestore.collection('users').doc(loggedInUser.uid).get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc.data()?['UserName'] ?? '';
          imageUrl = userDoc.data()?['ProfileImageURL'];
          _nameController.text = userName ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> selectProfileImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error selecting profile image: $e');
    }
  }

  Future<void> updateProfile() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter your name.')));
      return;
    }

    setState(() { isLoading = true; });
    try {
      String downloadURL = imageUrl ?? '';
      if (selectedImage != null) {
        Reference storageReference = _storage.ref().child('profile_images/${loggedInUser.uid}.jpg');
        await storageReference.putFile(selectedImage!);
        downloadURL = await storageReference.getDownloadURL();
      }

      // Update Firestore with new profile image URL and name
      await _firestore.collection('users').doc(uidT).update({
        'UserName': _nameController.text,  // Make sure this is the correct field for user name
        'ProfileImageURL': downloadURL,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));

      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigationbar()));
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile. Please try again.')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(  // Wrap the entire body in a SingleChildScrollView
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: ClipRRect(
                            child: Image.asset('images/profile.jpeg', fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 16,
                  child: GestureDetector(
                    onTap: selectProfileImage,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: button,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : (imageUrl != null ? NetworkImage(imageUrl!) : null),
                        child: selectedImage == Icon(Iconsax.profile_add,size: 90,) && imageUrl == null
                            ?null
                            : null
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Edit Name"),
                            content: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(hintText: 'Enter new name'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  updateProfile();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Save"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      title: Text(
                        userName ?? 'No name set',
                        style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary, 40),
                      ),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()

                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
                    },
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.bookmark, color: Theme.of(context).colorScheme.secondary),
                      title: Text("Saved", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Theme.of(context).colorScheme.background,
                            title: Text("Email",style:  AppTextStyles.satoshbig(Theme.of(context).colorScheme.secondary,20),),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Email: ${loggedInUser.email}",style:  AppTextStyles.satosh(Theme.of(context).colorScheme.secondary,),)
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.envelope, color: Theme.of(context).colorScheme.secondary),
                      title: Text("Email", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),

                  Divider(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Username",style:  AppTextStyles.satoshbig(Theme.of(context).colorScheme.secondary,20)),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Username: $userName",style:  AppTextStyles.satosh(Theme.of(context).colorScheme.secondary)),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.user, color: Theme.of(context).colorScheme.secondary),
                      title: Text("Username", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),

                  Divider(),

                  GestureDetector(
                    onTap: () async {
                      try {
                        await _auth.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error logging out: ${e.toString()}")));
                      }
                    },
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.doorOpen, color: Colors.red),
                      title: Text("Log out", style: TextStyle(color: Colors.red)),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.red, size: 25),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Reuseablelist extends StatelessWidget {
  final String text;
  final IconData icon;

  Reuseablelist({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: button),
      title: Text(text, style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary)),
      trailing: Icon(Icons.arrow_forward_ios_outlined, color: Theme.of(context).colorScheme.secondary, size: 25),
    );
  }
}
