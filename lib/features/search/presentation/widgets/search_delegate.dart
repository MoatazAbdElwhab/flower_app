// features/search/presentation/widgets/search_delegate.dart

import 'package:flower_app/features/search/presentation/pages/search_results_page.dart';
import 'package:flutter/material.dart';

class SearchNavigation {
  static void navigateToSearch(BuildContext context,
      {String initialQuery = '', String? categoryId}) {
    // Navigate to the search results page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(
          initialQuery: initialQuery,
          categoryId: categoryId,
          onBackPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  static void onHomeSearchTap(BuildContext context) {
    navigateToSearch(context);
  }

  static void onCategorySearchTap(BuildContext context, String categoryId) {
    navigateToSearch(context, categoryId: categoryId);
  }
}
