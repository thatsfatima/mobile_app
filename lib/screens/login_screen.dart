import 'package:flutter/material.dart';
import 'package:app_money/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeSecretController = TextEditingController();
    final _formkey = GlobalKey<FormState>();
    String countryCode = '+221';
    bool _isObscure = true;

  @override
  void initState() {
    _phoneController.text = '';
    _codeSecretController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeSecretController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(60.0),
          child:Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      textStyle: ,
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
                const SizedBox(height: 10,),
                SizedBox(
                  height: 30,
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
                        Map<String, dynamic> credentials = {
                          'phone': countryCode + _phoneController.text,
                          'password': _codeSecretController.text,
                          'device_name': 'mobile',
                        };

                        Provider.of<Auth>(context, listen: false).login(credentials: credentials);

                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text('Se connecter'),
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(
                    onPressed: () {

                    },
                    child: const Text("ou s'inscrire"))
              ],
            ),
          ),
      )
    );
  }
}
