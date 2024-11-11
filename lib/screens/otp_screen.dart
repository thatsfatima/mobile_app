import 'package:flutter/material.dart';
import 'package:app_money/services/register.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();

}

class _OtpScreenState extends State<OtpScreen> {

  TextEditingController _codeOtpController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _codeOtpController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _codeOtpController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<Register>(context);
    final phone = register.getPhone;

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child:Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Veuillez saisir le code envoyer au $phone',
                  style: const TextStyle(
                  ),
                ),
                TextFormField(
                    controller: _codeOtpController,
                    validator: (value) =>
                    value!.isEmpty ? 'Vous devez saisir le code envoyé.' : null),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 0),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Map<String, dynamic> otpData = {
                          'phone': phone,
                          'otp': _codeOtpController,
                        };

                        Provider.of<Register>(context, listen: false).verifyOtp(datas: otpData);

                        if (register.errorMessage != null) {
                          SnackBar(content: Text(register.errorMessage!));
                        }

                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text('Valider'),
                  ),
                ),

                if (register.errorMessage != null)
                  SnackBar(content: Text(register.errorMessage!)),
              ],
            ),
          ),
        )
    );
  }
}