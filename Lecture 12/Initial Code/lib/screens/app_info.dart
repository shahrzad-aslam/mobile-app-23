import 'package:flutter/material.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0F172A); // Dark tactical slate
    const cardColor = Color(0xFF1E293B);
    const primaryColor = Colors.cyanAccent;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'App Info',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: cardColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. App Logo / Icon with Neon Glow
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.1),
                  border: Border.all(color: primaryColor.withOpacity(0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  size: 60,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),

              // 2. App Name & Version
              const Text(
                'UNCOVER SECRETS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor.withOpacity(0.3)),
                ),
                child: const Text(
                  'v 1.0',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              _buildInfoCard(
                cardColor: cardColor,
                title: 'About App',
                icon: Icons.radar_rounded,
                primaryColor: primaryColor,
                content: const Text(
                  'UncoverSecrets is an interactive, location-based scan hunt mobile app built for entertainment purpose in university campuses. Drop secret with GPS coordinates, track live signals, and race against distance to claim rewards. \nWhat every you find is yours .. Cheers!',
                  style: TextStyle(color: Colors.white70, height: 1.4, fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Developer  Card
              _buildInfoCard(
                cardColor: cardColor,
                title: 'Contact Us',
                icon: Icons.code_rounded,
                primaryColor: primaryColor,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Developer', 'Your name goes here'),
                    const Divider(color: Colors.white12, height: 20),
                    _buildDetailRow('Email', 'youremail@gmail.com'),
                    const Divider(color: Colors.white12, height: 20),
                    _buildDetailRow('Web Link', 'yourweb.com'),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required Color cardColor,
    required String title,
    required IconData icon,
    required Color primaryColor,
    required Widget content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          content,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}