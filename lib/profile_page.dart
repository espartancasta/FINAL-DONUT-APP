import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa FirebaseAuth
import 'package:firebase_storage/firebase_storage.dart'; // Importa FirebaseStorage
import 'package:image_picker/image_picker.dart'; // Importa ImagePicker
import 'dart:io'; // Para manejar archivos locales
import 'dart:math'; // Para generar valores aleatorios

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  String _creationDate = '';
  String _name = '';
  String _lastName = '';
  String gender = '';
  int age = 18;
  String job = '';
  String _randomId = '';
  File? _imageFile;
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _jobController = TextEditingController();

  // Lista de imágenes de perfil aleatorias
  final List<String> _profileImages = [
    'lib/assets/profile1.jpg',
    'lib/assets/profile2.jpg',
    'lib/assets/profile3.jpg',
    'lib/assets/profile4.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _generateRandomId(); // Generar ID aleatorio
  }

  // Obtener la información del usuario de FirebaseAuth
  void _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _user = user;

        // Verifica si displayName está disponible
        if (user.displayName != null && user.displayName!.isNotEmpty) {
          List<String> nameParts = user.displayName!.split(' ');
          _name = nameParts.isNotEmpty ? nameParts.first : 'No disponible';
          _lastName = nameParts.length > 1
              ? nameParts.sublist(1).join(' ')
              : 'No disponible';
        } else {
          _name = 'No disponible';
          _lastName = 'No disponible';
        }

        _nameController.text = _name;
        _lastNameController.text = _lastName;
        _creationDate =
            user.metadata.creationTime?.toLocal().toString() ?? "N/A";
      });
    }
  }

  // Función para seleccionar una imagen de perfil desde el dispositivo
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Actualiza la imagen localmente
      });
      _uploadImageToFirebase(_imageFile!); // Sube la imagen a Firebase
    }
  }

  // Subir la imagen seleccionada a Firebase Storage
  Future<void> _uploadImageToFirebase(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${_user!.uid}.jpg');
      await storageRef.putFile(image);
      String downloadUrl = await storageRef.getDownloadURL();

      // Actualizar la foto de perfil del usuario en FirebaseAuth
      await _user!.updateProfile(photoURL: downloadUrl);

      // Recargar la información del usuario para reflejar el cambio
      setState(() {
        _user!.updateProfile(
            photoURL: downloadUrl); // Actualiza la URL de la foto
      });
    } catch (e) {
      print("Error al subir la imagen: $e");
    }
  }

  // Generar un ID aleatorio
  void _generateRandomId() {
    final random = Random();
    setState(() {
      _randomId = 'ID${random.nextInt(10000)}'; // Genera un ID aleatorio
    });
  }

  // Actualizar los datos del usuario
  Future<void> _updateProfile() async {
    try {
      String fullName = '${_nameController.text} ${_lastNameController.text}';
      await _user!.updateDisplayName(fullName); // Actualiza el nombre completo
      setState(() {
        _name = _nameController.text;
        _lastName = _lastNameController.text;
      });
    } catch (e) {
      print("Error al actualizar el nombre: $e");
    }
  }

  // Función para obtener una foto de perfil aleatoria
  String _getRandomProfileImage() {
    final random = Random();
    return _profileImages[random.nextInt(_profileImages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Usuario'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto de perfil
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage, // Permite cambiar la foto de perfil
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : (_user?.photoURL != null
                                ? NetworkImage(_user!.photoURL!)
                                : AssetImage(_getRandomProfileImage())
                                    as ImageProvider),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Campo para editar el nombre
                  _buildTextField(
                    label: 'Nombre',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 10),
                  // Campo para editar el apellido
                  _buildTextField(
                    label: 'Apellido',
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 10),
                  // Campo para editar el sexo
                  _buildTextField(
                    label: 'Sexo',
                    controller: _genderController,
                  ),
                  const SizedBox(height: 10),
                  // Campo para editar la edad
                  _buildTextField(
                    label: 'Edad',
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  // Campo para editar el trabajo
                  _buildTextField(
                    label: 'Trabajo',
                    controller: _jobController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateProfile, // Actualizar datos
                    child: const Text('Actualizar Perfil'),
                  ),
                  const SizedBox(height: 20),
                  Text('ID de usuario: $_randomId',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Nombre completo: $_name $_lastName',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Correo electrónico: ${_user?.email ?? "No disponible"}',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Fecha de creación de cuenta: $_creationDate',
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
    );
  }

  // Método para crear campos de texto personalizados
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
