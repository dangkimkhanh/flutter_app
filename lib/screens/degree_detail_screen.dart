import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../services/api_service.dart';

class DegreeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DegreeDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final pdfUrl = ApiService.getPdfUrl(data["id"]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xác minh văn bằng thành công!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          data["name"] ?? "Chi tiết văn bằng",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),

      /// body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(
              icon: Icons.school,
              label: 'Trường đại học/Học viện',
              value: '${data["university_code"]} - ${data["university_name"]}',
            ),
            _InfoRow(
              icon: Icons.computer,
              label: 'Ngành học',
              value: '${data["faculty_code"]} - ${data["faculty_name"]}',
            ),
            _InfoRow(
              icon: Icons.calendar_today,
              label: 'Ngày cấp',
              value: data["issue_date"] ?? 'Không có dữ liệu',
            ),
            _InfoRow(
              icon: Icons.description,
              label: 'Số vào sổ gốc cấp văn bằng',
              value: data["reg_no"] ?? 'Không có dữ liệu',
            ),
            _InfoRow(
              icon: Icons.person,
              label: 'Sinh viên',
              value:
              '${data["student_code"]} - ${data["student_name"] ?? "Không rõ"}',
            ),
            _InfoRow(
              icon: Icons.badge,
              label: 'Chứng chỉ',
              value: data["name"] ?? 'Không có dữ liệu',
            ),
            _InfoRow(
              icon: Icons.tag,
              label: 'Số hiệu',
              value: data["serial_number"] ?? 'Không có dữ liệu',
            ),
            _InfoRow(
              icon: Icons.notes,
              label: 'Mô tả',
              value: data["description"] ?? 'Không có dữ liệu',
            ),

            const SizedBox(height: 24),

            const Text(
              'Ảnh văn bằng',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // PDF Viewer
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SfPdfViewer.network(
                  pdfUrl,
                  canShowScrollHead: false,
                  canShowScrollStatus: false,
                  enableDoubleTapZooming: true,
                  onDocumentLoadFailed: (details) {
                    debugPrint('PDF load error: ${details.error}');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== WIDGET HIỂN THỊ THÔNG TIN =====================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
