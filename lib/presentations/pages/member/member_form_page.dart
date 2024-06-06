import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/core/utils/pick_image.dart';
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/enums/gender.dart';
import 'package:konsuldoc/presentations/controllers/member_controller.dart';

@RoutePage()
class MemberFormPage extends ConsumerStatefulWidget {
  final Member member;
  const MemberFormPage({super.key, required this.member});

  @override
  ConsumerState<MemberFormPage> createState() => _MemberFormPageState();
}

class _MemberFormPageState extends ConsumerState<MemberFormPage> {
  final _form = GlobalKey<FormState>();
  Member get member => widget.member;

  File? avatarFile;
  Gender? _gender;

  late final _nameController = TextEditingController(text: member.name);
  late final _emailController = TextEditingController(text: member.email);
  late final _phoneController = TextEditingController(text: member.phone);
  late final _addressController = TextEditingController(text: member.address);
  late final _dobController =
      TextEditingController(text: member.dob?.toShortDateString());
  late DateTime? dob = member.dob;

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
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _pickDoB() async {
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );

    if (value != null) {
      _dobController.text = value.toShortDateString();
      setState(() {
        dob = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member'),
        centerTitle: true,
        leading: const AutoLeadingButton(),
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(15),
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
                                image: FileImage(avatarFile!))
                            : widget.member.avatar != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      widget.member.avatar!,
                                    ),
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
                    !RegExp(r'^[a-zA-Z., ]+$').hasMatch(value)) {
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
                if (value!.isEmpty || !RegExp(r'^\d{11,13}$').hasMatch(value)) {
                  return "Masukkan nomor telepon yang valid";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: "Alamat",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: _pickDoB,
              child: AbsorbPointer(
                child: TextField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal lahir',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Jenis Kelamin',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<Gender>(
                    contentPadding: const EdgeInsets.all(0.0),
                    value: Gender.male,
                    dense: true,
                    groupValue: _gender,
                    title: Text(Gender.male.label),
                    onChanged: (val) {
                      setState(() {
                        _gender = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<Gender>(
                    contentPadding: const EdgeInsets.all(0.0),
                    value: Gender.female,
                    dense: true,
                    groupValue: _gender,
                    title: Text(Gender.female.label),
                    onChanged: (val) {
                      setState(() {
                        _gender = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  if (_form.currentState?.validate() ?? false) {
                    updateProfile();
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
    );
  }

  void updateProfile() {
    ref
        .read(memberControllerProvider)
        .edit(
          member.id,
          name: _nameController.text,
          email: _emailController.text,
          address: _addressController.text,
          phone: _phoneController.text,
          gender: _gender,
          dob: dob,
          avatar: avatarFile,
        )
        .then((value) {
      if (value) context.maybePop();
    });
  }
}
