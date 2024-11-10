import 'package:flutter/material.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/address/shipping_address_model.dart';

class AddressCard extends StatelessWidget {
  final ShippingAddress address;
  final bool isSelected;
  final VoidCallback? onSelect;

  const AddressCard({
    super.key,
    required this.address,
    this.isSelected = false,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: Dimensions.xs),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.md),
          child: Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: isSelected ? true : false,
                onChanged: (_) => onSelect?.call(),
                activeColor: AppColors.primary,
              ),
              const SizedBox(width: Dimensions.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimensions.xs),
                    Text(address.phoneNumber),
                    const SizedBox(height: Dimensions.xs),
                    Text(
                      [
                        address.addressLine1,
                        address.addressLine2,
                        address.city,
                        address.state,
                        address.postalCode,
                        address.country,
                      ].where((s) => s != null && s.isNotEmpty).join(', '),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
