import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Dummy data cart (sudah diperbaiki tipe datanya)
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Signature Cream Brew",
      "category": "Coffee",
      "price": 35000,
      "qty": 1,
      "image": "assets/img/kopi_1.png", // ganti sesuai asset kamu
    },
    {
      "name": "Blush Bite Croissant",
      "category": "Food",
      "price": 22000,
      "qty": 1,
      "image": "assets/img/makanan_1.png",
    }
  ];

  // ❗ PERBAIKAN: kasih casting num supaya aman
  int get subtotal {
    return cartItems.fold(
      0,
      (sum, item) =>
          sum + ((item["price"] as num) * (item["qty"] as num)).toInt(),
    );
  }

  double get tax => subtotal * 0.12;

  double get total => subtotal + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Keranjang",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: const Color(0xFF2E7D5A),
        elevation: 0,
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7EFEC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          item["image"],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // TEXT AREA
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item["category"],
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Rp ${item["price"]}",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2E7D5A)),
                            ),
                          ],
                        ),
                      ),

                      // QTY BUTTON
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 20),
                              onPressed: () {
                                setState(() {
                                  if (item["qty"] > 1) {
                                    item["qty"]--;
                                  }
                                });
                              },
                            ),
                            Text("${item["qty"]}",
                                style: const TextStyle(fontSize: 16)),
                            IconButton(
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: () {
                                setState(() {
                                  item["qty"]++;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          // TOTAL CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal", style: TextStyle(fontSize: 16)),
                    Text("Rp $subtotal"),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Pajak 12%", style: TextStyle(fontSize: 16)),
                    Text("Rp ${tax.toInt()}"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Keseluruhan",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    Text(
                      "Rp ${total.toInt()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D5A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Lanjut Pembayaran (${cartItems.length} item)",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
