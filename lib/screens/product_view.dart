import 'package:applist/data/product_model.dart';
import 'package:applist/theme/font.dart';
import 'package:applist/widgets/costum_text_field.dart';
import 'package:flutter/material.dart';
import 'package:applist/theme/font.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Map<String, dynamic> product = {
    'id': 1,
    'name': 'Aqua',
    'price': 5000,
    'stock': 10,
    'description':
        'Aqua adalah minuman yang sangat sehat, karena terbuat dari air yang sudah diolah dengan baik.'
  };

  List<Product> products = [
    Product(
        id: 1,
        name: 'Aqua',
        price: 5000,
        stock: 10,
        description:
            'Aqua adalah minuman yang sangat sehat, karena terbuat dari air yang sudah diolah dengan baik.'),
    Product(
        id: 2,
        name: 'Mizone',
        price: 6000,
        stock: 13,
        description:
            'Mizone adalah minuman untuk mengganti cairan tubuh yang hilang.'),
  ];

  void create(Map<String, dynamic> value) {
    try {
      // generate random id
      int id = DateTime.now().millisecondsSinceEpoch;
      Map<String, dynamic> data = {...value}; // copy value
      data['id'] = id;

      // sesuaikan tipe datanya, karena data dari value adalah string
      data['price'] = int.parse(value['price']);
      data['stock'] = int.parse(value['stock']);

      // add to list
      final product = Product.fromJson(data);
      products.add(product);
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  void update(int id, Map<String, dynamic> value) {
    try {
      int index = products.indexWhere((element) => element.id == id);
      Map<String, dynamic> data = {...value}; // copy value

      // sesuaikan tipe datanya, karena data dari value adalah string
      data['id'] = id;
      data['price'] = int.parse(value['price']);
      data['stock'] = int.parse(value['stock']);

      // update
      if (index != -1) {
        final product = Product.fromJson(data);
        products[index] = product;
        setState(() {});
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void remove(int id) {
    try {
      products.removeWhere((e) => e.id == id);
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Produk (${products.length})'),
      ),
      body: products.isEmpty
          ? const Center(
              child: Text('Tidak ada data produk'),
            )
          : ListView(
              children: List.generate(products.length, (i) {
                final product = products[i];
                String name = product.name ?? '';
                int price = product.price ?? 0;

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,),
                          Text(
                            'Rp$price',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FormProduct(product: product)))
                                    .then((value) {
                                  if (value != null) {
                                    update(product.id!, value);
                                  }
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.edit,
                                ),
                              )),
                          GestureDetector(
                              onTap: () => remove(product.id!),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FormProduct()))
              .then((value) {
            if (value != null) {
              create(value);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormProduct extends StatefulWidget {
  final Product? product;
  const FormProduct({super.key, this.product});

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final name = TextEditingController();
  final price = TextEditingController();
  final stock = TextEditingController();
  final description = TextEditingController();

  @override
  void initState() {
    if (widget.product?.id != null) {
      name.text = widget.product!.name ?? '';
      price.text = widget.product!.price.toString();
      stock.text = widget.product!.stock.toString();
      description.text = widget.product!.description ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.product?.id == null ? 'Tambah Produk' : 'Edit Produk'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomTextField(
            controller: name,
            hint: 'Ketik Nama Produk',
          ),
          CustomTextField(
            controller: price,
            hint: 'Ketik harga',
            type: TextInputType.number,
          ),
          CustomTextField(
            controller: stock,
            hint: 'Ketik jumlah produk',
            type: TextInputType.number,
          ),
          CustomTextField(controller: description, hint: 'Ketik deskripsi'),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'name': name.text,
              'price': price.text,
              'stock': stock.text,
              'description': description.text,
            });
          },
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
