import 'package:provider/provider.dart';
import 'package:wisata_candi_nada/providers/auth_provider.dart';
import 'package:wisata_candi_nada/providers/favorite_provider.dart';
import 'package:wisata_candi_nada/screen/main_screen.dart'; // Import MainScreen
import 'package:wisata_candi_nada/screen/home_screen.dart';
import 'package:wisata_candi_nada/screen/favorite_screen.dart';
import 'package:wisata_candi_nada/screen/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
@@ -29,7 +31,53 @@ class MyApp extends StatelessWidget {
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(), // Jalankan MainScreen di sini
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}