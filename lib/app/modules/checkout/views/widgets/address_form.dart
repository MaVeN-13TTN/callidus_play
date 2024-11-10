import 'package:flutter/material.dart';

import '../../../../core/utils/helpers/validator_helper.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/address/shipping_address_model.dart';
import '../../../../widgets/inputs/custom_text_field.dart';

class AddressForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(ShippingAddress) onSubmit;

  const AddressForm({
    super.key,
    required this.formKey,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();
    final addressLine1Controller = TextEditingController();
    final addressLine2Controller = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final postalCodeController = TextEditingController();
    final phoneNumberController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: fullNameController,
            label: 'Full Name',
            validator: (value) =>
                ValidatorHelper.validateRequired(value, 'Full Name'),
          ),
          const SizedBox(height: Dimensions.sm),
          CustomTextField(
            controller: addressLine1Controller,
            label: 'Address Line 1',
            validator: (value) =>
                ValidatorHelper.validateRequired(value, 'Address'),
          ),
          const SizedBox(height: Dimensions.sm),
          CustomTextField(
            controller: addressLine2Controller,
            label: 'Address Line 2 (Optional)',
          ),
          const SizedBox(height: Dimensions.sm),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: cityController,
                  label: 'City',
                  validator: (value) =>
                      ValidatorHelper.validateRequired(value, 'City'),
                ),
              ),
              const SizedBox(width: Dimensions.sm),
              Expanded(
                child: CustomTextField(
                  controller: stateController,
                  label: 'State',
                  validator: (value) =>
                      ValidatorHelper.validateRequired(value, 'State'),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.sm),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: postalCodeController,
                  label: 'Postal Code',
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      ValidatorHelper.validateRequired(value, 'Postal Code'),
                ),
              ),
              const SizedBox(width: Dimensions.sm),
              Expanded(
                child: CustomTextField(
                  controller: phoneNumberController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) => ValidatorHelper.validatePhone(value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
