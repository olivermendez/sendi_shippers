import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OPTVerification extends StatelessWidget {
  OPTVerification({Key? key}) : super(key: key);

  final phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Center(
              child: Text('OPT Verification'),
            ),
            TextField(
              controller: phoneNumber,
              decoration:
                  const InputDecoration(helperText: 'Your Phone Number'),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyNumber(
                                      phoneNumber: phoneNumber.text)));
                          //Navigator.pushNamed(context, 'register');

                          //print(phoneNumber.text);
                        },
                        child: const Text('continue'))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class VerifyNumber extends StatelessWidget {
  final phoneNumber;

  VerifyNumber({required this.phoneNumber, Key? key}) : super(key: key);
  final insertCode = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String error = 'no error';
    const code = 56754;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Center(
              child: Text('Insert the code below'),
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  } else
                    return "Please enter valid email";
                },
                controller: insertCode,
                decoration: const InputDecoration(helperText: 'code'),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              insertCode.text == code.toString()) {
                            Navigator.pushNamed(context, 'register');
                          } else {
                            return;
                          }
                        },
                        child: const Text('continue'))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
