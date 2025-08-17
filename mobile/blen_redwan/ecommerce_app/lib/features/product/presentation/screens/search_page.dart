import 'package:flutter/material.dart';
import '../../../../colors.dart';
import '../../app/products_service.dart';
import '../../domain/entities/product.dart';
import '../widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _query = TextEditingController();
  List<Product> _all = [];
  List<Product> _filtered = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
    _query.addListener(_applyFilter);
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final items = await ProductsService().getAll();
    setState(() {
      _all = items;
      _filtered = items;
      _loading = false;
    });
  }

  void _applyFilter() {
    final q = _query.text.trim().toLowerCase();
    setState(() {
      _filtered = _all.where((p) {
        return p.name.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q);
      }).toList();
    });
  }

  Future<void> _openDetails(Product p) async {
    final changed = await Navigator.pushNamed(
      context,
      '/details',
      arguments: p,
    );
    if (changed == true) await _load(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context, false),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: MyColors.myBlue,
                      ),
                    ),
                    const SizedBox(width: 80),
                    const Text(
                      'Search Product',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _query,
                      decoration: InputDecoration(
                        hintText: 'Leather',
                        suffixIcon: const Icon(
                          Icons.arrow_forward,
                          color: MyColors.myBlue,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: MyColors.myLightGrey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: MyColors.myLightGrey,
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: MyColors.myLightGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: MyColors.myBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.filter_list, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          itemCount: _filtered.length,
                          itemBuilder: (context, index) {
                            final product = _filtered[index];
                            return ProductCard(
                              product: product,
                              onTap: () => _openDetails(product),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
