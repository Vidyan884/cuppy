import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  static const Color green = Color(0xFF2E7D5A);

  @override
  Widget build(BuildContext context) {
    // data dummy food sesuai Figma
    final foods = <_FoodItem>[
      _FoodItem(
        image: 'assets/img/makanan_1.png', // Blush Bite Croissant
        name: 'Blush Bite Croissant',
        price: 'Rp xx',
      ),
      _FoodItem(
        image: 'assets/img/makanan_2.png', // ganti sesuai asset-mu
        name: 'Veggie Chili Mix',
        price: 'Rp xx',
      ),
      _FoodItem(
        image: 'assets/img/makanan_3.png',
        name: 'Burger Munch Set',
        price: 'Rp xx',
      ),
      _FoodItem(
        image: 'assets/img/makanan_4.png',
        name: 'Toasty Morning',
        price: 'Rp xx',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Food',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),

          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // GRID FOOD
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                itemCount: foods.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final item = foods[index];
                  return _FoodCard(
                    image: item.image,
                    name: item.name,
                    price: item.price,
                    onAdd: () {
                      // sementara: snackBar aja dulu
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.name} ditambahkan')),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ============================
   MODEL DATA SEDERHANA
=============================== */

class _FoodItem {
  final String image;
  final String name;
  final String price;

  _FoodItem({
    required this.image,
    required this.name,
    required this.price,
  });
}

/* ============================
   KARTU FOOD
=============================== */

class _FoodCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final VoidCallback onAdd;

  const _FoodCard({
    required this.image,
    required this.name,
    required this.price,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    const Color green = FoodScreen.green;

    return Container(
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          // isi utama
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset(
                    image,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Food',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // tombol plus di kanan bawah
          Positioned(
            right: 12,
            bottom: 12,
            child: GestureDetector(
              onTap: onAdd,
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  size: 20,
                  color: green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}