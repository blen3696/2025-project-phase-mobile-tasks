import 'package:flutter/material.dart';
import '../../../../colors.dart';
import '../../domain/entities/product.dart';
import '../../app/products_service.dart';
import '../widgets/size_selector.dart';

class DetailsPage extends StatelessWidget {
  final Product product;
  const DetailsPage({super.key, required this.product});

  Future<void> _delete(BuildContext context) async {
    final service = ProductsService();
    await service.delete(product.id as String);
    if (context.mounted) Navigator.pop(context, true);
  }

  Future<void> _openUpdate(BuildContext context) async {
    final changed = await Navigator.pushNamed(
      context,
      '/add-update',
      arguments: product,
    );
    if (changed == true && context.mounted) {
      Navigator.pop(context, true); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: product.image.startsWith('http')
                        ? Image.network(
                            product.image,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            product.image,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: MyColors.myBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.category,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Text('(${product.rating.toStringAsFixed(1)})'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizeBox(size: 35),
                          SizeBox(size: 36),
                          SizeBox(size: 37, isActive: true),
                          SizeBox(size: 38),
                          SizeBox(size: 39),
                          SizeBox(size: 40),
                          SizeBox(size: 41),
                          SizeBox(size: 42),
                          SizeBox(size: 43),
                          SizeBox(size: 44),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 13, height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _delete(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'DELETE',
                              style: TextStyle(fontSize: 14, color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _openUpdate(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.myBlue,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'UPDATE',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
