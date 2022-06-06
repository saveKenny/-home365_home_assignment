import 'package:assets_repository/assets_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home365_home_assignment/app/app.dart';
import 'package:home365_home_assignment/assets_list/assets_list.dart';
import 'package:home365_home_assignment/assets_map/assets_map.dart';

class App extends StatelessWidget {
  const App({Key? key, required AssetsRepository assetsRepository})
      : _assetsRepository = assetsRepository,
        super(key: key);

  final AssetsRepository _assetsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _assetsRepository,
      child: BlocProvider(
          create: (context) =>
              AssetsCubit(assetsRepository: context.read<AssetsRepository>())
                ..fetchAssets(),
          child: const AppView()),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home365"),
        ),
        body: BlocBuilder<AssetsCubit, AssetsState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            const loading = Center(child: CircularProgressIndicator());

            switch (state.status) {
              case AssetsStatus.initial:
                return loading;
              case AssetsStatus.loading:
                return loading;
              case AssetsStatus.failure:
                return const Center(child: Text("Failed to fetch assets"));
              case AssetsStatus.success:
                return state.assets.isEmpty
                    ? const Center(child: Text("No assets available"))
                    : Column(
                        children: const [
                          Expanded(child: AssetsMap()),
                          Expanded(child: AssetList()),
                        ],
                      );
            }
          },
        ),
      ),
    );
  }
}
