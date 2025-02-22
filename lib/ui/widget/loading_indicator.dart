import 'package:flutter/material.dart';
import 'package:kantor_gubernur/constants/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: colorPrimary,
    ));
  }
}
