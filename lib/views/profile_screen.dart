import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1780&auto=format&fit=crop',
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
                  width: 120,
                  color: Colors.white12,
                  child:
                      const Icon(Icons.person, size: 60, color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lilac Admin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'admin@lilac.com',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 32),
            _buildProfileOption(Icons.history, 'Booking History'),
            _buildProfileOption(Icons.payment, 'Payment Methods'),
            _buildProfileOption(Icons.notifications_outlined, 'Notifications'),
            _buildProfileOption(Icons.help_outline, 'Help & Support'),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF4B2B)),
                  foregroundColor: const Color(0xFFFF4B2B),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF4B2B)),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }
}
