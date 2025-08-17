import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../colors.dart';
import '../../domain/entities/product.dart';
import '../../app/products_service.dart';
import '../widgets/custom_text_field.dart';

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

  File? selectedImage;

  bool get isUpdating => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (isUpdating) {
      final p = widget.product!;
      nameController.text = p.name;
      categoryController.text = p.category;
      priceController.text = p.price.toString();
      descriptionController.text = p.description;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> onAddOrUpdate() async {
    final svc = ProductsService()..init();
    final product = Product(
      id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: nameController.text.trim(),
      category: categoryController.text.trim(),
      price: double.tryParse(priceController.text.trim()) ?? 0,
      image:
          selectedImage?.path ??
          widget.product?.image ??
          'assets/images/product1.jpg',
      rating: widget.product?.rating ?? 4.0,
      description: descriptionController.text.trim(),
    );

    if (isUpdating) {
      await svc.update(product);
    } else {
      await svc.create(product);
    }

    if (mounted) Navigator.pop(context, true);
  }

  Future<void> onDelete() async {
    if (!isUpdating) return;
    final svc = ProductsService();
    await svc.delete(widget.product!.id as String);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: pickImage,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: MyColors.myLightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: selectedImage != null
                        ? Image.file(selectedImage!, fit: BoxFit.cover)
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image_outlined, size: 36),
                                SizedBox(height: 16),
                                Text(
                                  'Upload Image',
                                  style: TextStyle(fontSize: 12),
                                ),
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
