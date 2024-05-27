import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/utils/pick_image.dart';
import 'package:konsuldoc/domain/entities/admin.dart';
import 'package:konsuldoc/presentations/controllers/admin_controller.dart';

@RoutePage()
class AdminFormPage extends ConsumerStatefulWidget {
  final Admin? admin;
  const AdminFormPage({super.key, this.admin});

  @override
  ConsumerState<AdminFormPage> createState() => _AdminFormPageState();
}

class _AdminFormPageState extends ConsumerState<AdminFormPage> {
  Admin? get admin => widget.admin;

  File? avatarFile;

  late final _nameController = TextEditingController(text: admin?.name);
  late final _emailController = TextEditingController(text: admin?.email);
  late final _phoneController = TextEditingController(text: admin?.phone);
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        avatarFile = File(res.files.first.path!);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: selectBannerImage,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                          shape: BoxShape.circle,
                          image: avatarFile != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(avatarFile!),
                                )
                              : admin?.avatar != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(admin!.avatar!),
                                    )
                                  : null,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 4, color: Colors.white),
                          color: const Color.fromRGBO(28, 42, 58, 1),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.perm_identity_rounded),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return "Masukkan nama yang valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Masukkan email yang valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "No Telepon",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.add_call),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^\+?62[0-9]+$').hasMatch(value)) {
                    return "Masukkan nomor telepon yang valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: obscurePassword,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return "Password harus memiliki setidaknya 6 karakter";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Konfirmasi Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value!.isEmpty || value != _passwordController.text) {
                    return "Password tidak cocok";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    if (admin == null) {
                      insertAdmin();
                    } else {
                      editAdmin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(58, 115, 149, 1),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insertAdmin() {
    ref
        .read(adminControllerProvider)
        .add(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
          avatar: avatarFile,
        )
        .then((value) {
      if (value) context.maybePop();
    });
  }

  void editAdmin() {
    ref
        .read(adminControllerProvider)
        .edit(
          widget.admin!.id,
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          avatar: avatarFile,
        )
        .then((value) {
      if (value) context.maybePop();
    });
  }
}
