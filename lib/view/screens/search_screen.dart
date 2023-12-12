import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  // This widget allows users to search for a city.
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Define a form key to validate user input.
  final _formKey = GlobalKey<FormState>();

  // Variable to store the selected city name.
  String? _city;

  // Initial validation mode: disabled.
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // Function to handle form submission.
  void _submit() {
    setState(() {
      // Enable automatic validation.
      autovalidateMode = AutovalidateMode.always;
    });

    // Get the form object.
    final form = _formKey.currentState;

    // Validate the form and return the city name if valid.
    if (form != null && form.validate()) {
      form.save();
      context.pop(_city!.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Title for the search screen.
        title: const Text('Search'),
      ),
      body: Form(
        // Form key and validation mode.
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            const SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                // Autofocus the input field.
                autofocus: true,
                // Set text style.
                style: const TextStyle(fontSize: 18.0),
                // Input decoration with label, hint, icon, and border.
                decoration: const InputDecoration(
                  labelText: 'City name',
                  hintText: 'more than 2 characters',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                // Validation function for city name.
                validator: (String? input) {
                  if (input == null || input.trim().length < 2) {
                    return 'City name must be at least 2 characters long';
                  }
                  return null;
                },
                // Save the city name on form submission.
                onSaved: (String? input) {
                  _city = input;
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              // Submit the form on button press.
              onPressed: _submit,
              child: const Text(
                "How's weather?",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
