import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/extensions/extensions.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_cubit_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.scaffoldBackground,
    appBar: AppBar(backgroundColor: context.color.scaffoldBackground, title: const Text('Home'), centerTitle: false),
    body: BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        if (state.status.isLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.isError && state.items.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        }
        return RefreshIndicator(
          onRefresh: context.read<HomeCubit>().load,
          child: ListView.separated(
            padding: const .all(16),
            itemCount: state.items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
              final item = state.items[index];
              return Container(
                padding: const .all(16),
                decoration: BoxDecoration(color: context.color.grey60, borderRadius: .circular(16)),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(item.title, style: context.textTheme.interW600s16),
                    const SizedBox(height: 4),
                    Text(item.subtitle, style: context.textTheme.interW400s14.copyWith(color: context.color.grey500)),
                  ],
                ),
              );
            },
          ),
        );
      },
    ),
  );
}
