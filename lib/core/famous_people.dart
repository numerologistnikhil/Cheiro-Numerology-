import 'root_profiles.dart' show L;

/// A well-known person, used for free sample profiles. Birth dates are
/// public information; names are as the person is commonly known.
class FamousPerson {
  final String name;
  final int year;
  final int month;
  final int day;
  final int category; // index into FamousPeople.categories
  const FamousPerson(this.name, this.year, this.month, this.day, this.category);

  DateTime get dob => DateTime(year, month, day);
}

class FamousPeople {
  static const List<L> categories = [
    L('Leaders and freedom', 'नेता और स्वतंत्रता'),
    L('Spiritual', 'आध्यात्मिक'),
    L('Science and ideas', 'विज्ञान और विचार'),
    L('Business', 'व्यापार'),
    L('Sport', 'खेल'),
    L('Film and music', 'फ़िल्म और संगीत'),
    L('Art and writing', 'कला और लेखन'),
  ];

  static const L title = L('Famous People', 'मशहूर हस्तियाँ');
  static const L intro = L(
    'See how the numbers look for well-known people and open a free sample report with one tap. '
    'It shows how your own report will read. These are interpretations for learning and curiosity, not claims about the person, and not an endorsement.',
    'मशहूर लोगों के अंक कैसे दिखते हैं देखिए और एक टैप में मुफ़्त सैंपल रिपोर्ट खोलिए। '
    'इससे पता चलेगा कि आपकी अपनी रिपोर्ट कैसी होगी। ये सीखने और जिज्ञासा के लिए व्याख्याएँ हैं, उस व्यक्ति के बारे में दावे नहीं, और न कोई समर्थन।');
  static const L search = L('Search a name', 'नाम खोजिए');
  static const L all = L('All', 'सभी');
  static const L born = L('Born', 'जन्म');
  static const L mulank = L('Mulank', 'मूलांक');
  static const L bhagyank = L('Bhagyank', 'भाग्यांक');
  static const L nameNo = L('Name number', 'नाम अंक');
  static const L lifePath = L('Life Path (Western)', 'लाइफ पाथ (पश्चिमी)');
  static const L openReport = L('Open free sample report', 'मुफ़्त सैंपल रिपोर्ट खोलें');
  static const L free = L('Free. No charge, and it does not use your own free report.', 'बिल्कुल मुफ़्त। कोई शुल्क नहीं और आपकी अपनी मुफ़्त रिपोर्ट इस्तेमाल नहीं होती।');
  static const L making = L('Making the report...', 'रिपोर्ट बन रही है...');
  static const L failed = L('Could not make the report. Please try again.', 'रिपोर्ट नहीं बन सकी। कृपया फिर कोशिश करें।');
  static const L noMatch = L('No match. Try another spelling.', 'कोई मेल नहीं। दूसरी स्पेलिंग आज़माइए।');
  static const L about = L('About this profile', 'इस प्रोफ़ाइल के बारे में');

  static const List<FamousPerson> people = [
    FamousPerson('Mahatma Gandhi', 1869, 10, 2, 0),
    FamousPerson('Jawaharlal Nehru', 1889, 11, 14, 0),
    FamousPerson('Subhas Chandra Bose', 1897, 1, 23, 0),
    FamousPerson('Bhagat Singh', 1907, 9, 28, 0),
    FamousPerson('Sardar Vallabhbhai Patel', 1875, 10, 31, 0),
    FamousPerson('B. R. Ambedkar', 1891, 4, 14, 0),
    FamousPerson('Indira Gandhi', 1917, 11, 19, 0),
    FamousPerson('Lal Bahadur Shastri', 1904, 10, 2, 0),
    FamousPerson('Sarojini Naidu', 1879, 2, 13, 0),
    FamousPerson('Abraham Lincoln', 1809, 2, 12, 0),
    FamousPerson('Winston Churchill', 1874, 11, 30, 0),
    FamousPerson('Nelson Mandela', 1918, 7, 18, 0),
    FamousPerson('Martin Luther King Jr', 1929, 1, 15, 0),
    FamousPerson('John F Kennedy', 1917, 5, 29, 0),
    FamousPerson('Malala Yousafzai', 1997, 7, 12, 0),
    FamousPerson('Greta Thunberg', 2003, 1, 3, 0),
    FamousPerson('Swami Vivekananda', 1863, 1, 12, 1),
    FamousPerson('Sri Aurobindo', 1872, 8, 15, 1),
    FamousPerson('Mother Teresa', 1910, 8, 26, 1),
    FamousPerson('Ramana Maharshi', 1879, 12, 30, 1),
    FamousPerson('Ramakrishna Paramahansa', 1836, 2, 18, 1),
    FamousPerson('Paramahansa Yogananda', 1893, 1, 5, 1),
    FamousPerson('Sri Sri Ravi Shankar', 1956, 5, 13, 1),
    FamousPerson('Dalai Lama', 1935, 7, 6, 1),
    FamousPerson('Albert Einstein', 1879, 3, 14, 2),
    FamousPerson('Nikola Tesla', 1856, 7, 10, 2),
    FamousPerson('Marie Curie', 1867, 11, 7, 2),
    FamousPerson('Stephen Hawking', 1942, 1, 8, 2),
    FamousPerson('Charles Darwin', 1809, 2, 12, 2),
    FamousPerson('Thomas Edison', 1847, 2, 11, 2),
    FamousPerson('Sigmund Freud', 1856, 5, 6, 2),
    FamousPerson('Carl Jung', 1875, 7, 26, 2),
    FamousPerson('A. P. J. Abdul Kalam', 1931, 10, 15, 2),
    FamousPerson('Srinivasa Ramanujan', 1887, 12, 22, 2),
    FamousPerson('C. V. Raman', 1888, 11, 7, 2),
    FamousPerson('Homi Bhabha', 1909, 10, 30, 2),
    FamousPerson('Vikram Sarabhai', 1919, 8, 12, 2),
    FamousPerson('Ratan Tata', 1937, 12, 28, 3),
    FamousPerson('Dhirubhai Ambani', 1932, 12, 28, 3),
    FamousPerson('Mukesh Ambani', 1957, 4, 19, 3),
    FamousPerson('Narayana Murthy', 1946, 8, 20, 3),
    FamousPerson('Azim Premji', 1945, 7, 24, 3),
    FamousPerson('Gautam Adani', 1962, 6, 24, 3),
    FamousPerson('Sudha Murty', 1950, 8, 19, 3),
    FamousPerson('Bill Gates', 1955, 10, 28, 3),
    FamousPerson('Steve Jobs', 1955, 2, 24, 3),
    FamousPerson('Elon Musk', 1971, 6, 28, 3),
    FamousPerson('Jeff Bezos', 1964, 1, 12, 3),
    FamousPerson('Mark Zuckerberg', 1984, 5, 14, 3),
    FamousPerson('Walt Disney', 1901, 12, 5, 3),
    FamousPerson('Oprah Winfrey', 1954, 1, 29, 3),
    FamousPerson('Sachin Tendulkar', 1973, 4, 24, 4),
    FamousPerson('Virat Kohli', 1988, 11, 5, 4),
    FamousPerson('M S Dhoni', 1981, 7, 7, 4),
    FamousPerson('Kapil Dev', 1959, 1, 6, 4),
    FamousPerson('Sunil Gavaskar', 1949, 7, 10, 4),
    FamousPerson('Sourav Ganguly', 1972, 7, 8, 4),
    FamousPerson('Rahul Dravid', 1973, 1, 11, 4),
    FamousPerson('Mary Kom', 1983, 3, 1, 4),
    FamousPerson('P V Sindhu', 1995, 7, 5, 4),
    FamousPerson('Neeraj Chopra', 1997, 12, 24, 4),
    FamousPerson('Muhammad Ali', 1942, 1, 17, 4),
    FamousPerson('Pele', 1940, 10, 23, 4),
    FamousPerson('Diego Maradona', 1960, 10, 30, 4),
    FamousPerson('Lionel Messi', 1987, 6, 24, 4),
    FamousPerson('Cristiano Ronaldo', 1985, 2, 5, 4),
    FamousPerson('Michael Jordan', 1963, 2, 17, 4),
    FamousPerson('Serena Williams', 1981, 9, 26, 4),
    FamousPerson('Roger Federer', 1981, 8, 8, 4),
    FamousPerson('Amitabh Bachchan', 1942, 10, 11, 5),
    FamousPerson('Shah Rukh Khan', 1965, 11, 2, 5),
    FamousPerson('Lata Mangeshkar', 1929, 9, 28, 5),
    FamousPerson('A R Rahman', 1967, 1, 6, 5),
    FamousPerson('Rajinikanth', 1950, 12, 12, 5),
    FamousPerson('Priyanka Chopra', 1982, 7, 18, 5),
    FamousPerson('Deepika Padukone', 1986, 1, 5, 5),
    FamousPerson('Aishwarya Rai', 1973, 11, 1, 5),
    FamousPerson('Satyajit Ray', 1921, 5, 2, 5),
    FamousPerson('Pandit Ravi Shankar', 1920, 4, 7, 5),
    FamousPerson('Michael Jackson', 1958, 8, 29, 5),
    FamousPerson('Elvis Presley', 1935, 1, 8, 5),
    FamousPerson('John Lennon', 1940, 10, 9, 5),
    FamousPerson('Paul McCartney', 1942, 6, 18, 5),
    FamousPerson('Freddie Mercury', 1946, 9, 5, 5),
    FamousPerson('Taylor Swift', 1989, 12, 13, 5),
    FamousPerson('Beyonce', 1981, 9, 4, 5),
    FamousPerson('Marilyn Monroe', 1926, 6, 1, 5),
    FamousPerson('Audrey Hepburn', 1929, 5, 4, 5),
    FamousPerson('Charlie Chaplin', 1889, 4, 16, 5),
    FamousPerson('Bruce Lee', 1940, 11, 27, 5),
    FamousPerson('Rabindranath Tagore', 1861, 5, 7, 6),
    FamousPerson('Leonardo da Vinci', 1452, 4, 15, 6),
    FamousPerson('Wolfgang Amadeus Mozart', 1756, 1, 27, 6),
    FamousPerson('Pablo Picasso', 1881, 10, 25, 6),
    FamousPerson('Vincent van Gogh', 1853, 3, 30, 6),
    FamousPerson('Mark Twain', 1835, 11, 30, 6),
    FamousPerson('Leo Tolstoy', 1828, 9, 9, 6),
    FamousPerson('Charles Dickens', 1812, 2, 7, 6),
    FamousPerson('Ernest Hemingway', 1899, 7, 21, 6),
    FamousPerson('J K Rowling', 1965, 7, 31, 6),
  ];
}
