// core/app_data/api/graphql/bootstrap.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'graphql_provider.dart';

class GraphQLBootstrap {
  static Future<void> initialize() async {
    await Hive.initFlutter();
  }

  static Widget wrapWithGraphQLProvider({
    required Widget child,
  }) {
    final graphqlProvider = GetIt.I<AppGraphQLProvider>();
    return graphqlProvider.wrapWithClient(child);
  }
}
