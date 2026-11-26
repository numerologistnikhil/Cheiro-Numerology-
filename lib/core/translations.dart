/// Screen texts in more languages. The app's long texts and the PDF report
/// are in English and Hindi; the home screen, menus and tabs are translated
/// here. A text with no translation is shown in English.
class Translations {
  Translations._();

  static const List<String> codes = <String>['es', 'fr', 'de', 'pt', 'ru', 'ar', 'bn', 'id', 'zh', 'ja'];

  /// English text -> one text per language, in the order of [codes].
  static const Map<String, List<String>> table = <String, List<String>>{
    'My Numbers': <String>['Mis números', 'Mes nombres', 'Meine Zahlen', 'Meus números', 'Мои числа', 'أرقامي', 'আমার সংখ্যা', 'Angka Saya', '我的数字', '私の数字'],
    'Birth and destiny number': <String>['Número de nacimiento y destino', 'Nombre de naissance et de destin', 'Geburts- und Schicksalszahl', 'Número de nascimento e destino', 'Число рождения и судьбы', 'رقم الميلاد والقدر', 'জন্ম ও ভাগ্য সংখ্যা', 'Angka lahir dan takdir', '生日数与命运数', '誕生数と運命数'],
    'PDF Report': <String>['Informe PDF', 'Rapport PDF', 'PDF-Bericht', 'Relatório PDF', 'PDF-отчёт', 'تقرير PDF', 'PDF রিপোর্ট', 'Laporan PDF', 'PDF 报告', 'PDFレポート'],
    'Download, print, share': <String>['Descargar, imprimir, compartir', 'Télécharger, imprimer, partager', 'Laden, drucken, teilen', 'Baixar, imprimir, compartilhar', 'Скачать, печать, отправить', 'تنزيل وطباعة ومشاركة', 'ডাউনলোড, প্রিন্ট, শেয়ার', 'Unduh, cetak, bagikan', '下载、打印、分享', '保存・印刷・共有'],
    'Client Vault': <String>['Bóveda de clientes', 'Coffre clients', 'Kunden-Tresor', 'Cofre de clientes', 'Хранилище клиентов', 'خزنة العملاء', 'ক্লায়েন্ট ভল্ট', 'Brankas Klien', '客户保险库', '顧客ボールト'],
    'Private and safe': <String>['Privado y seguro', 'Privé et sûr', 'Privat und sicher', 'Privado e seguro', 'Приватно и безопасно', 'خاص وآمن', 'ব্যক্তিগত ও নিরাপদ', 'Pribadi dan aman', '私密且安全', 'プライベートで安全'],
    'Know your numbers': <String>['Conoce tus números', 'Découvrez vos nombres', 'Kenne deine Zahlen', 'Conheça seus números', 'Узнайте свои числа', 'تعرّف على أرقامك', 'আপনার সংখ্যা জানুন', 'Kenali angka Anda', '了解你的数字', 'あなたの数字を知る'],
    'Birth date, name, phone, vehicle and more.': <String>['Fecha de nacimiento, nombre, teléfono, vehículo y más.', 'Date de naissance, nom, téléphone, véhicule et plus.', 'Geburtsdatum, Name, Telefon, Fahrzeug und mehr.', 'Data de nascimento, nome, telefone, veículo e mais.', 'Дата рождения, имя, телефон, автомобиль и другое.', 'تاريخ الميلاد والاسم والهاتف والمركبة والمزيد.', 'জন্ম তারিখ, নাম, ফোন, যান এবং আরও অনেক কিছু।', 'Tanggal lahir, nama, telepon, kendaraan, dan lainnya.', '出生日期、姓名、电话、车辆等。', '生年月日、名前、電話、車など。'],
    'Name': <String>['Nombre', 'Nom', 'Name', 'Nome', 'Имя', 'الاسم', 'নাম', 'Nama', '姓名', '名前'],
    'Check and correct': <String>['Revisa y corrige', 'Vérifier et corriger', 'Prüfen und korrigieren', 'Verifique e corrija', 'Проверить и исправить', 'تحقق وصحّح', 'যাচাই ও সংশোধন', 'Periksa dan perbaiki', '检查并修正', '確認と修正'],
    'Mobile': <String>['Móvil', 'Mobile', 'Handy', 'Celular', 'Телефон', 'الجوال', 'মোবাইল', 'Ponsel', '手机', '携帯'],
    'Is it lucky?': <String>['¿Es de suerte?', 'Porte-bonheur ?', 'Ist es glücklich?', 'É sortudo?', 'Это к удаче?', 'هل هو محظوظ؟', 'এটি কি শুভ?', 'Apakah beruntung?', '吉利吗？', '幸運ですか？'],
    'Vehicle': <String>['Vehículo', 'Véhicule', 'Fahrzeug', 'Veículo', 'Автомобиль', 'المركبة', 'যান', 'Kendaraan', '车辆', '車'],
    'Check a number': <String>['Revisa un número', 'Vérifier un numéro', 'Nummer prüfen', 'Verifique um número', 'Проверить номер', 'تحقق من رقم', 'একটি নম্বর যাচাই করুন', 'Periksa nomor', '检查号码', '番号を確認'],
    'Business': <String>['Negocio', 'Entreprise', 'Geschäft', 'Negócio', 'Бизнес', 'الأعمال', 'ব্যবসা', 'Bisnis', '生意', 'ビジネス'],
    'Name and number': <String>['Nombre y número', 'Nom et numéro', 'Name und Nummer', 'Nome e número', 'Имя и число', 'الاسم والرقم', 'নাম ও সংখ্যা', 'Nama dan angka', '名称与数字', '名前と数字'],
    'Match': <String>['Compatibilidad', 'Compatibilité', 'Passung', 'Compatibilidade', 'Совместимость', 'التوافق', 'মিল', 'Kecocokan', '配对', '相性'],
    'Two people': <String>['Dos personas', 'Deux personnes', 'Zwei Personen', 'Duas pessoas', 'Двое людей', 'شخصان', 'দুজন মানুষ', 'Dua orang', '两个人', '二人'],
    'Lo Shu Grid': <String>['Cuadrícula Lo Shu', 'Grille Lo Shu', 'Lo-Shu-Gitter', 'Grade Lo Shu', 'Квадрат Ло Шу', 'شبكة لو شو', 'লো শু গ্রিড', 'Kotak Lo Shu', '洛书九宫格', '洛書グリッド'],
    'Strong, missing': <String>['Fuertes, faltantes', 'Forts, manquants', 'Stark, fehlend', 'Fortes, ausentes', 'Сильные, отсутствующие', 'القوية والناقصة', 'শক্তিশালী, অনুপস্থিত', 'Kuat, hilang', '强项与缺失', '強い数・欠けた数'],
    'Western Chart': <String>['Carta occidental', 'Thème occidental', 'Westliches Diagramm', 'Mapa ocidental', 'Западная карта', 'المخطط الغربي', 'পশ্চিমী চার্ট', 'Bagan Barat', '西方图表', '西洋チャート'],
    'Life Path, Soul Urge': <String>['Camino de vida, impulso del alma', 'Chemin de vie, élan de l’âme', 'Lebenszahl, Seelenzahl', 'Caminho de vida, desejo da alma', 'Путь жизни, зов души', 'مسار الحياة ورغبة الروح', 'জীবনপথ, আত্মার ইচ্ছা', 'Jalur hidup, dorongan jiwa', '生命数、灵魂数', 'ライフパス、ソウルアージ'],
    'Look at your future': <String>['Mira tu futuro', 'Regardez votre avenir', 'Blick in deine Zukunft', 'Veja seu futuro', 'Взгляд в будущее', 'انظر إلى مستقبلك', 'আপনার ভবিষ্যৎ দেখুন', 'Lihat masa depan Anda', '看看你的未来', '未来を見る'],
    'Your years, months and good dates.': <String>['Tus años, meses y fechas favorables.', 'Vos années, mois et bonnes dates.', 'Deine Jahre, Monate und günstigen Tage.', 'Seus anos, meses e boas datas.', 'Ваши годы, месяцы и удачные даты.', 'سنواتك وشهورك وتواريخك الجيدة.', 'আপনার বছর, মাস ও শুভ তারিখ।', 'Tahun, bulan, dan tanggal baik Anda.', '你的年份、月份和吉日。', 'あなたの年・月・吉日。'],
    'Years and Months': <String>['Años y meses', 'Années et mois', 'Jahre und Monate', 'Anos e meses', 'Годы и месяцы', 'السنوات والشهور', 'বছর ও মাস', 'Tahun dan bulan', '年与月', '年と月'],
    '10 years and more': <String>['10 años o más', '10 ans et plus', '10 Jahre und mehr', '10 anos ou mais', '10 лет и больше', '10 سنوات أو أكثر', '১০ বছর বা তার বেশি', '10 tahun atau lebih', '10年或更多', '10年以上'],
    'Cheiro Timing': <String>['Tiempos de Cheiro', 'Cycles de Cheiro', 'Cheiro-Zeitplan', 'Tempo de Cheiro', 'Время по Чейро', 'توقيت شيرو', 'চেইরো টাইমিং', 'Waktu Cheiro', '凯罗时运', 'キロの時期'],
    'Year, month, day': <String>['Año, mes, día', 'Année, mois, jour', 'Jahr, Monat, Tag', 'Ano, mês, dia', 'Год, месяц, день', 'سنة وشهر ويوم', 'বছর, মাস, দিন', 'Tahun, bulan, hari', '年、月、日', '年・月・日'],
    'Today': <String>['Hoy', 'Aujourd’hui', 'Heute', 'Hoje', 'Сегодня', 'اليوم', 'আজ', 'Hari ini', '今天', '今日'],
    'Lucky number, colour': <String>['Número y color de suerte', 'Nombre et couleur chance', 'Glückszahl, Farbe', 'Número e cor da sorte', 'Счастливое число, цвет', 'رقم ولون الحظ', 'শুভ সংখ্যা, রং', 'Angka dan warna keberuntungan', '幸运数字与颜色', 'ラッキー数字・色'],
    'Good Dates': <String>['Fechas favorables', 'Bonnes dates', 'Günstige Tage', 'Boas datas', 'Удачные даты', 'تواريخ جيدة', 'শুভ তারিখ', 'Tanggal baik', '吉日', '吉日'],
    'Pick a lucky day': <String>['Elige un día de suerte', 'Choisir un jour chance', 'Glückstag wählen', 'Escolha um dia de sorte', 'Выберите счастливый день', 'اختر يوم حظ', 'শুভ দিন বেছে নিন', 'Pilih hari baik', '选择吉日', '吉日を選ぶ'],
    'Baby Names': <String>['Nombres de bebé', 'Prénoms de bébé', 'Babynamen', 'Nomes de bebê', 'Имена для малыша', 'أسماء الأطفال', 'শিশুর নাম', 'Nama bayi', '宝宝取名', '赤ちゃんの名前'],
    'Lucky names': <String>['Nombres de suerte', 'Noms chanceux', 'Glücksnamen', 'Nomes da sorte', 'Счастливые имена', 'أسماء الحظ', 'শুভ নাম', 'Nama beruntung', '吉祥名字', '幸運な名前'],
    'Guidance for life': <String>['Guía para la vida', 'Conseils pour la vie', 'Lebensberatung', 'Orientação para a vida', 'Советы для жизни', 'إرشاد للحياة', 'জীবনের পথনির্দেশ', 'Panduan hidup', '人生指引', '人生のガイド'],
    'Stones, beads, career, health and easy remedies.': <String>['Piedras, cuentas, carrera, salud y remedios sencillos.', 'Pierres, perles, carrière, santé et remèdes simples.', 'Steine, Perlen, Beruf, Gesundheit und einfache Mittel.', 'Pedras, contas, carreira, saúde e remédios simples.', 'Камни, чётки, карьера, здоровье и простые советы.', 'أحجار وخرز ومهنة وصحة وحلول بسيطة.', 'রত্ন, মালা, ক্যারিয়ার, স্বাস্থ্য ও সহজ উপায়।', 'Batu, manik, karier, kesehatan, dan solusi mudah.', '宝石、念珠、事业、健康与简易调理。', '宝石、数珠、仕事、健康、簡単な開運法。'],
    'Gemstones': <String>['Gemas', 'Pierres précieuses', 'Edelsteine', 'Pedras preciosas', 'Драгоценные камни', 'الأحجار الكريمة', 'রত্ন', 'Batu permata', '宝石', '宝石'],
    'Stone, finger, weight': <String>['Piedra, dedo, peso', 'Pierre, doigt, poids', 'Stein, Finger, Gewicht', 'Pedra, dedo, peso', 'Камень, палец, вес', 'الحجر والإصبع والوزن', 'রত্ন, আঙুল, ওজন', 'Batu, jari, berat', '宝石、手指、重量', '石・指・重さ'],
    'Rudraksha': <String>['Rudraksha', 'Rudraksha', 'Rudraksha', 'Rudraksha', 'Рудракша', 'رودراكشا', 'রুদ্রাক্ষ', 'Rudraksha', '金刚菩提', 'ルドラクシャ'],
    'Which bead to wear': <String>['Qué cuenta usar', 'Quelle perle porter', 'Welche Perle tragen', 'Qual conta usar', 'Какую бусину носить', 'أي خرزة ترتدي', 'কোন মালা পরবেন', 'Manik mana yang dipakai', '佩戴哪种珠', 'どの珠を着けるか'],
    'Career': <String>['Carrera', 'Carrière', 'Beruf', 'Carreira', 'Карьера', 'المهنة', 'ক্যারিয়ার', 'Karier', '事业', '仕事'],
    'Work and business': <String>['Trabajo y negocios', 'Travail et affaires', 'Arbeit und Geschäft', 'Trabalho e negócios', 'Работа и бизнес', 'العمل والتجارة', 'কাজ ও ব্যবসা', 'Kerja dan bisnis', '工作与生意', '仕事とビジネス'],
    'Health Care': <String>['Cuidado de la salud', 'Soins de santé', 'Gesundheitspflege', 'Cuidados com a saúde', 'Забота о здоровье', 'الرعاية الصحية', 'স্বাস্থ্যসেবা', 'Perawatan kesehatan', '健康护理', '健康ケア'],
    'Care and precautions': <String>['Cuidados y precauciones', 'Soins et précautions', 'Pflege und Vorsicht', 'Cuidados e precauções', 'Забота и меры предосторожности', 'العناية والاحتياطات', 'যত্ন ও সতর্কতা', 'Perawatan dan kewaspadaan', '护理与注意事项', 'ケアと注意点'],
    'Colours and Habits': <String>['Colores y hábitos', 'Couleurs et habitudes', 'Farben und Gewohnheiten', 'Cores e hábitos', 'Цвета и привычки', 'الألوان والعادات', 'রং ও অভ্যাস', 'Warna dan kebiasaan', '颜色与习惯', '色と習慣'],
    'Easy daily remedies': <String>['Remedios diarios sencillos', 'Remèdes quotidiens simples', 'Einfache Alltagsmittel', 'Remédios diários simples', 'Простые ежедневные средства', 'حلول يومية بسيطة', 'সহজ দৈনন্দিন উপায়', 'Solusi harian mudah', '简单的日常调理', '毎日の簡単な開運法'],
    'Signature': <String>['Firma', 'Signature', 'Unterschrift', 'Assinatura', 'Подпись', 'التوقيع', 'স্বাক্ষর', 'Tanda tangan', '签名', '署名'],
    'Upload and analyse': <String>['Sube y analiza', 'Importer et analyser', 'Hochladen und analysieren', 'Envie e analise', 'Загрузить и проанализировать', 'ارفع وحلّل', 'আপলোড ও বিশ্লেষণ', 'Unggah dan analisis', '上传并分析', 'アップロードして分析'],
    'Explore and learn': <String>['Explora y aprende', 'Explorez et apprenez', 'Entdecken und lernen', 'Explore e aprenda', 'Изучайте и узнавайте', 'استكشف وتعلّم', 'জানুন ও শিখুন', 'Jelajahi dan belajar', '探索与学习', '探索して学ぶ'],
    'Famous people, lessons and questions.': <String>['Personajes famosos, lecciones y preguntas.', 'Personnalités, leçons et questions.', 'Berühmte Persönlichkeiten, Lektionen und Fragen.', 'Pessoas famosas, lições e perguntas.', 'Известные люди, уроки и вопросы.', 'مشاهير ودروس وأسئلة.', 'বিখ্যাত ব্যক্তি, পাঠ ও প্রশ্ন।', 'Tokoh terkenal, pelajaran, dan pertanyaan.', '名人、课程与问答。', '有名人、レッスン、質問。'],
    'Famous People': <String>['Personajes famosos', 'Personnalités', 'Berühmte Persönlichkeiten', 'Pessoas famosas', 'Известные люди', 'مشاهير', 'বিখ্যাত ব্যক্তি', 'Tokoh terkenal', '名人', '有名人'],
    '100 free samples': <String>['100 muestras gratis', '100 exemples gratuits', '100 kostenlose Beispiele', '100 amostras grátis', '100 бесплатных примеров', '100 عينة مجانية', '১০০টি বিনামূল্যে নমুনা', '100 contoh gratis', '100个免费样本', '無料サンプル100件'],
    'Learn and Quiz': <String>['Aprende y cuestionario', 'Apprendre et quiz', 'Lernen und Quiz', 'Aprenda e quiz', 'Учиться и викторина', 'تعلّم واختبار', 'শিখুন ও কুইজ', 'Belajar dan kuis', '学习与测验', '学習とクイズ'],
    'Understand numbers': <String>['Entiende los números', 'Comprendre les nombres', 'Zahlen verstehen', 'Entenda os números', 'Понять числа', 'افهم الأرقام', 'সংখ্যা বুঝুন', 'Pahami angka', '理解数字', '数字を理解する'],
    'Angel Numbers': <String>['Números ángel', 'Nombres angéliques', 'Engelszahlen', 'Números anjo', 'Ангельские числа', 'أرقام الملائكة', 'এঞ্জেল নম্বর', 'Angka malaikat', '天使数字', 'エンジェルナンバー'],
    'Repeating numbers': <String>['Números repetidos', 'Nombres répétés', 'Wiederholte Zahlen', 'Números repetidos', 'Повторяющиеся числа', 'أرقام متكررة', 'পুনরাবৃত্ত সংখ্যা', 'Angka berulang', '重复数字', '繰り返す数字'],
    'Ask': <String>['Preguntar', 'Demander', 'Fragen', 'Perguntar', 'Спросить', 'اسأل', 'জিজ্ঞাসা', 'Tanya', '提问', '質問'],
    'Ask about numbers': <String>['Pregunta sobre números', 'Questions sur les nombres', 'Fragen zu Zahlen', 'Pergunte sobre números', 'Вопросы о числах', 'اسأل عن الأرقام', 'সংখ্যা নিয়ে প্রশ্ন', 'Tanya soal angka', '询问数字', '数字について質問'],
    'Talk': <String>['Hablar', 'Parler', 'Sprechen', 'Falar', 'Говорить', 'تحدّث', 'বলুন', 'Bicara', '说话', '話す'],
    'Ask by voice': <String>['Pregunta con la voz', 'Demander à la voix', 'Per Sprache fragen', 'Pergunte por voz', 'Спросить голосом', 'اسأل بصوتك', 'কণ্ঠে জিজ্ঞাসা করুন', 'Tanya dengan suara', '语音提问', '音声で質問'],
    'Numerology, the Cheiro way': <String>['Numerología al estilo Cheiro', 'La numérologie selon Cheiro', 'Numerologie nach Cheiro', 'Numerologia ao estilo Cheiro', 'Нумерология по Чейро', 'علم الأعداد على طريقة شيرو', 'চেইরোর পদ্ধতিতে সংখ্যাতত্ত্ব', 'Numerologi ala Cheiro', '凯罗风格的数字命理', 'キロ式数秘術'],
    'Search a feature': <String>['Buscar una función', 'Rechercher une fonction', 'Funktion suchen', 'Buscar um recurso', 'Найти функцию', 'ابحث عن ميزة', 'একটি সুবিধা খুঁজুন', 'Cari fitur', '搜索功能', '機能を検索'],
    'Settings': <String>['Ajustes', 'Paramètres', 'Einstellungen', 'Configurações', 'Настройки', 'الإعدادات', 'সেটিংস', 'Pengaturan', '设置', '設定'],
    'Invite a friend': <String>['Invita a un amigo', 'Inviter un ami', 'Freund einladen', 'Convide um amigo', 'Пригласить друга', 'ادعُ صديقًا', 'বন্ধুকে আমন্ত্রণ', 'Undang teman', '邀请朋友', '友達を招待'],
    'Share this app': <String>['Comparte esta app', 'Partager cette appli', 'App teilen', 'Compartilhe este app', 'Поделиться приложением', 'شارك التطبيق', 'অ্যাপ শেয়ার করুন', 'Bagikan aplikasi', '分享此应用', 'アプリを共有'],
    'Your PDF report': <String>['Tu informe PDF', 'Votre rapport PDF', 'Dein PDF-Bericht', 'Seu relatório PDF', 'Ваш PDF-отчёт', 'تقرير PDF الخاص بك', 'আপনার PDF রিপোর্ট', 'Laporan PDF Anda', '你的PDF报告', 'あなたのPDFレポート'],
    'Years, gemstone, rudraksha, career, health': <String>['Años, gema, rudraksha, carrera, salud', 'Années, pierre, rudraksha, carrière, santé', 'Jahre, Edelstein, Rudraksha, Beruf, Gesundheit', 'Anos, pedra, rudraksha, carreira, saúde', 'Годы, камень, рудракша, карьера, здоровье', 'سنوات وحجر ورودراكشا ومهنة وصحة', 'বছর, রত্ন, রুদ্রাক্ষ, ক্যারিয়ার, স্বাস্থ্য', 'Tahun, permata, rudraksha, karier, kesehatan', '年份、宝石、金刚菩提、事业、健康', '年運、宝石、ルドラクシャ、仕事、健康'],
    'Create': <String>['Crear', 'Créer', 'Erstellen', 'Criar', 'Создать', 'إنشاء', 'তৈরি করুন', 'Buat', '创建', '作成'],
    'Invite a friend and share your code.': <String>['Invita a un amigo y comparte tu código.', 'Invitez un ami et partagez votre code.', 'Lade einen Freund ein und teile deinen Code.', 'Convide um amigo e compartilhe seu código.', 'Пригласите друга и поделитесь кодом.', 'ادعُ صديقًا وشارك رمزك.', 'বন্ধুকে আমন্ত্রণ জানান ও আপনার কোড শেয়ার করুন।', 'Undang teman dan bagikan kode Anda.', '邀请朋友并分享你的代码。', '友達を招待してコードを共有。'],
    'Invite': <String>['Invitar', 'Inviter', 'Einladen', 'Convidar', 'Пригласить', 'دعوة', 'আমন্ত্রণ', 'Undang', '邀请', '招待'],
    'Home': <String>['Inicio', 'Accueil', 'Start', 'Início', 'Главная', 'الرئيسية', 'হোম', 'Beranda', '首页', 'ホーム'],
    'Reports': <String>['Informes', 'Rapports', 'Berichte', 'Relatórios', 'Отчёты', 'التقارير', 'রিপোর্ট', 'Laporan', '报告', 'レポート'],
    'Learn': <String>['Aprender', 'Apprendre', 'Lernen', 'Aprender', 'Учиться', 'تعلّم', 'শিখুন', 'Belajar', '学习', '学ぶ'],
    'Vault': <String>['Bóveda', 'Coffre', 'Tresor', 'Cofre', 'Хранилище', 'الخزنة', 'ভল্ট', 'Brankas', '保险库', 'ボールト'],
    'Nothing found': <String>['No se encontró nada', 'Rien trouvé', 'Nichts gefunden', 'Nada encontrado', 'Ничего не найдено', 'لم يتم العثور على شيء', 'কিছু পাওয়া যায়নি', 'Tidak ditemukan', '未找到', '見つかりません'],
  };

  /// The text for [code], or null when there is none.
  static String? lookup(String code, String english) {
    final i = codes.indexOf(code);
    if (i < 0) return null;
    final row = table[english];
    if (row == null || i >= row.length) return null;
    final t = row[i];
    return t.isEmpty ? null : t;
  }
}
