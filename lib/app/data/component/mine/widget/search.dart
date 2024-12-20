import 'package:flutter/material.dart';

class MyProductsSearchDelegate<T> extends SearchDelegate {
  MyProductsSearchDelegate({
    required this.items,
    required this.builder,
    required this.filter,
  });

  final List<T> items;
  List<T> results = <T>[];
  Widget Function(List<T> items) builder;
  List<String> Function(T item) filter;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => results.isEmpty
      ? const Center(
          child: Text('No Results', style: TextStyle(fontSize: 24)),
        )
      : builder(results);

  // filter(item).map((e) => e.toLowerCase().contains(query)).toList();
  @override
  Widget buildSuggestions(BuildContext context) {
    results = items
        .where(
          (item) => filter(item).contains(query.toLowerCase()),
        )
        .toList();

    return results.isEmpty
        ? const Center(
            child: Text('No Results', style: TextStyle(fontSize: 24)),
          )
        : builder(results);
  }
}
