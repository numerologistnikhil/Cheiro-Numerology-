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

  /// The name given at birth, where it differs from the name people use.
  /// A title such as "Mahatma" is not part of the birth name.
  String get reportName => FamousPeople.birthNames[name] ?? name;

  /// Well-known events of this person's life, by year (may be empty).
  List<LifeEvent> get events => FamousPeople.lifeEvents[name] ?? const [];

  DateTime get dob => DateTime(year, month, day);
}

/// One well-known event in a person's life.
class LifeEvent {
  final int year;
  final L what;
  const LifeEvent(this.year, this.what);
}

class FamousPeople {
  static const Map<String, String> birthNames = {
    'Mahatma Gandhi': 'Mohandas Karamchand Gandhi',
    'Swami Vivekananda': 'Narendranath Datta',
    'A. P. J. Abdul Kalam': 'Avul Pakir Jainulabdeen Abdul Kalam',
  };

  /// Only events whose year is well documented.
  static const Map<String, List<LifeEvent>> lifeEvents = {
    'Mahatma Gandhi': [
      LifeEvent(1888, L('Sails to London to study law.', 'क़ानून पढ़ने के लिए लंदन रवाना हुए।')),
      LifeEvent(1893, L('Goes to South Africa; faces racial insult on a train.', 'दक्षिण अफ़्रीका गए; ट्रेन में नस्लीय अपमान झेला।')),
      LifeEvent(1915, L('Returns to India for good.', 'हमेशा के लिए भारत लौटे।')),
      LifeEvent(1917, L('Champaran satyagraha, his first success in India.', 'चंपारण सत्याग्रह, भारत में पहली सफलता।')),
      LifeEvent(1930, L('Salt March to Dandi.', 'दांडी तक नमक यात्रा।')),
      LifeEvent(1942, L('Quit India movement; jailed.', 'भारत छोड़ो आंदोलन; जेल गए।')),
      LifeEvent(1947, L('India becomes independent.', 'भारत आज़ाद हुआ।')),
      LifeEvent(1948, L('Assassinated in January, aged 78.', 'जनवरी में 78 वर्ष की आयु में हत्या हुई।')),
    ],
    'Albert Einstein': [
      LifeEvent(1905, L('His "miracle year": papers on special relativity and the photoelectric effect.', 'उनका "चमत्कार वर्ष": विशेष सापेक्षता और प्रकाश-विद्युत प्रभाव पर शोध-पत्र।')),
      LifeEvent(1915, L('Completes the general theory of relativity.', 'सामान्य सापेक्षता का सिद्धांत पूरा किया।')),
      LifeEvent(1921, L('Nobel Prize in Physics for the photoelectric effect (awarded in 1922).', 'प्रकाश-विद्युत प्रभाव के लिए भौतिकी का नोबेल पुरस्कार (1922 में दिया गया)।')),
      LifeEvent(1933, L('Leaves Germany and settles in the USA.', 'जर्मनी छोड़कर अमेरिका में बस गए।')),
      LifeEvent(1955, L('Dies at Princeton.', 'प्रिंसटन में निधन।')),
    ],
    'Nelson Mandela': [
      LifeEvent(1944, L('Helps found the ANC Youth League.', 'एएनसी यूथ लीग की स्थापना में मदद की।')),
      LifeEvent(1964, L('Sentenced to life in prison at the Rivonia trial.', 'रिवोनिया मुक़दमे में उम्रक़ैद की सज़ा मिली।')),
      LifeEvent(1990, L('Released after 27 years in prison.', '27 साल जेल के बाद रिहा हुए।')),
      LifeEvent(1993, L('Shares the Nobel Peace Prize.', 'नोबेल शांति पुरस्कार साझा किया।')),
      LifeEvent(1994, L('Elected President of South Africa.', 'दक्षिण अफ़्रीका के राष्ट्रपति चुने गए।')),
      LifeEvent(2013, L('Dies, aged 95.', '95 वर्ष की आयु में निधन।')),
    ],
    'Abraham Lincoln': [
      LifeEvent(1846, L('Elected to the US House of Representatives.', 'अमेरिकी प्रतिनिधि सभा के लिए चुने गए।')),
      LifeEvent(1860, L('Elected President of the United States.', 'अमेरिका के राष्ट्रपति चुने गए।')),
      LifeEvent(1863, L('Issues the Emancipation Proclamation.', 'मुक्ति घोषणा जारी की।')),
      LifeEvent(1865, L('Assassinated in April, just after the Civil War ended.', 'गृहयुद्ध ख़त्म होते ही अप्रैल में हत्या हुई।')),
    ],
    'Swami Vivekananda': [
      LifeEvent(1886, L('His teacher Ramakrishna dies; he takes up the monk\'s path.', 'गुरु रामकृष्ण का देहांत; उन्होंने संन्यास का मार्ग अपनाया।')),
      LifeEvent(1893, L('Speaks at the Parliament of the World\'s Religions in Chicago.', 'शिकागो की विश्व धर्म संसद में भाषण दिया।')),
      LifeEvent(1897, L('Founds the Ramakrishna Mission.', 'रामकृष्ण मिशन की स्थापना की।')),
      LifeEvent(1902, L('Dies at Belur Math, aged 39.', '39 वर्ष की आयु में बेलूर मठ में निधन।')),
    ],
    'A. P. J. Abdul Kalam': [
      LifeEvent(1980, L('Leads the launch of SLV-3, India\'s first satellite launch vehicle to place a satellite in orbit.', 'एसएलवी-3 के प्रक्षेपण का नेतृत्व किया, जिसने भारत का उपग्रह कक्षा में पहुँचाया।')),
      LifeEvent(1998, L('Pokhran-II nuclear tests, in which he played a leading role.', 'पोखरण-II परमाणु परीक्षण, जिनमें उनकी बड़ी भूमिका रही।')),
      LifeEvent(2002, L('Elected the 11th President of India.', 'भारत के 11वें राष्ट्रपति चुने गए।')),
      LifeEvent(2015, L('Dies while giving a lecture at IIM Shillong.', 'आईआईएम शिलांग में व्याख्यान देते समय निधन।')),
    ],
    'Steve Jobs': [
      LifeEvent(1976, L('Co-founds Apple.', 'एप्पल की सह-स्थापना की।')),
      LifeEvent(1985, L('Leaves Apple after a power struggle.', 'सत्ता संघर्ष के बाद एप्पल छोड़ी।')),
      LifeEvent(1997, L('Returns to Apple.', 'एप्पल में वापसी की।')),
      LifeEvent(2007, L('Introduces the iPhone.', 'आईफ़ोन पेश किया।')),
      LifeEvent(2011, L('Dies in October.', 'अक्टूबर में निधन।')),
    ],
    'Sachin Tendulkar': [
      LifeEvent(1989, L('Makes his Test debut against Pakistan, aged 16.', '16 साल की उम्र में पाकिस्तान के विरुद्ध टेस्ट पदार्पण।')),
      LifeEvent(2010, L('First man to score an ODI double century.', 'वनडे में दोहरा शतक लगाने वाले पहले पुरुष खिलाड़ी।')),
      LifeEvent(2011, L('India win the World Cup; his only title.', 'भारत विश्व कप जीता; यह उनका एकमात्र ख़िताब रहा।')),
      LifeEvent(2013, L('Retires from Test cricket after his 200th Test.', '200वें टेस्ट के बाद टेस्ट क्रिकेट से संन्यास।')),
    ],
  };

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
