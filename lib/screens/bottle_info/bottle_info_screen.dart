import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/blocs/bottle_info/bottle_info_bloc.dart';

class BottleInfoScreen extends StatefulWidget {
  final double? emptyBottleWeight;
  final double? fullBottleWeight;

  const BottleInfoScreen({
    this.emptyBottleWeight,
    this.fullBottleWeight,
    Key? key,
  }) : super(key: key);

  @override
  _BottleInfoScreenState createState() => _BottleInfoScreenState();
}

class _BottleInfoScreenState extends State<BottleInfoScreen> {
  late BottleInfoBloc _bottleInfoBloc;

  late double emptyBottleWeight;
  late double fullBottleWeight;

  TextStyle textStyle = const TextStyle(
    fontSize: 16,
  );

  @override
  void initState() {
    _bottleInfoBloc = BottleInfoBloc();

    if (widget.emptyBottleWeight != null && widget.fullBottleWeight != null) {
      emptyBottleWeight = widget.emptyBottleWeight!;
      fullBottleWeight = widget.fullBottleWeight!;
    } else {
      emptyBottleWeight = 0;
      fullBottleWeight = 0;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottleInfoBloc>(
      create: (final BuildContext _) {
        return _bottleInfoBloc;
      },
      child: BlocBuilder<BottleInfoBloc, BottleInfoState>(
        builder: (final BuildContext context, final BottleInfoState state) {
          return _body(state);
        },
      ),
    );
  }

  Widget _body(final BottleInfoState state) {
    if (state is BottleInfoLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Add Water Bottle",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "To measure your water intake we need weight of your water bottle empty and full",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                initialValue: emptyBottleWeight.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Empty Bottle weight"),
                ),
                onChanged: (String value) {
                  emptyBottleWeight =
                      double.tryParse(value) ?? emptyBottleWeight;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                initialValue: fullBottleWeight.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Full Bottle weight"),
                ),
                onChanged: (String value) {
                  fullBottleWeight = double.tryParse(value) ?? fullBottleWeight;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                _bottleInfoBloc.add(
                  UpdateBottleInfo(
                    fullBottleWeight: fullBottleWeight,
                    emptyBottleWeight: emptyBottleWeight,
                  ),
                );
              },
              child: Text(
                "Continue",
                style: textStyle,
              ),
            ),
          ],
        ),
      );
    }
  }
}
