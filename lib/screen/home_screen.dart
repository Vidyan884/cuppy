import 'package:flutter/material.dart';
import 'coffee_screen.dart';
import 'non_coffee_screen.dart';
import 'keranjang_screen.dart';
import 'history_screen.dart';
import 'profil_screen.dart';
import 'food_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.userName = 'Asep',
    this.userEmail = 'asep@example.com',
  });

  /// nama & email user yang login (sementara ada default)
  final String userName;
  final String userEmail;

  static const Color green = Color(0xFF2E7D5A);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- HEADER ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, kak ${widget.userName}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Meja XX / Take-Away',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  // ---------------- NOTIFICATION BUTTON ----------------
                  Container(
                    decoration: BoxDecoration(
                      color: HomeScreen.green,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- ILLUSTRATION ----------------
              Center(
                child: Image.asset(
                  'assets/img/iPhone 14 & 15 Pro - 1.png',
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),

              // ---------------- SEARCH BAR ----------------
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari menu favoritmu...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: HomeScreen.green,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ---------------- TERLARIS ----------------
              const Text(
                'Terlaris',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // LIST TERLARIS HORIZONTAL
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _BestSellerCard(
                      image: 'assets/img/kopi_1.png',
                      name: 'Signature Cream Brew',
                      price: 'Rp 25.000',
                    ),
                    SizedBox(width: 12),
                    _BestSellerCard(
                      image: 'assets/img/makanan_1.png',
                      name: 'Blush Bite Croissant',
                      price: 'Rp 15.000',
                    ),
                    SizedBox(width: 12),
                    _BestSellerCard(
                      image: 'assets/img/kopi_2.png',
                      name: 'Caramel Swirl Latte',
                      price: 'Rp xx',
                    ),
                    SizedBox(width: 12),
                    _BestSellerCard(
                      image: 'assets/img/kopi_3.png',
                      name: 'Americano',
                      price: 'Rp xx',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ---------------- KATEGORI ----------------
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // LIST KATEGORI HORIZONTAL
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _CategoryCard(
                      icon: Icons.local_cafe,
                      label: 'Coffee',
                      itemCount: 4,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CoffeeScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _CategoryCard(
                      icon: Icons.icecream_outlined,
                      label: 'Non-coffee',
                      itemCount: 4,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NonCoffeeScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _CategoryCard(
                      icon: Icons.lunch_dining_outlined,
                      label: 'Food',
                      itemCount: 4,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FoodScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ---------------- BOTTOM NAVIGATION ----------------
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HomeScreen.green,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });

          if (i == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          }

          if (i == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            );
          }

          if (i == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfilScreen(
                  initialName: widget.userName,
                  initialEmail: widget.userEmail,
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

/* ============================================================
   BESTSELLER CARD  
============================================================== */

class _BestSellerCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const _BestSellerCard({
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: HomeScreen.green,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* ============================================================
   CATEGORY CARD
============================================================== */

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int itemCount;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        width: 140,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: HomeScreen.green, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: HomeScreen.green, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$itemCount item',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}