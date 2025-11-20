import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final String imagePath;
  final String description;

  const Product({
    required this.name,
    required this.category,
    required this.imagePath,
    required this.description,
  });
}

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  /// true  = mode tambah ke keranjang
  /// false = mode pesan sekarang
  final bool isAddToCartMode;

  const ProductDetailScreen({
    super.key,
    required this.product,
    this.isAddToCartMode = false,
  });

  static const Color green = Color(0xFF2E7D5A);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = 'M';
  int quantity = 1;

  bool addOnCaramel = false;
  bool addOnCream = false;

  bool takeAway = true; // default sesuai Figma

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ========== HEADER + GAMBAR ==========
                    SizedBox(
                      height: 320,
                      child: Stack(
                        children: [
                          Container(
                            height: 230,
                            width: double.infinity,
                            color: ProductDetailScreen.green.withOpacity(0.9),
                          ),
                          // back + title
                          Positioned(
                            top: 16,
                            left: 16,
                            right: 16,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back,
                                        color: Colors.black),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    product.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // gambar minuman
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Hero(
                              tag: product.name,
                              child: Image.asset(
                                product.imagePath,
                                height: 260,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ========== DESKRIPSI ==========
                          const Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ========== SIZE ==========
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _SizeChip(
                                label: 'S',
                                selected: selectedSize == 'S',
                                onTap: () =>
                                    setState(() => selectedSize = 'S'),
                              ),
                              const SizedBox(width: 12),
                              _SizeChip(
                                label: 'M',
                                selected: selectedSize == 'M',
                                onTap: () =>
                                    setState(() => selectedSize = 'M'),
                              ),
                              const SizedBox(width: 12),
                              _SizeChip(
                                label: 'L',
                                selected: selectedSize == 'L',
                                onTap: () =>
                                    setState(() => selectedSize = 'L'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Small', style: TextStyle(fontSize: 12)),
                              Text('Medium', style: TextStyle(fontSize: 12)),
                              Text('Large', style: TextStyle(fontSize: 12)),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // ========== ADD-ONS ==========
                          const Text(
                            'Add-ons',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _AddOnChip(
                                label: 'Caramel Drizzle',
                                selected: addOnCaramel,
                                onTap: () => setState(
                                    () => addOnCaramel = !addOnCaramel),
                              ),
                              const SizedBox(width: 10),
                              _AddOnChip(
                                label: 'Whipped Cream',
                                selected: addOnCream,
                                onTap: () =>
                                    setState(() => addOnCream = !addOnCream),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // ========== OPSI ==========
                          const Text(
                            'Opsi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => takeAway = !takeAway),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: takeAway
                                      ? ProductDetailScreen.green
                                          .withOpacity(0.15)
                                      : const Color(0xFFE6E6E6),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  'Take-away',
                                  style: TextStyle(
                                    color: takeAway
                                        ? ProductDetailScreen.green
                                        : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '*Klik jika ingin dipesan untuk dibawa pulang',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ========== JUMLAH ==========
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _QtyButton(
                                icon: Icons.remove,
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() => quantity--);
                                  }
                                },
                              ),
                              const SizedBox(width: 28),
                              Text(
                                '$quantity',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 28),
                              _QtyButton(
                                icon: Icons.add,
                                onTap: () =>
                                    setState(() => quantity++),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ========== BOTTOM BUTTON ==========
            SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // sementara cuma SnackBar dulu
                      final modeText = widget.isAddToCartMode
                          ? 'ditambahkan ke keranjang'
                          : 'dipesan sekarang';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product.name} $modeText (qty: $quantity)',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ProductDetailScreen.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: Text(
                      widget.isAddToCartMode
                          ? 'Tambah ke keranjang'
                          : 'Pesan Sekarang',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SizeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SizeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: selected ? ProductDetailScreen.green : const Color(0xFFE6E6E6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _AddOnChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _AddOnChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? ProductDetailScreen.green : const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 22,
        backgroundColor: ProductDetailScreen.green,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}