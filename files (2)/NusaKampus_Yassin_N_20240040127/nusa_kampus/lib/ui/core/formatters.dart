const dayNames = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
];

String dayName(int weekday) => dayNames[weekday - 1];

String formatDate(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';
