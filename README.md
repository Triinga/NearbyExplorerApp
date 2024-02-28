# Rreth projektit
Ky projekt paraqet një aplikacion të thjeshtë, i cili është i dizajnuar për turista. Në aplikacion mundësohet kycja dhe regjistrimi i turistëve dhe kërkimi i restauranteve, kafeneve, hoteleve afër vendit që e vizitojnë.

# Teknologjitë e përdorura
* XCode - version 14
* Swift - version 14
* SQLite 3

# Përmbajtja e aplikacionit
Aplikacioni përmbanë oamjet(views) si në vijim:
* Register - pamja për regjistrim (RegisterViewController)
* Login - pamja për kycje (LoginViewController)
* Main Page - pamja kryesore që përmban hartën (MapViewController)

Databaza e brendshme menaxhohet nga klasa DBHelper. Kalimi nga njëra pamje(view) në tjetrën mundësohet përmes 'Navigation Controller'

Disa nga 'alert dialogs' që na shfaqen në aplikacionin tonë janë:
* kur kycemi me sukses
* kur kycemi me kredencialet e gabuara
* kur perdoruesi nuk është i regjistruar
* kur kërkojmë aprovimin nga përdoruesi për të mësuar lokacionin e tyre

# Përdorimi i aplikacionit
Në hapje të aplikacionit paraqitet pamja për të zgjedhur nëse dëshirojmë të kycemi ose të regjistrohemi. Nëse dëshirojmë të kalojmë në pamjen për regjistrim, atëherë shtypim butonin përkatës dhe na shfaqet pamja, në të cilën kërkohen të dhënat: 

* Emri
* Email
* Fjalekalimi
* Konfirmimi i fjalekalimit

Nëse të dhënat plotësohen dhe nuk ka ndonjë problem atëherë përdoruesi regjistrohet me sukses në databazë dhe mund të kycet në aplikacion. Pas kycjes shfaqet pamja e hartës në lokacionin tonë, dhe një fushë e kërkimit. Tek fusha e kërkimit kemi mundësi të kërkojmë mbi institucionet e cekura më lartë. Pasi që klikojmë tastin enter, na del një 'table view' me të gjitha rezultatet nga fusha e kërkimit. Më pas kur klikojmë tek institucioni që do shkojmë shfaqet butoni që na tregon rrugën deri tek vendi i caktuar. Butoni është i lidhur me  
https://www.apple.com/maps/  
dhe na tregon rrugën duke kaluar në atë app.
