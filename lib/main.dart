import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biodata Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: 'Ralph Geneses I. Reteo');
  final _ageController = TextEditingController(text: '25');
  final _birthdayController = TextEditingController(text: 'August 7, 2001');
  final _civilStatusController = TextEditingController(text: 'Single');
  final _addressController = TextEditingController(text: '63 Kabulusan 2, Caloocan city, Metro Manila, Philippines',);
  final _contactController = TextEditingController(text: '+63945-5422-662');
  final _emailController = TextEditingController(text: 'genesesinfante@gmail.com');
  final _occupationController = TextEditingController(text: 'Student');

  String _selectedGender = 'Male';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _birthdayController.dispose();
    _civilStatusController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biodata Submitted Successfully!')),
      );
    }
  }

  IconData _getGenderIcon() {
    return _selectedGender == 'Female' ? Icons.female : Icons.male;
  }

  Color _getGenderColor() {
    return _selectedGender == 'Female' ? Colors.pink : Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/ID.jpg'),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'PERSONAL BIODATA',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  biodataInputField(
                    icon: Icons.person,
                    label: 'Full Name',
                    controller: _nameController,
                  ),

                  biodataInputField(
                    icon: Icons.cake,
                    label: 'Age',
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          _getGenderIcon(),
                          color: _getGenderColor(),
                        ),
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedGender = value;
                          });
                        }
                      },
                    ),
                  ),

                  biodataInputField(
                    icon: Icons.calendar_today,
                    label: 'Birthday',
                    controller: _birthdayController,
                  ),

                  biodataInputField(
                    icon: Icons.favorite,
                    label: 'Civil Status',
                    controller: _civilStatusController,
                  ),

                  biodataInputField(
                    icon: Icons.home,
                    label: 'Address',
                    controller: _addressController,
                    maxLines: 2,
                  ),

                  biodataInputField(
                    icon: Icons.phone,
                    label: 'Contact Number',
                    controller: _contactController,
                    keyboardType: TextInputType.phone,
                  ),

                  biodataInputField(
                    icon: Icons.email,
                    label: 'Email Address',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  biodataInputField(
                    icon: Icons.work,
                    label: 'Occupation',
                    controller: _occupationController,
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Submit Biodata',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget biodataInputField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}