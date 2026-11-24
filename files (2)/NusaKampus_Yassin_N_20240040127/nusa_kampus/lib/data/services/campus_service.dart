import '../../domain/models/announcement.dart';
import '../../domain/models/course.dart';
import '../../domain/models/task.dart';

/// Simulasi server: mengembalikan data contoh (JSON) setelah jeda jaringan.
class CampusService {
  CampusService({this.latency = const Duration(milliseconds: 800)});

  final Duration latency;

  Future<List<Course>> fetchCourses() async {
    await Future.delayed(latency);
    return _courses.map(Course.fromJson).toList();
  }

  Future<List<Task>> fetchTasks() async {
    await Future.delayed(latency);
    return _tasks.map(Task.fromJson).toList();
  }

  Future<List<Announcement>> fetchAnnouncements() async {
    await Future.delayed(latency);
    return _announcements.map(Announcement.fromJson).toList();
  }

  static const _courses = <Map<String, dynamic>>[
    {'id': 'c1', 'name': 'Pemrograman Perangkat Mobile', 'lecturer': 'Yulhan Wahyudin, M.Kom', 'room': 'Lab 2', 'day': 1, 'start': '08:00', 'end': '10:30'},
    {'id': 'c2', 'name': 'Basis Data', 'lecturer': 'Dr. Rina Kusuma', 'room': 'R. 301', 'day': 1, 'start': '13:00', 'end': '15:00'},
    {'id': 'c3', 'name': 'Jaringan Komputer', 'lecturer': 'Budi Santoso, M.T.', 'room': 'Lab 1', 'day': 2, 'start': '09:00', 'end': '11:30'},
    {'id': 'c4', 'name': 'Rekayasa Perangkat Lunak', 'lecturer': 'Sari Dewi, M.Kom', 'room': 'R. 204', 'day': 3, 'start': '08:00', 'end': '10:00'},
    {'id': 'c5', 'name': 'Kecerdasan Buatan', 'lecturer': 'Dr. Andi Pratama', 'room': 'R. 305', 'day': 3, 'start': '13:00', 'end': '15:30'},
    {'id': 'c6', 'name': 'Sistem Operasi', 'lecturer': 'Hendra Gunawan, M.T.', 'room': 'R. 102', 'day': 4, 'start': '10:00', 'end': '12:00'},
    {'id': 'c7', 'name': 'Pendidikan Pancasila', 'lecturer': 'Dra. Lestari', 'room': 'Aula B', 'day': 5, 'start': '08:00', 'end': '09:40'},
    {'id': 'c8', 'name': 'Praktikum Pemrograman Mobile', 'lecturer': 'Yulhan Wahyudin, M.Kom', 'room': 'Lab 2', 'day': 5, 'start': '13:00', 'end': '15:30'},
  ];

  static const _tasks = <Map<String, dynamic>>[
    {'id': 't1', 'title': 'Membangun aplikasi NusaKampus', 'course': 'Pemrograman Perangkat Mobile', 'due': '2026-11-30T23:59:00', 'isDone': false},
    {'id': 't2', 'title': 'Rancang ERD sistem perpustakaan', 'course': 'Basis Data', 'due': '2026-11-26T23:59:00', 'isDone': false},
    {'id': 't3', 'title': 'Laporan konfigurasi subnetting', 'course': 'Jaringan Komputer', 'due': '2026-11-27T17:00:00', 'isDone': false},
    {'id': 't4', 'title': 'Diagram UML use case', 'course': 'Rekayasa Perangkat Lunak', 'due': '2026-11-28T23:59:00', 'isDone': false},
    {'id': 't5', 'title': 'Ringkasan algoritma A*', 'course': 'Kecerdasan Buatan', 'due': '2026-11-25T12:00:00', 'isDone': true},
  ];

  static const _announcements = <Map<String, dynamic>>[
    {'id': 'a1', 'title': 'UAS Semester Ganjil Dimulai 14 Desember', 'body': 'Ujian Akhir Semester dilaksanakan 14-23 Desember 2026. Pastikan kartu ujian sudah dicetak melalui portal akademik.', 'date': '2026-11-22T09:00:00', 'category': 'Akademik'},
    {'id': 'a2', 'title': 'Pendaftaran Beasiswa Prestasi Dibuka', 'body': 'Mahasiswa dengan IPK minimal 3,50 dapat mendaftar beasiswa prestasi hingga 5 Desember 2026.', 'date': '2026-11-21T13:30:00', 'category': 'Beasiswa'},
    {'id': 'a3', 'title': 'Hackathon Mahasiswa Nusantara 2026', 'body': 'Himpunan Mahasiswa Informatika mengadakan hackathon 48 jam. Pendaftaran gratis, hadiah total Rp15 juta.', 'date': '2026-11-20T10:15:00', 'category': 'Kegiatan'},
    {'id': 'a4', 'title': 'Perawatan Server Portal Akademik', 'body': 'Portal akademik tidak dapat diakses pada Minggu, 29 November pukul 00.00-04.00 WIB.', 'date': '2026-11-19T16:00:00', 'category': 'Sistem'},
  ];
}
