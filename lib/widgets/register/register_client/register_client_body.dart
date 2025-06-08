import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../register/register_client/popup_client.dart';

class RegisterFormBody extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String selectedChoice;
  final bool showPassword;
  final bool showConfirmPassword;
  final String? nameError;
  final String? phoneError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? dropdownError;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final Function(String?) onDropdownChanged;

  const RegisterFormBody({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.selectedChoice,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.nameError,
    required this.phoneError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.dropdownError,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          controller: nameController,
          hintText: 'Nama Lengkap',
          keyboardType: TextInputType.text,
          errorText: nameError,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: phoneController,
          hintText: 'No. Telepon',
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          errorText: phoneError,
        ),
        const SizedBox(height: 20),
        _buildPasswordField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: !showPassword,
          onToggle: onTogglePassword,
          errorText: passwordError,
        ),
        const SizedBox(height: 20),
        _buildPasswordField(
          controller: confirmPasswordController,
          hintText: 'Konfirmasi Password',
          obscureText: !showConfirmPassword,
          onToggle: onToggleConfirmPassword,
          errorText: confirmPasswordError,
        ),
        const SizedBox(height: 20),
        _buildDropdown(),
        if (dropdownError != null) ...[
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dropdownError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? errorText,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null ? Colors.red : Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null ? Colors.red : Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null
                  ? Colors.red
                  : CustomPopupsClient.primaryGreen,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          errorText: errorText,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    String? errorText,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null ? Colors.red : Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null ? Colors.red : Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null
                  ? Colors.red
                  : CustomPopupsClient.primaryGreen,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade600,
              ),
              onPressed: onToggle,
            ),
          ),
          errorText: errorText,
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: dropdownError != null ? Colors.red : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedChoice,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ['Pilihan', 'Individual', 'Perusahaan']
              .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
              .toList(),
          onChanged: onDropdownChanged,
        ),
      ),
    );
  }
}
