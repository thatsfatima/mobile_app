import 'package:flutter/material.dart';
import 'package:app_money/services/register.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeSecretController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cinController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String countryCode = '+221';
  bool _isObscure = true;

  @override
  void initState() {
    _firstnameController.text = '';
    _lastnameController.text = '';
    _emailController.text = '';
    _phoneController.text = '';
    _codeSecretController.text = '';
    _addressController.text = '';
    _cinController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _codeSecretController.dispose();
    _addressController.dispose();
    _cinController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Register>(context);

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child:Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    controller: _firstnameController,
                    validator: (value) =>
                    value!.isEmpty ? 'Le prenom est obligatoire.' : null),
                TextFormField(
                    controller: _lastnameController,
                    validator: (value) =>
                    value!.isEmpty ? 'Le nom est obligatoire.' : null),
                TextFormField(
                    controller: _emailController,
                    validator: (value) =>
                    value!.isEmpty ? "L'email est obigatoire"  : null),
                TextFormField(
                  controller: _phoneController,
                  validator: (value) => value!.isEmpty ? 'Le numéro de téléphone est obligatoire' : null,
                  decoration: InputDecoration(
                    prefixIcon: CountryCodePicker(
                      onChanged: (CountryCode code) {
                        setState(() {
                          countryCode = code.dialCode!;
                        });
                      },
                      initialSelection: 'SN', // Set initial selection to Senegal (+221)
                      favorite: ['+221','SN'], // Add Senegal to favorites
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: _codeSecretController,
                  validator: (value) => value!.isEmpty ? 'Donnez votre code secret' : null,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                            _isObscure ?
                            Icons.visibility :
                            Icons.visibility_off
                        )
                    ),
                  ),
                ),
                TextFormField(
                    controller: _addressController,
                    validator: (value) =>
                    value!.isEmpty ? "L'adresse est obligatoire." : null),
                TextFormField(
                    controller: _cinController,
                    validator: (value) =>
                    value!.isEmpty ? 'Le CIN est obligatoire.' : null),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 0),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                        )
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Map<String, dynamic> newUser = {
                          'firstName': _firstnameController,
                          'lastName': _lastnameController,
                          'email': _emailController,
                          'phone': countryCode + _phoneController.text,
                          'password': _codeSecretController.text,
                        };
                        Map<String, dynamic> newClient = {
                          'address': _addressController,
                          'CIN': _cinController,
                        };

                        Provider.of<Register>(context, listen: false).register(datas: newUser);
                        Provider.of<Register>(context, listen: false).getClient(datas: newClient);

                        if (auth.errorMessage != null) {
                          SnackBar(content: Text(auth.errorMessage!));
                        }

                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text("S'inscrire"),
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(
                    onPressed: () {

                    },
                    child: const Text('ou Se connecter'))
              ],
            ),
          ),
        )
    );
  }
}