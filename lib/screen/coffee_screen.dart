import 'package:flutter/material.dart';
import 'product_detail_screen.dart'; // <-- pastikan file ini sudah ada

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  static const Color green = Color(0xFF2E7D5A);

  // contoh data produk
  List<Product> get _coffeeProducts => const [
        Product(
          name: "Signature Cream Brew",
          category: "Coffee",
          imagePath: "assets/img/kopi_1.png",
          description:
              "Perpaduan sempurna antara espresso yang kuat dan susu lembut, "
              "dengan lapisan krim khas untuk rasa yang halus dan kaya. "
              "Disajikan dengan es batu untuk sensasi menyegarkan di setiap tegukan.",
        ),
        Product(
          name: "Americano",
          category: "Coffee",
          imagePath: "assets/img/americano_1.png",
          description:
              "Espresso berkualitas tinggi yang dipadukan dengan air panas "
              "sehingga menghasilkan rasa kopi yang kuat namun tetap ringan.",
        ),
        Product(
          name: "Caramel Swirl Latte",
          category: "Coffee",
          imagePath: "assets/img/caramel_1.png",
          description:
              "Latte lembut dengan sirup karamel manis dan tekstur susu yang creamy.",
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final products = _coffeeProducts;

    return Scaffold(
      backgroundColor: green,
      body: SafeArea(
        child: Column(
          children: [
            // ======= APPBAR CUSTOM =======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Coffee",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ====== SEARCH BOX =======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ========== LIST COFFEE ===========
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return _CoffeeItem(product: p);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoffeeItem extends StatelessWidget {
  final Product product;

  const _CoffeeItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // IMAGE (kartu kiri, ikut di-tap juga)
          GestureDetector(
            onTap: () {
              // TAP KARTU / GAMBAR → DETAIL "PESAN SEKARANG"
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(
                    product: product,
                    isAddToCartMode: false, // mode pesan sekarang
                  ),
                ),
              );
            },
            child: Container(
              width: 90,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: Hero(
                tag: product.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    product.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          // TEXT BOX (tap ke detail juga)
          Expanded(
            child: GestureDetector(
              onTap: () {
                // TAP KOTAK HIJAU → DETAIL "PESAN SEKARANG"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      product: product,
                      isAddToCartMode: false,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: CoffeeScreen.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.category,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      "Rp xx",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // + BUTTON (khusus tambah ke keranjang)
          GestureDetector(
            onTap: () {
              // TAP PLUS → DETAIL "TAMBAH KE KERANJANG"
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(
                    product: product,
                    isAddToCartMode: true, // mode tambah ke keranjang
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: CoffeeScreen.green),
            ),
          ),
        ],
      ),
    );
  }
}