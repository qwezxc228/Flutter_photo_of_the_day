import 'dart:math';
import 'package:flutter/material.dart';
enum RabbitType { forest, domestic, fluffy }

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  String? _imageUrl;
  bool _isLoading = false;
  String? _errorMessage;
  RabbitType _rabbitType = RabbitType.forest;
    final List<String> _localPhotos = [
    'assets/images/rabbit1.jpg',
    'assets/images/rabbit2.jpg',
    'assets/images/rabbit3.jpg',
  ];

  Future<void> _fetchPhoto() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _imageUrl = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      final randomIndex = Random().nextInt(_localPhotos.length);
      _imageUrl = _localPhotos[randomIndex];
    } catch (e) {
      _errorMessage = 'Ошибка загрузки фото кролика.\nПопробуйте еще раз.';
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кролик дня'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildRabbitToggle(),
          const SizedBox(height: 20),
          _buildContent(),
          const SizedBox(height: 20),
          _buildButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRabbitToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text('🌲 Лесной'),
          selected: _rabbitType == RabbitType.forest,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _rabbitType = RabbitType.forest;
                _imageUrl = null;
                _errorMessage = null;
              });
            }
          },
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text(' Домашний'),
          selected: _rabbitType == RabbitType.domestic,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _rabbitType = RabbitType.domestic;
                _imageUrl = null;
                _errorMessage = null;
              });
            }
          },
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text(' Пушистый'),
          selected: _rabbitType == RabbitType.fluffy,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _rabbitType = RabbitType.fluffy;
                _imageUrl = null;
                _errorMessage = null;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ),
      );
    }

    if (_imageUrl != null) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              _imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      );
    }

    return const Expanded(
      child: Center(
        child: Text(
          'Нажмите кнопку,\nчтобы загрузить кролика ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _fetchPhoto,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Text(
          ' Новый кролик',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}