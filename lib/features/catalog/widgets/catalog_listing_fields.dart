import 'package:flutter/material.dart';

/// The four text inputs for [CatalogListingForm] (Issue #138) — split
/// out to stay under the file line cap.
class CatalogListingFields extends StatelessWidget {
  final TextEditingController title, industry, category, price;

  const CatalogListingFields({
    super.key,
    required this.title,
    required this.industry,
    required this.category,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 12);
    return Column(children: [
      TextField(controller: title, style: style, decoration: const InputDecoration(hintText: 'Title')),
      TextField(
          controller: industry, style: style, decoration: const InputDecoration(hintText: 'Industry')),
      TextField(
          controller: category, style: style, decoration: const InputDecoration(hintText: 'Category')),
      TextField(
        controller: price,
        keyboardType: TextInputType.number,
        style: style,
        decoration: const InputDecoration(hintText: 'Price'),
      ),
    ]);
  }
}
