import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/blocs/water_intake/water_intake_bloc.dart';
import 'package:weighmywaterbottle/services/wayfinder.dart';

class WaterIntakeScreen extends StatefulWidget {
  const WaterIntakeScreen({Key? key}) : super(key: key);

  @override
  _WaterIntakeScreenState createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  late WaterIntakeBloc _waterIntakeBloc;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle textStyle = const TextStyle(
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    _waterIntakeBloc = WaterIntakeBloc();
    _waterIntakeBloc.add(LoadLastBottleWeight());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WaterIntakeBloc>(
      create: (final BuildContext _) {
        return _waterIntakeBloc;
      },
      child: BlocBuilder<WaterIntakeBloc, WaterIntakeState>(
        builder: (final BuildContext context, final WaterIntakeState state) {
          return _body(state);
        },
      ),
    );
  }

  Widget _body(WaterIntakeState state) {
    if (state is WaterIntakeLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is TextUpdate) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Wayfinder.instance.pop();
            },
          ),
          title: const Text(
            "Update Bottle Weight",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView(
              children: [
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Your Full Bottle Weight is ${_waterIntakeBloc.fullBottleWeight}\nYour Empty Bottle Weight is ${_waterIntakeBloc.emptyBottleWeight}",
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  autofocus: true,
                  initialValue: _waterIntakeBloc.currentBottleWeight.toString(),
                  validator: (final String? value) {
                    if (value == null) {
                      return "Field can't be empty, please enter some value";
                    } else if (value.isEmpty) {
                      return "Field can't be empty, please enter some value";
                    } else if (int.tryParse(value) == null) {
                      return "Only numeric value is accepted";
                    } else if (int.parse(value) <
                        _waterIntakeBloc.emptyBottleWeight) {
                      return "Bottle weight cannot be lower then empty bottle weight";
                    } else if (int.parse(value) >
                        _waterIntakeBloc.fullBottleWeight) {
                      return "Bottle weight cannot be higher then full bottle weight";
                    }
                  },
                  onChanged: (final String value) {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _waterIntakeBloc.add(
                        UpdateWeight(weight: int.parse(value)),
                      );
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    labelText: "Current Bottle Weight",
                    labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                  ),
                ),
                if (state.text.isNotEmpty) const SizedBox(height: 18),
                if (state.text.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      state.text,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 18),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "RECORD ${_waterIntakeBloc.lastBottleWeight - _waterIntakeBloc.currentBottleWeight}",
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
