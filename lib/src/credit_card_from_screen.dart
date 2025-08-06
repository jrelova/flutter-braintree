import 'package:braintree_flutter_plus/src/formatter/input_four_digit_format.dart';
import 'package:braintree_flutter_plus/src/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import '../braintree_flutter_plus.dart';

class CreditCardFormScreen extends StatefulWidget {
  const CreditCardFormScreen({
    super.key,
    required this.authorization,
    required this.amount,
  });

  final String authorization;
  final String amount;

  @override
  State<CreditCardFormScreen> createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  final _cardNumberController = TextEditingController();
  final _expirationMonthController = TextEditingController();
  final _expirationYearController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _tokenizeCard() async {
    setState(() {
      _isLoading = true;
    });

    final request = BraintreeCreditCardRequest(
      cardNumber: _cardNumberController.text.replaceAll(' ', ''),
      expirationMonth: _expirationMonthController.text,
      expirationYear: _expirationYearController.text,
      cvv: _cvvController.text,
      amount: widget.amount,
    );

    try {
      final nonce = await Braintree.tokenizeCreditCard(
        widget.authorization,
        request,
      );
      Navigator.of(context).pop(nonce);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enter Card Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    errorText: 'Card number is required',
                    controller: _cardNumberController,
                    labelText: 'Card Number',
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                    inputFormatters: [FourDigitSeparatorFormatter()],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: _expirationMonthController,
                          labelText: 'Exp. Month (MM)',
                          hintText: 'MM',
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Month is required';
                            }
                            if (value.length < 2) {
                              return 'Invalid month';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: CustomTextFormField(
                          controller: _expirationYearController,
                          labelText: 'Exp. Year (YYYY)',
                          hintText: 'YYYY',
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Expiration year is required';
                            }
                            if (value.length < 4) {
                              return 'Invalid year';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    errorText: 'CVV is required',
                    controller: _cvvController,
                    hintText: 'CVV',
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CVV is required';
                      }
                      if (value.length < 3) {
                        return 'Invalid CVV';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _tokenizeCard();
                          },
                          child: Text('Pay'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
