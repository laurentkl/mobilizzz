import 'package:flutter/material.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/pages/edit_profile_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final user = authProvider.user;
        return Container(
          height: 150,
          color: Colors.blueGrey[100],
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                  },
                  child: ClipOval(
                    child: Image.network(
                      'https://scontent.flgg1-1.fna.fbcdn.net/v/t1.18169-9/13892206_10154456647559265_4029653671963686791_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_ohc=1VD0H9M90TIQ7kNvgH-39Ls&_nc_ht=scontent.flgg1-1.fna&oh=00_AYDy5QgOovbSQiRx34znEfH39mI2Dbp7NRT5N8Op85_O5w&oe=6683FF31', // Replace with your asset path
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user?.firstName ?? 'No Name',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user?.lastName ?? 'No Last Name',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
