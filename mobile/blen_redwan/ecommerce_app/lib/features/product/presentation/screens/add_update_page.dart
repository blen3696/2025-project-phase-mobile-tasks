import '../../../../colors.dart';
import '../../domain/entities/product.dart';
import '../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddUpdatePage extends StatefulWidget {
  final Product? product;

  const AddUpdatePage({super.key, this.product});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.name;
      categoryController.text = widget.product!.category;
      priceController.text = widget.product!.price.toString();
      descriptionController.text = widget.product!.description;
    }
  }

  void onAddOrUpdate() {
    final product = Product(
      id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: nameController.text.trim(),
      category: categoryController.text.trim(),
      price: double.tryParse(priceController.text.trim()) ?? 0,
      image: widget.product?.image ?? 'assets/images/default.png',
      rating: widget.product?.rating ?? 4.0,
      description: descriptionController.text.trim(),
    );

    Navigator.pop(context, product);
  }

  void onDelete() {
    if (widget.product != null) {
      Navigator.pop(context, {'delete': widget.product!.id});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdating = widget.product != null;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
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
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: MyColors.myBlue,
                      ),
                    ),
                    const SizedBox(width: 100),
                    Text(
                      isUpdating ? 'Update Product' : 'Add Product',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: MyColors.myLightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_outlined, size: 36),
                          SizedBox(height: 16),
                          Text('Upload Image', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    CustomTextField(label: 'Name', controller: nameController),
                    CustomTextField(
                      label: 'Category',
                      controller: categoryController,
                    ),
                    CustomTextField(
                      label: 'Price',
                      isPrice: true,
                      controller: priceController,
                    ),
                    CustomTextField(
                      label: 'Description',
                      maxLines: 4,
                      controller: descriptionController,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: onAddOrUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.myBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        isUpdating ? 'UPDATE' : 'ADD',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (isUpdating)
                      OutlinedButton(
                        onPressed: onDelete,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(fontSize: 12),
                        ),
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
