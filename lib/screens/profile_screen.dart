
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/providers/auth_provider.dart';
import 'package:wisata_candi/providers/favorite_provider.dart';
import 'package:wisata_candi/screens/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final favoriteCount = context.watch<FavoriteProvider>().count;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'images/placeholder_image.png',
                            ),
                          ),
                        ),
                        if (auth.isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Username
                _buildInfoRow(
                  context,
                  icon: Icons.lock,
                  iconColor: Colors.amber,
                  label: 'Pengguna',
                  value: auth.isSignedIn ? auth.username : '',
                ),
                const Divider(),

                // Name
                _buildInfoRow(
                  context,
                  icon: Icons.person,
                  iconColor: Colors.blue,
                  label: 'Nama',
                  value: auth.isSignedIn ? auth.username : '',
                  showEdit: auth.isSignedIn,
                ),
                const Divider(),

                // Favorite count
                _buildInfoRow(
                  context,
                  icon: Icons.favorite,
                  iconColor: Colors.red,
                  label: 'Favorit',
                  value: '$favoriteCount',
                ),
                const Divider(),
                const SizedBox(height: 20),

                // Sign In / Sign Out
                auth.isSignedIn
                    ? TextButton(
                        onPressed: () {
                          context.read<AuthProvider>().signOut();
                          context.read<FavoriteProvider>().clearAll();
                        },
                        child: const Text('Sign Out'),
                      )
                    : TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text('Sign In'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    bool showEdit = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              ': $value',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          if (showEdit) const Icon(Icons.edit),
        ],
      ),
    );
  }
}
