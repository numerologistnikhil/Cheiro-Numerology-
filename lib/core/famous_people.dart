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
    'Freddie Mercury': 'Farrokh Bulsara',
    'Mother Teresa': 'Anjeze Gonxhe Bojaxhiu',
    'Pele': 'Edson Arantes do Nascimento',
    'Muhammad Ali': 'Cassius Marcellus Clay',
    'Marilyn Monroe': 'Norma Jeane Mortenson',
    'Mark Twain': 'Samuel Langhorne Clemens',
    'Dalai Lama': 'Lhamo Thondup',
    'Paramahansa Yogananda': 'Mukunda Lal Ghosh',
    'Sri Aurobindo': 'Aurobindo Ghose',
    'Ramana Maharshi': 'Venkataraman Iyer',
    'Ramakrishna Paramahansa': 'Gadadhar Chattopadhyay',
    'Rajinikanth': 'Shivaji Rao Gaekwad',
    'Walt Disney': 'Walter Elias Disney',
    'Charlie Chaplin': 'Charles Spencer Chaplin',
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
    'Jawaharlal Nehru': [
      LifeEvent(1929, L('Elected Congress president at Lahore; the call for complete independence follows.', 'लाहौर में कांग्रेस अध्यक्ष चुने गए; पूर्ण स्वतंत्रता की माँग उठी।')),
      LifeEvent(1947, L('Becomes the first Prime Minister of India.', 'भारत के पहले प्रधानमंत्री बने।')),
      LifeEvent(1964, L('Dies in office in May.', 'मई में पद पर रहते हुए निधन।')),
    ],
    'Subhas Chandra Bose': [
      LifeEvent(1921, L('Resigns from the Indian Civil Service to join the freedom movement.', 'आज़ादी के आंदोलन के लिए सिविल सेवा से इस्तीफ़ा दिया।')),
      LifeEvent(1938, L('Elected Congress president.', 'कांग्रेस अध्यक्ष चुने गए।')),
      LifeEvent(1943, L('Takes charge of the Indian National Army in Southeast Asia.', 'दक्षिण-पूर्व एशिया में आज़ाद हिंद फ़ौज की कमान सँभाली।')),
    ],
    'Bhagat Singh': [
      LifeEvent(1928, L('Takes part in the shooting of a police officer after Lala Lajpat Rai\'s death.', 'लाला लाजपत राय की मृत्यु के बाद एक पुलिस अधिकारी की हत्या में शामिल हुए।')),
      LifeEvent(1929, L('Throws a bomb in the Central Assembly in Delhi and courts arrest.', 'दिल्ली की केंद्रीय असेंबली में बम फेंका और गिरफ़्तारी दी।')),
      LifeEvent(1931, L('Executed in March, aged 23.', 'मार्च में 23 वर्ष की आयु में फाँसी दी गई।')),
    ],
    'Sardar Vallabhbhai Patel': [
      LifeEvent(1928, L('Leads the Bardoli satyagraha and earns the title "Sardar".', 'बारडोली सत्याग्रह का नेतृत्व किया और "सरदार" की उपाधि पाई।')),
      LifeEvent(1947, L('Becomes the first Deputy Prime Minister and starts uniting the princely states.', 'पहले उप-प्रधानमंत्री बने और रियासतों को जोड़ने का काम शुरू किया।')),
      LifeEvent(1950, L('Dies in December.', 'दिसंबर में निधन।')),
    ],
    'B. R. Ambedkar': [
      LifeEvent(1927, L('Leads the Mahad satyagraha for the right to water.', 'पानी के अधिकार के लिए महाड़ सत्याग्रह का नेतृत्व किया।')),
      LifeEvent(1947, L('Becomes Law Minister and chairs the Constitution drafting committee.', 'क़ानून मंत्री बने और संविधान प्रारूप समिति के अध्यक्ष रहे।')),
      LifeEvent(1956, L('Adopts Buddhism in October and dies in December.', 'अक्टूबर में बौद्ध धर्म अपनाया और दिसंबर में निधन।')),
    ],
    'Indira Gandhi': [
      LifeEvent(1966, L('Becomes Prime Minister of India.', 'भारत की प्रधानमंत्री बनीं।')),
      LifeEvent(1971, L('Bangladesh war; Bangladesh is born.', 'बांग्लादेश युद्ध; बांग्लादेश का जन्म।')),
      LifeEvent(1977, L('Loses the general election after the Emergency.', 'आपातकाल के बाद आम चुनाव हार गईं।')),
      LifeEvent(1984, L('Assassinated in October.', 'अक्टूबर में हत्या हुई।')),
    ],
    'Winston Churchill': [
      LifeEvent(1940, L('Becomes Prime Minister of Britain.', 'ब्रिटेन के प्रधानमंत्री बने।')),
      LifeEvent(1945, L('Loses the election just after the war ends in Europe.', 'यूरोप में युद्ध ख़त्म होते ही चुनाव हार गए।')),
      LifeEvent(1953, L('Wins the Nobel Prize in Literature.', 'साहित्य का नोबेल पुरस्कार जीता।')),
    ],
    'Martin Luther King Jr': [
      LifeEvent(1955, L('Leads the Montgomery bus boycott.', 'मॉन्टगोमरी बस बहिष्कार का नेतृत्व किया।')),
      LifeEvent(1963, L('Gives the "I Have a Dream" speech.', '"आई हैव अ ड्रीम" भाषण दिया।')),
      LifeEvent(1964, L('Wins the Nobel Peace Prize.', 'नोबेल शांति पुरस्कार जीता।')),
      LifeEvent(1968, L('Assassinated in April.', 'अप्रैल में हत्या हुई।')),
    ],
    'John F Kennedy': [
      LifeEvent(1946, L('Elected to the US House of Representatives.', 'अमेरिकी प्रतिनिधि सभा के लिए चुने गए।')),
      LifeEvent(1960, L('Elected President of the United States.', 'अमेरिका के राष्ट्रपति चुने गए।')),
      LifeEvent(1963, L('Assassinated in November.', 'नवंबर में हत्या हुई।')),
    ],
    'Malala Yousafzai': [
      LifeEvent(2014, L('Youngest Nobel Peace Prize winner.', 'नोबेल शांति पुरस्कार की सबसे युवा विजेता।')),
    ],
    'Mother Teresa': [
      LifeEvent(1948, L('Begins her work among the poor in Kolkata.', 'कोलकाता में ग़रीबों के बीच अपना काम शुरू किया।')),
      LifeEvent(1950, L('Founds the Missionaries of Charity.', 'मिशनरीज़ ऑफ़ चैरिटी की स्थापना की।')),
      LifeEvent(1979, L('Wins the Nobel Peace Prize.', 'नोबेल शांति पुरस्कार जीता।')),
      LifeEvent(1997, L('Dies in September.', 'सितंबर में निधन।')),
    ],
    'Marie Curie': [
      LifeEvent(1903, L('Shares the Nobel Prize in Physics.', 'भौतिकी का नोबेल पुरस्कार साझा किया।')),
      LifeEvent(1911, L('Wins the Nobel Prize in Chemistry.', 'रसायन विज्ञान का नोबेल पुरस्कार जीता।')),
      LifeEvent(1934, L('Dies of a blood illness linked to her work with radiation.', 'विकिरण के काम से जुड़ी रक्त की बीमारी से निधन।')),
    ],
    'Stephen Hawking': [
      LifeEvent(1963, L('Diagnosed with motor neurone disease, aged 21.', '21 वर्ष की आयु में मोटर न्यूरॉन बीमारी का पता चला।')),
      LifeEvent(1988, L('Publishes "A Brief History of Time".', '"अ ब्रीफ़ हिस्ट्री ऑफ़ टाइम" प्रकाशित की।')),
      LifeEvent(2018, L('Dies in March.', 'मार्च में निधन।')),
    ],
    'Charles Darwin': [
      LifeEvent(1831, L('Sets sail on HMS Beagle.', 'एचएमएस बीगल पर यात्रा पर निकले।')),
      LifeEvent(1859, L('Publishes "On the Origin of Species".', '"ऑन द ओरिजिन ऑफ़ स्पीशीज़" प्रकाशित की।')),
      LifeEvent(1882, L('Dies in April.', 'अप्रैल में निधन।')),
    ],
    'Thomas Edison': [
      LifeEvent(1877, L('Invents the phonograph.', 'फ़ोनोग्राफ़ का आविष्कार किया।')),
      LifeEvent(1879, L('Shows a practical electric light bulb.', 'काम करने लायक़ बिजली का बल्ब दिखाया।')),
      LifeEvent(1931, L('Dies in October.', 'अक्टूबर में निधन।')),
    ],
    'Srinivasa Ramanujan': [
      LifeEvent(1913, L('Writes to the mathematician G. H. Hardy.', 'गणितज्ञ जी. एच. हार्डी को पत्र लिखा।')),
      LifeEvent(1914, L('Goes to Cambridge.', 'कैम्ब्रिज गए।')),
      LifeEvent(1918, L('Elected Fellow of the Royal Society.', 'रॉयल सोसाइटी के फ़ेलो चुने गए।')),
      LifeEvent(1920, L('Dies, aged 32.', '32 वर्ष की आयु में निधन।')),
    ],
    'C. V. Raman': [
      LifeEvent(1928, L('Discovers the Raman effect.', 'रमन प्रभाव की खोज की।')),
      LifeEvent(1930, L('Wins the Nobel Prize in Physics.', 'भौतिकी का नोबेल पुरस्कार जीता।')),
    ],
    'Rabindranath Tagore': [
      LifeEvent(1913, L('First non-European to win the Nobel Prize in Literature.', 'साहित्य का नोबेल पुरस्कार जीतने वाले पहले ग़ैर-यूरोपीय।')),
      LifeEvent(1919, L('Gives up his knighthood after the Jallianwala Bagh massacre.', 'जलियाँवाला बाग़ हत्याकांड के बाद नाइटहुड लौटा दिया।')),
      LifeEvent(1941, L('Dies in August.', 'अगस्त में निधन।')),
    ],
    'Ratan Tata': [
      LifeEvent(1991, L('Becomes chairman of Tata Sons.', 'टाटा संस के अध्यक्ष बने।')),
      LifeEvent(2000, L('Tata buys Tetley Tea.', 'टाटा ने टेटली टी ख़रीदी।')),
      LifeEvent(2008, L('Tata buys Jaguar Land Rover.', 'टाटा ने जगुआर लैंड रोवर ख़रीदी।')),
    ],
    'Bill Gates': [
      LifeEvent(1975, L('Co-founds Microsoft.', 'माइक्रोसॉफ़्ट की सह-स्थापना की।')),
      LifeEvent(2000, L('Steps down as Microsoft CEO and starts the Gates Foundation.', 'माइक्रोसॉफ़्ट के सीईओ का पद छोड़ा और गेट्स फ़ाउंडेशन शुरू किया।')),
    ],
    'Elon Musk': [
      LifeEvent(2002, L('Founds SpaceX.', 'स्पेसएक्स की स्थापना की।')),
      LifeEvent(2004, L('Joins Tesla as an early investor.', 'शुरुआती निवेशक के रूप में टेस्ला से जुड़े।')),
      LifeEvent(2022, L('Buys Twitter.', 'ट्विटर ख़रीदा।')),
    ],
    'Jeff Bezos': [
      LifeEvent(1994, L('Founds Amazon.', 'अमेज़न की स्थापना की।')),
      LifeEvent(1997, L('Amazon goes public.', 'अमेज़न शेयर बाज़ार में आई।')),
      LifeEvent(2021, L('Steps down as Amazon CEO.', 'अमेज़न के सीईओ का पद छोड़ा।')),
    ],
    'Mark Zuckerberg': [
      LifeEvent(2004, L('Launches Facebook.', 'फ़ेसबुक शुरू किया।')),
      LifeEvent(2012, L('Facebook goes public.', 'फ़ेसबुक शेयर बाज़ार में आई।')),
    ],
    'Walt Disney': [
      LifeEvent(1923, L('Founds the Disney brothers studio.', 'डिज़्नी ब्रदर्स स्टूडियो की स्थापना की।')),
      LifeEvent(1937, L('Releases "Snow White", the first full-length cel-animated film.', '"स्नो व्हाइट" रिलीज़ की, पहली पूरी लंबाई की सेल एनिमेटेड फ़िल्म।')),
      LifeEvent(1955, L('Opens Disneyland.', 'डिज़्नीलैंड खोला।')),
      LifeEvent(1966, L('Dies in December.', 'दिसंबर में निधन।')),
    ],
    'Virat Kohli': [
      LifeEvent(2008, L('Captains India to the Under-19 World Cup win and makes his ODI debut.', 'अंडर-19 विश्व कप में भारत की कप्तानी कर जीत दिलाई और वनडे पदार्पण किया।')),
      LifeEvent(2011, L('Part of the World Cup winning team.', 'विश्व कप जीतने वाली टीम का हिस्सा।')),
      LifeEvent(2014, L('Becomes India\'s Test captain.', 'भारत के टेस्ट कप्तान बने।')),
    ],
    'M S Dhoni': [
      LifeEvent(2007, L('Captains India to the first T20 World Cup title.', 'भारत को पहला टी20 विश्व कप जिताया।')),
      LifeEvent(2011, L('Captains India to the ODI World Cup title.', 'भारत को वनडे विश्व कप जिताया।')),
      LifeEvent(2020, L('Retires from international cricket in August.', 'अगस्त में अंतरराष्ट्रीय क्रिकेट से संन्यास।')),
    ],
    'Kapil Dev': [
      LifeEvent(1983, L('Captains India to the World Cup title at Lord\'s.', 'लॉर्ड्स में भारत को विश्व कप जिताया।')),
    ],
    'Muhammad Ali': [
      LifeEvent(1960, L('Wins Olympic gold in boxing.', 'मुक्केबाज़ी में ओलंपिक स्वर्ण जीता।')),
      LifeEvent(1964, L('Becomes world heavyweight champion.', 'विश्व हेवीवेट चैंपियन बने।')),
      LifeEvent(1967, L('Refuses the military draft and is stripped of his title.', 'सेना में भर्ती से इनकार किया और ख़िताब छिन गया।')),
      LifeEvent(1974, L('Wins "the Rumble in the Jungle".', '"रम्बल इन द जंगल" जीता।')),
    ],
    'Pele': [
      LifeEvent(1958, L('Wins the World Cup, aged 17.', '17 वर्ष की आयु में विश्व कप जीता।')),
      LifeEvent(1970, L('Wins his third World Cup.', 'अपना तीसरा विश्व कप जीता।')),
    ],
    'Diego Maradona': [
      LifeEvent(1986, L('Captains Argentina to the World Cup title.', 'अर्जेंटीना को विश्व कप जिताया।')),
      LifeEvent(1990, L('Argentina reach the World Cup final again.', 'अर्जेंटीना फिर विश्व कप फ़ाइनल में पहुँचा।')),
    ],
    'Lionel Messi': [
      LifeEvent(2004, L('Makes his first-team debut for Barcelona.', 'बार्सिलोना के लिए पहला मैच खेला।')),
      LifeEvent(2021, L('Leaves Barcelona for Paris Saint-Germain.', 'बार्सिलोना छोड़कर पेरिस सेंट-जर्मेन गए।')),
      LifeEvent(2022, L('Wins the World Cup with Argentina.', 'अर्जेंटीना के साथ विश्व कप जीता।')),
    ],
    'Michael Jackson': [
      LifeEvent(1982, L('Releases "Thriller".', '"थ्रिलर" रिलीज़ किया।')),
      LifeEvent(2009, L('Dies in June.', 'जून में निधन।')),
    ],
    'Elvis Presley': [
      LifeEvent(1956, L('Breaks through with "Heartbreak Hotel".', '"हार्टब्रेक होटल" से बड़ी कामयाबी मिली।')),
      LifeEvent(1977, L('Dies in August.', 'अगस्त में निधन।')),
    ],
    'John Lennon': [
      LifeEvent(1957, L('Meets Paul McCartney.', 'पॉल मैकार्टनी से मुलाक़ात हुई।')),
      LifeEvent(1962, L('The Beatles release their first single, "Love Me Do".', 'बीटल्स ने पहला गाना "लव मी डू" जारी किया।')),
      LifeEvent(1980, L('Killed in December.', 'दिसंबर में हत्या हुई।')),
    ],
    'Freddie Mercury': [
      LifeEvent(1970, L('Joins the band that becomes Queen.', 'उस बैंड से जुड़े जो आगे चलकर क्वीन बना।')),
      LifeEvent(1975, L('Queen release "Bohemian Rhapsody".', 'क्वीन ने "बोहेमियन रैप्सोडी" जारी किया।')),
      LifeEvent(1985, L('Queen\'s famous Live Aid performance.', 'क्वीन का मशहूर लाइव एड प्रदर्शन।')),
      LifeEvent(1991, L('Dies in November.', 'नवंबर में निधन।')),
    ],
    'Pablo Picasso': [
      LifeEvent(1907, L('Paints "Les Demoiselles d\'Avignon".', '"लेस डेमोइज़ेल्स डी\'अविग्नॉन" चित्रित किया।')),
      LifeEvent(1937, L('Paints "Guernica".', '"ग्वेर्निका" चित्रित किया।')),
      LifeEvent(1973, L('Dies in April.', 'अप्रैल में निधन।')),
    ],
    'Vincent van Gogh': [
      LifeEvent(1888, L('Moves to Arles and paints some of his best-known work.', 'आर्ल गए और अपने सबसे मशहूर कामों में से कुछ बनाए।')),
      LifeEvent(1890, L('Dies in July, aged 37.', 'जुलाई में 37 वर्ष की आयु में निधन।')),
    ],
    'Amitabh Bachchan': [
      LifeEvent(1969, L('Film debut in "Saat Hindustani".', '"सात हिंदुस्तानी" से फ़िल्मों में पदार्पण।')),
      LifeEvent(1973, L('"Zanjeer" makes him a star.', '"ज़ंजीर" ने उन्हें सितारा बनाया।')),
      LifeEvent(1975, L('"Sholay" is released.', '"शोले" रिलीज़ हुई।')),
    ],
    'Shah Rukh Khan': [
      LifeEvent(1992, L('Film debut with "Deewana".', '"दीवाना" से फ़िल्मी शुरुआत।')),
      LifeEvent(1995, L('"Dilwale Dulhania Le Jayenge" is released.', '"दिलवाले दुल्हनिया ले जाएंगे" रिलीज़ हुई।')),
    ],
    'Satyajit Ray': [
      LifeEvent(1955, L('Releases "Pather Panchali".', '"पाथेर पांचाली" रिलीज़ की।')),
      LifeEvent(1992, L('Receives an honorary Oscar and dies in April.', 'मानद ऑस्कर मिला और अप्रैल में निधन।')),
    ],
    'Taylor Swift': [
      LifeEvent(2006, L('Releases her first album.', 'अपना पहला एल्बम जारी किया।')),
      LifeEvent(2014, L('Releases "1989".', '"1989" जारी किया।')),
      LifeEvent(2023, L('Begins the Eras Tour.', 'एरास टूर शुरू किया।')),
    ],
    'J K Rowling': [
      LifeEvent(1997, L('The first Harry Potter book is published.', 'हैरी पॉटर की पहली किताब प्रकाशित हुई।')),
      LifeEvent(2007, L('The last Harry Potter book is published.', 'हैरी पॉटर की आख़िरी किताब प्रकाशित हुई।')),
    ],
    'Ernest Hemingway': [
      LifeEvent(1926, L('Publishes "The Sun Also Rises".', '"द सन ऑल्सो राइज़ेस" प्रकाशित की।')),
      LifeEvent(1953, L('Wins the Pulitzer Prize.', 'पुलित्ज़र पुरस्कार जीता।')),
      LifeEvent(1954, L('Wins the Nobel Prize in Literature.', 'साहित्य का नोबेल पुरस्कार जीता।')),
    ],
    'Paramahansa Yogananda': [
      LifeEvent(1920, L('Travels to the United States.', 'अमेरिका की यात्रा पर गए।')),
      LifeEvent(1946, L('Publishes "Autobiography of a Yogi".', '"ऑटोबायोग्राफ़ी ऑफ़ अ योगी" प्रकाशित की।')),
      LifeEvent(1952, L('Dies in March.', 'मार्च में निधन।')),
    ],
    'Sri Aurobindo': [
      LifeEvent(1908, L('Arrested in the Alipore bomb case.', 'अलीपुर बम कांड में गिरफ़्तार हुए।')),
      LifeEvent(1910, L('Settles in Pondicherry.', 'पांडिचेरी में बस गए।')),
      LifeEvent(1950, L('Dies in December.', 'दिसंबर में निधन।')),
    ],
    'Dalai Lama': [
      LifeEvent(1940, L('Enthroned as the 14th Dalai Lama.', '14वें दलाई लामा के रूप में पद पर बैठे।')),
      LifeEvent(1959, L('Escapes from Tibet to India.', 'तिब्बत से भारत आ गए।')),
      LifeEvent(1989, L('Wins the Nobel Peace Prize.', 'नोबेल शांति पुरस्कार जीता।')),
    ],
    'Sigmund Freud': [
      LifeEvent(1900, L('Publishes "The Interpretation of Dreams" (dated 1900).', '"द इंटरप्रिटेशन ऑफ़ ड्रीम्स" प्रकाशित की (1900 की तारीख़)।')),
      LifeEvent(1938, L('Leaves Vienna for London.', 'वियना छोड़कर लंदन गए।')),
      LifeEvent(1939, L('Dies in September.', 'सितंबर में निधन।')),
    ],
    'Nikola Tesla': [
      LifeEvent(1884, L('Moves to the United States.', 'अमेरिका चले गए।')),
      LifeEvent(1888, L('Patents his alternating-current motor designs.', 'अपने प्रत्यावर्ती धारा मोटर के डिज़ाइन का पेटेंट कराया।')),
      LifeEvent(1943, L('Dies in January.', 'जनवरी में निधन।')),
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
    'It shows how your own report will read. These are interpretations for learning and curiosity, not claims about the person. They are not an endorsement, and the app has no connection with any of these people. Only public birth dates and well-known public facts are used.',
    'मशहूर लोगों के अंक कैसे दिखते हैं देखिए और एक टैप में मुफ़्त सैंपल रिपोर्ट खोलिए। '
    'इससे पता चलेगा कि आपकी अपनी रिपोर्ट कैसी होगी। ये सीखने और जिज्ञासा के लिए व्याख्याएँ हैं, उस व्यक्ति के बारे में दावे नहीं। यह कोई समर्थन नहीं है और ऐप का इन लोगों से कोई संबंध नहीं है। केवल सार्वजनिक जन्मतिथि और जानी-मानी सार्वजनिक बातें इस्तेमाल हुई हैं।');
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
