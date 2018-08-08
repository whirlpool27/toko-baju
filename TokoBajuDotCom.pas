program TokoBajuDotCom;
uses sysutils;

{K A M U S } 
{Tipe Bentukan}
type
	StokBaju = record
		NamaBaju 			: string;
		KategoriBaju 		: string;
		GenderPemakai 		: string;
		WarnaBaju			: string;
		BeratPerBajuKg		: real;
		BahanBaju			: string;
		Harga				: longInt;
		KetersediaanUkuranS	: integer;
		KetersediaanUkuranM	: integer;
		KetersediaanUkuranL	: integer;
		KetersediaanUkuranXL: integer;
		JumlahPembelian		: integer;
		GrosirDiscount		: integer;
	end;
	ekspedisi = record
		NamaEkspedisi 	: string;
		JenisLayanan 	: string;
		NamaKota 		: string;
		BiayaKirimPerKg : integer;
		LamaPengiriman 	: integer;
	end;
	cart = record
		NamaBaju 		: string;
		WarnaBaju 		: string;
		BeratPerBajuKg	: real;
		BahanBaju 		: string;
		Harga 			: longInt;
		JumlahBeliS 	: integer;
		JumlahBeliM		: integer;
		JumlahBeliL		: integer;
		JumlahBeliXL	: integer;
	end;
	transaksi = record
		NamaBaju 		: string;
		WarnaBaju 		: string;
		BeratPerBajuKg 	: real;
		BahanBaju 		: string;
		Harga 			: longInt;
		JumlahBeliS 	: integer;
		JumlahBeliM 	: integer;
		JumlahBeliL 	: integer;
		JumlahBeliXL 	: integer;
		NamaEkspedisi 	: string;
		JenisLayanan 	: string;
		NamaKotaTujuan 	: string;
		BiayaKirimPerKg : integer;
		LamaPengiriman 	: integer;
		TanggalKirim 	: string;
	end;
	tanggal = record
		dd : integer;
		mm : integer;
		yy : integer;
	end;
	arrSB = array [1..100] of StokBaju;
	arrC = array [1..100] of cart;
	arrTr = array [1..100] of transaksi;
	arrEks = array [1..100] of ekspedisi;
{Deklarasi Tipe Variabel}
var
	fileStokBaju,
	fileCart, 
	fileTransaksi, 
	fileEkspedisi	: text;
	arrStokBaju	 	: arrSB;
	arrCart 		: arrC;
	arrTransaksi 	: arrTr;
	arrEkspedisi	: arrEks;
	NeffSB, NeffTr, 
	NeffC, NeffEks	: integer;
	tanggalSekarang	: string;
	pilihan			: string;

{S U B P R O G R A M   P E N D U K U N G }

function panjangString(stok : string; posisiCursor: integer) : integer;
{fungsi ini digunakan untuk menghitung panjang string yang ada di antara tanda '|'}

{kamus lokal}
var
	x : char;
	i : integer;

{algoritma prosedur}
begin
	panjangString := 0; //inisialisasi
	i := posisiCursor; //inisialisasi
	repeat  //ulangi perintah hingga bertemu tanda '|' atau baris baru
		x := stok[i];
		panjangString := panjangString + 1;
		i := i + 1;
	until (x = '|') or (x = #13);
end;


procedure loadStok(var sb : text; var arrSB : array of StokBaju; var NSB : integer);
{prosedur ini digunakan untuk membaca dan memasukkan file stok baju ke dalam array}

{kamus lokal}
var
	i : integer;
	posisi : integer;
	tempSb : string;
begin
	{inisialisasi}
	assign(sb, 'stokbaju.txt');
	reset(sb);
	posisi := 1;
	i := 1;
	
	{proses membaca file stok}
	while not eof(sb) do
	begin
		readln(sb, tempSb);
		arrSb[i].namaBaju := copy(tempSb, posisi, PanjangString(tempSb, posisi)-2);
		posisi := posisi + panjangstring(tempSb, posisi);
		arrSb[i].kategoriBaju := copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3);
		posisi := posisi + panjangstring(tempSb, posisi);
		arrSb[i].GenderPemakai := copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3);
		posisi := posisi + panjangstring(tempSb, posisi);
		arrSb[i].warnaBaju := copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3);
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].BeratPerBajuKg := strtofloat(copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3));
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].bahanBaju := copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3);
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].harga := strToInt(copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3));
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].ketersediaanUkuranS := strToInt(copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3));
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].ketersediaanUkuranM := strToInt(copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3));
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].ketersediaanUkuranL := strToInt(copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3));
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].ketersediaanUkuranXL := strToInt(copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3));
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].jumlahPembelian := strToInt(copy(tempSb, posisi + 1, PanjangString(tempSb, posisi)-3));
		posisi := posisi + panjangString(tempSb, posisi);
		arrSb[i].grosirDiscount := strToInt(copy (tempSb, posisi + 1, PanjangString(tempSb, posisi)-2));
		posisi := 1;
		i := i + 1;
	end;
	NSb := i-1; //banyaknya data yang ada di array stok baju
	close(sb);
end;

procedure loadCart(var c : text; var arrC : array of Cart; var NC : integer);
{prosedur ini digunakan untuk membaca dan memasukkan isi dari file shopping cart ke dalam sebuah array}

{kamus lokal}
var
	i : integer;
	posisi : integer;
	tempC : string;
	
{algoritma prosedur}
begin
	{inisialisasi}
	assign(c, 'cart.txt');
	reset(c);
	posisi := 1;
	i := 1;
	
	{membaca file cart}
	while not eof(c) do
	begin
		readln(c, tempC);
		arrC[i].namaBaju := copy(tempC, posisi, PanjangString(tempC, posisi)-2);
		posisi := posisi + panjangstring(tempC, posisi);
		arrC[i].warnaBaju := copy(tempC, posisi + 1, PanjangString(tempC, posisi)-3);
		posisi := posisi + panjangstring(tempC, posisi);
		arrC[i].beratPerBajuKg := strToFloat(copy(tempC, posisi + 1, PanjangString(tempC, posisi)-3));
		posisi := posisi + panjangstring(tempC, posisi);
		arrC[i].bahanBaju := copy(tempC, posisi + 1, PanjangString(tempC, posisi)-3);
		posisi := posisi + panjangstring(tempC, posisi);
		arrC[i].harga := strToInt(copy(tempC, posisi + 1, PanjangString(tempC, posisi)-3));
		posisi := posisi + panjangstring(tempC, posisi);
		arrC[i].jumlahBeliS := strToInt(copy(tempC, posisi + 1, PanjangString(tempC, posisi)-3));
		posisi := posisi + panjangstring(tempC, posisi);
		arrC[i].jumlahBeliM := strToInt(copy(tempC, posisi + 1, PanjangString(tempC, posisi)-3));
		posisi := posisi + panjangstring(tempC, posisi);
		arrC[i].jumlahBeliL := strToInt(copy(tempC, posisi + 1, PanjangString(tempC, posisi)-2));
		posisi := 1;
		i := i + 1;
	end;
	NC := i-1; //banyaknya nilai di array Cart
	close(c);
end;

procedure loadTransaksi(var tr : text; var arrTr : array of transaksi; var NTr : integer);
{prosedur ini digunakan untuk membaca dan memasukkan isi file transaksi ke dalam sebuah array}

{kamus lokal}
var
	i : integer;
	posisi : integer;
	tempTr : string;

{algoritma prosedur}
begin
	{inisialisasi}
	assign(tr, 'transaksi.txt');
	reset(tr);
	posisi := 1;
	i := 1;
	
	{membaca file transaksi}
	while not eof(tr) do
	begin
		readln(tr, tempTr);
		arrTr[i].namaBaju := copy(tempTr, posisi, PanjangString(tempTr, posisi)-2);
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].warnaBaju := copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3);
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].beratPerBajuKg := strToFloat(copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3));
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].bahanBaju := copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3);
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].harga := strToInt(copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3));
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].jumlahBeliS := strToInt(copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3));
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].jumlahBeliM := strToInt(copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3));
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].jumlahBeliL := strToInt(copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3));
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].jumlahBeliXL := strToInt(copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3));
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].namaEkspedisi := copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3);
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].jenisLayanan := copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3);
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].namaKotaTujuan := copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3);
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].biayaKirimPerKg := strToInt(copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3));
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].lamaPengiriman := strToInt(copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-3));
		posisi := posisi + panjangstring(tempTr, posisi);
		arrTr[i].tanggalKirim:= copy(tempTr, posisi + 1, PanjangString(tempTr, posisi)-2);
		posisi := 1;
		i := i + 1;
	end;
	NTr := i-1; //banyaknya nilai yang ada di array transaksi
	close(tr);
end;

procedure loadEkspedisi(var eks : text; var arrEks : array of ekspedisi; var NE : integer);
{prosedur ini digunakan untuk membaca dan memasukkan isi file ekspedisi ke dalam sebuah array}

{kamus lokal}
var
	i : integer;
	posisi : integer;
	tempEks : string;
	
{algoritma prosedur}
begin
	{inisialisasi}
	assign(eks, 'ekspedisi.txt');
	reset(eks);
	posisi := 1;
	i := 1;
	
	{membaca file ekspedisi}
	while not eof(eks) do
	begin
		readln(eks, tempEks);
		arrEks[i].namaEkspedisi := copy(tempEks, posisi, PanjangString(tempEks, posisi)-2);
		posisi := posisi + panjangstring(tempEks, posisi);
		arrEks[i].jenisLayanan := copy(tempEks, posisi + 1, PanjangString(tempEks, posisi)-3);
		posisi := posisi + panjangstring(tempEks, posisi);
		arrEks[i].namaKota := copy(tempEks, posisi + 1, PanjangString(tempEks, posisi)-3);
		posisi := posisi + panjangstring(tempEks, posisi);
		arrEks[i].biayaKirimPerKg := strToInt(copy(tempEks, posisi + 1, PanjangString(tempEks, posisi)-3));
		posisi := posisi + panjangstring(tempEks, posisi);
		arrEks[i].lamaPengiriman := strToInt(copy(tempEks, posisi + 1, PanjangString(tempEks, posisi)-2));
		posisi := 1;
		i := i + 1;
	end;
	NE := i-1; //banyaknya nilai yang ada di array ekspedisi
	close(eks);
end;

procedure penambahanTanggal(tanggalAwal : tanggal; var tanggalAkhir : tanggal; lamaPengiriman : integer);
{prosedur ini digunakan untuk menambahkan tanggal dengan suatu integer, dalam program ini lama pengiriman}

{kamus lokal}
var
	isDateValid		: boolean;

{algoritma prosedur}
begin	
	(*penambahan tanggal*)
	tanggalAkhir.dd := tanggalAwal.dd + lamaPengiriman;
	tanggalAkhir.mm := tanggalAwal.mm;
	tanggalAkhir.yy := tanggalAwal.yy;
	
	(*pengecekan keabsahan tanggal*)
	repeat
		case tanggalAkhir.mm of
		1,3,5,7,8,10	:	begin
								if (tanggalAkhir.dd > 31) then
								begin
									tanggalAkhir.dd := tanggalAkhir.dd-31;
									tanggalAkhir.mm := tanggalAkhir.mm+1;
								end else
								begin
									isDateValid := TRUE;
								end;
							end;
		4,6,9,11		:	begin
								if (tanggalAkhir.dd > 30) then
								begin
									tanggalAkhir.dd := tanggalAkhir.dd-30;
									tanggalAkhir.mm := tanggalAkhir.mm+1;
								end else
								begin
									isDateValid := TRUE;
								end;
							end;
		2				:	begin
								if (tanggalAkhir.yy mod 400 = 0) or ((tanggalAkhir.yy mod 100 <> 0) and (tanggalAkhir.yy mod 4 = 0)) then
								begin
									if (tanggalAkhir.dd > 29) then
									begin
										tanggalAkhir.dd := tanggalAkhir.dd-29;
										tanggalAkhir.mm := tanggalAkhir.mm+1;
									end else
									begin
										isDateValid := TRUE;
									end;
								end else //tahun non kabisat
								begin
									if (tanggalAkhir.dd > 28) then
									begin
										tanggalAkhir.dd := tanggalAkhir.dd-28;
										tanggalAkhir.mm := tanggalAkhir.mm+1;
									end else
									begin
										isDateValid := TRUE
									end;
								end;
							end;
		12				:	begin
								if (tanggalAkhir.dd > 31) then
								begin
									tanggalAkhir.dd := tanggalAkhir.dd-31;
									tanggalAkhir.mm := 1;
									tanggalAkhir.yy := tanggalAkhir.yy + 1;
								end else
								begin
									isDateValid := TRUE;
								end;
							end;
		end;
	until (isDateValid);
end;

function daysBetween(tanggalA : string; tanggalB : string) : integer;
{fungsi ini digunakan untuk menghitung banyaknya hari di antara dua tanggal, A dan B}

{kamus lokal}
var
	tempA, tempB : tanggal;

{algoritma fungsi}
begin
	{pengubahan tanggal dengan tipe string ke tipe bentukan tanggal}
	tempA.dd := strToInt(copy(tanggalA, 1, 2));
	tempA.mm := strToInt(copy(tanggalA, 4, 2));
	tempA.yy := strToInt(copy(tanggalA, 7, 2));
	tempB.dd := strToInt(copy(tanggalB, 1, 2));
	tempB.mm := strToInt(copy(tanggalB, 4, 2));
	tempB.yy := strToInt(copy(tanggalB, 7, 2));
	
	{proses menghitung}
	if (tempB.yy = tempA.yy) then
	begin
		if (tempB.mm = tempA.mm) then
		begin
			daysBetween := tempB.dd - tempA.dd;
		end else //tempB.mm <> tempA.mm
			begin
				case tempA.mm of
					1, 3, 5, 7, 8, 10, 12	: daysBetween := 31 - tempA.dd + tempB.dd;
					4, 6, 9, 11				: daysBetween := 30 - tempA.dd + tempB.dd;
					2						: 
												begin
													if (tempA.mm = 2) and ((tempA.yy mod 400 = 0) or ((tempA.yy mod 4 = 0) and (tempA.yy mod 100 <> 0))) then
													begin //bulan 2, kabisat
														daysBetween := 29 - tempA.dd + tempB.dd;
													end else //tempA = 2, bukan kabisat
														begin
															daysBetween := 28 - tempA.dd + tempB.dd;
														end;
												end;
				end;
			end
	end else //tempB.yy <> tempA.yy
		begin
			daysBetween := 99; //999 digunakan karena hari diantara A dan B sudah pasti melebihi 14 hari
		end
end;

{S U B P R O G R A M   U T A M A } 
procedure load;
{prosedur yang memasukkan semua file txt yang diperlukan ke dalam array}

{algoritma prosedur}
begin
	loadStok(fileStokBaju, arrStokBaju, NeffSb);
	loadCart(fileCart, arrCart, NeffC);
	loadTransaksi(fileTransaksi, arrTransaksi, NeffTr);
	loadEkspedisi(fileEkspedisi, arrEkspedisi, NeffEks);
end;

procedure showPopulars(arrSb : array of stokBaju; NSB : integer);
{menampilkan 3 baju paling popular, yaitu baju yang memiliki jumlah pembelian terbanyak}

{kamus lokal}
var
	tempSb : array [1..100] of stokBaju;
	temp : stokBaju;
	i, j : integer;

{algoritma prosedur}
begin
	{menyimpan array stok baju ke temporary array}
	for i := 1 to NSB do
	begin
		tempSb[i] := arrSb[i];
	end;
	
	{proses sorting sesuai jumlah pembelian}
	for j := 1 to NSb-1 do
	begin
		for i := 1 to NSB-1 do
		begin
			if tempSb[i+1].jumlahPembelian > tempSb[i].jumlahPembelian then
			begin
				temp := tempSb[i];
				tempSb[i] := tempSb[i+1];
				tempSb[i+1] := temp;
			end
		end;
	end;
	
	{menampilkan 3 yang sudah disortir}
	for i := 1 to 3 do
	begin
	writeln(i, '.', tempSb[i].namaBaju);
	writeln('Warna : ', tempSb[i].warnaBaju);
	writeln('S: ', tempSb[i].KetersediaanUkuranS,
	' M: ', tempSb[i].KetersediaanUkuranM,
	' L: ', tempSb[i].ketersediaanUkuranL,
	' XL : ', tempSb[i].ketersediaanUkuranXL);
	writeln('Rp ', tempSb[i].harga);
	writeln('Banyak dibeli: ', tempSb[i].jumlahPembelian, ' kali');
	writeln;
	end;
end;

procedure showDetailProduct(arrSB : array of stokBaju; NSB : integer);
{prosedur untuk menampilkan suatu produk secara detil untuk baju yang dipilih user}

{kamus lokal}
var
	i : integer;
	nama : string;
	found : boolean;

{algoritma prosedur}
begin
	{membaca input dari user}
	found:=false;
	repeat
		write('Nama baju : ');
		readln(nama);
		for i:=1 to NSB do
		begin
			if nama=arrSB[i].namabaju then
			begin
				found:=true;
			end;
		end;
		if not(found) then
		begin
			writeln('Maaf baju yang anda pilih tidak tersedia atau nama baju yang anda masukkan salah');
		end;
	until(found=true);
	
	{proses menampilkan baju}
	for i := 1 to NSB do
	begin
		if arrSb[i].namaBaju = nama then
		begin
			writeln(arrSb[i].namaBaju);
			writeln('Kategori: ', arrSb[i].kategoriBaju);
			writeln('Gender: ', arrSb[i].genderPemakai);
			writeln('Warna: ', arrSb[i].warnaBaju);
			writeln('Berat per kg : ', arrSb[i].beratPerBajuKg:4:1);
			writeln('Bahan: ', arrSb[i].bahanBaju);
			writeln('S: ', arrSb[i].KetersediaanUkuranS,
			' M: ', arrSb[i].KetersediaanUkuranM,
			' L: ', arrSb[i].ketersediaanUkuranL,
			' XL : ', arrSb[i].ketersediaanUkuranXL);
			writeln('Rp ', arrSb[i].harga);
			writeln('Banyak dibeli: ', arrSb[i].jumlahPembelian);
			writeln('Diskon grosir: ', arrSb[i].grosirDiscount);
		end;
	end;
	writeln;
end;

procedure searchClothesByKeyword(arrSb : array of stokBaju; NSb : integer);
{mencari baju berdasarkan keyword, keyword adalah nama baju, kategori baju, atau warna baju}

{kamus lokal}
var
	keyword : string;
	i,x : integer;
	baju : stokBaju;

{algoritma prosedur}	
begin
	{membaca input dari user}
	write('>Masukkan keyword : '); readln(keyword);
	
	{pencarian sesuai keyword}
	x:=0; //inisialisasi
	for i:=1 to NSb do
	begin
		Baju := arrSb[i];
		if (Baju.NamaBaju=keyword) or (Baju.KategoriBaju=keyword) or (Baju.WarnaBaju=keyword) then
		begin
			x:=x+1; //untuk bullet
			writeln(x,'. ',Baju.NamaBaju);
			writeln('Gender : ',Baju.GenderPemakai);
			writeln('Kategori : ',Baju.KategoriBaju);
			writeln('Warna : ',Baju.WarnaBaju);
			writeln('Harga : Rp ',Baju.Harga);
			writeln;
		end;
	end;
end;


procedure sortPrice(var arrSb : array of stokBaju; NSB : integer);
{mensortir baju berdasarkan harga dari termahal sampai termurah}

{kamus lokal}
var
	i, j : integer;
	temp : stokBaju;
	
{algoritma prosedur}
begin
	{sorting harga}
	for j := 1 to NSb-1 do
	begin
		for i := 1 to NSB-1 do
		begin
			if arrSb[i+1].harga > arrSb[i].harga then
			begin
				temp := arrSb[i]; //switch position
				arrSb[i] := arrSb[i+1];
				arrSb[i+1] := temp;
			end
		end;
	end;

	{menampilkan array yang telah di-sort ke layar}
	for i := 1 to NSB do
	begin
	writeln(i, '.', arrSb[i].namaBaju);
	writeln('Warna : ', arrSb[i].warnaBaju);
	writeln('S: ', arrSb[i].KetersediaanUkuranS,
	' M: ', arrSb[i].KetersediaanUkuranM,
	' L: ', arrSb[i].ketersediaanUkuranL,
	' XL : ', arrSb[i].ketersediaanUkuranXL);
	writeln('Rp ', arrSb[i].harga);
	writeln('Banyak dibeli: ', arrSb[i].jumlahPembelian, ' kali');
	writeln;
	end;
end;

procedure filterClothes(arrSb : array of stokBaju; NSB : integer);
{memfilter baju dengan kriteria tertentu yang dimasukkan user}

{kamus lokal}
var
	gender, kategori, ukuran, warna : string;
	i, count : integer;
	
{algoritma prosedur}
begin
	
	{pembacaan input user}
	writeln('Filter Clothes');
	write('gender : '); readln(gender);
	write('kategori : '); readln(kategori);
	write('ukuran : '); readln(ukuran);
	write('warna : '); readln(warna);
	writeln;
	
	{proses mencari baju sesuai kriteria}
	count := 0; {inisialisasi}
	for i := 1 to NSB do
	begin
		if (((gender = arrSb[i].genderPemakai) or (gender = 'semua')) and ((kategori = arrSb[i].kategoriBaju) or (kategori = 'semua')) and
		((warna = arrSb[i].warnaBaju) or (warna = 'semua'))) then
		begin
			if ((ukuran = 's') or (ukuran = 'S') or (ukuran = 'semua')) and not(arrSb[i].ketersediaanUkuranS = 0) or
			((ukuran = 'm') or (ukuran = 'M') or (ukuran = 'semua')) and not(arrSb[i].ketersediaanUkuranM = 0) or
			((ukuran = 'l') or (ukuran = 'L') or (ukuran = 'semua')) and not(arrSb[i].ketersediaanUkuranL = 0) or
			((ukuran = 'xl') or (ukuran = 'XL') or (ukuran = 'semua')) and not(arrSb[i].ketersediaanUkuranXL = 0)
			then
			begin
				count := count + 1;
				writeln(i, '.', arrSb[i].namaBaju);
				writeln('Warna : ', arrSb[i].warnaBaju);
				writeln('S: ', arrSb[i].KetersediaanUkuranS,
				' M: ', arrSb[i].KetersediaanUkuranM,
				' L: ', arrSb[i].ketersediaanUkuranL,
				' XL : ', arrSb[i].ketersediaanUkuranXL);
				writeln('Rp ', arrSb[i].harga);
				writeln;
			end
		end
	end;
	if count = 0 then
	begin { count = 0 jika kriteria tidak ada yang dipenuhi}
		writeln('Barang yang Anda cari tidak ditemukan');
	end
end;

procedure filterByPrice(arrSB : array of StokBaju; NSB : integer);
{mencari baju dengan harga termurah atau termahal}

{kamus lokal}
var
	i : integer;
	termurah, termahal : StokBaju;
	pilihan : integer;
	
{algoritma prosedur}
begin
	{inisialisasi}
	termurah := arrSB[1];
	termahal := arrSB[1];
	
	{mencari harga termurah & termahal pada array stok baju}
	for i := 1 to NSB do
	begin
		if arrSB[i].harga < termurah.harga then
		begin
			termurah := arrSB[i];
		end else if arrSB[i].harga > termahal.harga then
			begin
				termahal := arrSB[i];
			end
	end;
	
	{tampilan filterByPrice}
	writeln('Filter By Price : ');
	writeln('1. Harga Termurah ');
	writeln('2. Harga Termahal ');
	writeln;
	write('Pilihan : '); readln(pilihan);
	
	{menampilkan harga termurah jika pilihan = 1
	* menampilkan harga termahal jika pilihan = 2}
	if pilihan = 1 then
	begin
		writeln(termurah.namaBaju);
		writeln('Warna : ', termurah.warnaBaju);
		writeln('S: ', termurah.KetersediaanUkuranS,
		' M: ', termurah.KetersediaanUkuranM,
		' L: ', termurah.ketersediaanUkuranL,
		' XL : ', termurah.ketersediaanUkuranXL);
		writeln('Rp ', termurah.harga);
		writeln;
	end else
	begin
		writeln(termahal.namaBaju);
		writeln('Warna : ', termahal.warnaBaju);
		writeln('S: ', termahal.KetersediaanUkuranS,
		' M: ', termahal.KetersediaanUkuranM,
		' L: ', termahal.ketersediaanUkuranL,
		' XL : ', termahal.ketersediaanUkuranXL);
		writeln('Rp ', termahal.harga);
		writeln;
	end
end;

procedure showExpedition(arrEks : array of ekspedisi; NE : integer);
{menampilkan seluruh ekspedisi dengan nama kota diinput oleh user}

{kamus lokal}
var
	nama : string;
	count, i : integer;
	
{algoritma prosedur}
begin
	{membaca input dari user}
	write('Nama Kota : ');
	readln(nama);
	
	{mencari ekspedisi sesuai nama kota}
	count := 0; //inisialisasi
	for i := 1 to NE do
	begin
		if nama = arrEks[i].namaKota then
		begin
			writeln('Nama ekspedisi: ', arrEks[i].namaEkspedisi);
			writeln('Jenis layanan : ', arrEks[i].jenisLayanan);
			writeln('Kota: ', arrEks[i].namaKota);
			writeln('Biaya kirim: ', arrEks[i].biayaKirimPerKg, ' per kg');
			writeln;
			count := count + 1;
		end
	end;
	{kasus untuk nama kota tidak ada dalam ekspedisi}
	if count = 0 then
	begin
		writeln('Ekspedisi yang dicari tidak ditemukan');
	end
end;

procedure addToCart(var arrC : array of cart; var NC : integer; arrSb : array of stokBaju;
NSb : integer);
{prosedur untuk menambahkan barang ke cart, user memasukkan nama baju dan jumlah beli tiap ukuran}

{kamus lokal}
var
	namaBaju : string;
	jumlahBeliS, jumlahBeliM, jumlahBeliL, jumlahBeliXL : integer;
	i, j : integer;
	found : boolean;
	
{algoritma prosedur}
begin
	{membaca input dari user}
	found:=false;
	repeat
		write('Nama baju : ');
		readln(namaBaju);
		for i:=1 to NSB do
		begin
			if namabaju=arrSB[i].namabaju then
			begin
				found:=true;
			end;
		end;
		if not(found) then
		begin
			writeln('Maaf baju yang anda pilih tidak tersedia atau nama baju yang anda masukkan salah');
		end;
	until(found=true);
	write('Jumlah beli ukuran S : ');
	readln(jumlahBeliS);
	write('Jumlah beli ukuran M : ');
	readln(jumlahBeliM);
	write('Jumlah beli ukuran L : ');
	readln(jumlahBeliL);
	write('Jumlah beli ukuran XL : ');
	readln(jumlahBeliXL);
	writeln;
	
	{memasukkan baju ke array cart sesuai dengan nama baju yang ditulis user}
	j := 1;
	for i := 1 to NSb do
	begin
		if (namaBaju = arrSb[i].namaBaju) then
		begin
			if ((jumlahBeliS > arrSb[i].ketersediaanUkuranS) or (jumlahBeliM >arrSb[i].ketersediaanUkuranM) 
			or (jumlahBeliL > arrSb[i].ketersediaanUkuranL) or (jumlahBeliXL > arrSb[i].ketersediaanUkuranXL)) and not ((jumlahBeliS = 0) and (jumlahBeliM = 0) and
		(jumlahBeliL = 0) and (jumlahBeliXL = 0)) then
			begin
				writeln('Maaf, barang yang Anda pesan tidak mencukupi');
			end else
				begin
					arrC[j].namaBaju := arrSb[i].namaBaju;
					arrC[j].warnaBaju := arrSb[i].warnaBaju;
					arrC[j].BeratPerBajuKg := arrSb[i].BeratPerBajuKg;
					arrC[j].BahanBaju := arrSb[i].bahanBaju;
					arrC[j].harga := arrSb[i].harga;
					arrC[j].jumlahBeliS := jumlahBeliS;
					arrC[j].jumlahBeliM := jumlahBeliM;
					arrC[j].jumlahBeliL := jumlahBeliL;
					arrC[j].jumlahBeliXL := jumlahBeliXL;
					j := j + 1;
				end;
		end
	end;
	NC := j-1; //penambahan banyaknya nilai dalam Cart
end;

procedure removeFromCart(var arrC : array of cart; var NC : integer);
{menghapus isi cart, user memasukkan nama baju yang akan dihapus}

{kamus lokal}
var
	nama : string;
	i : integer;
	temp : cart;
	
{algoritma prosedur}
begin
	{membaca input dari user}
	write('Nama baju : ');
	readln(nama);
	
	{mencari data di cart yang sesuai dengan nama yang diinput user}
	for i:=1 to NC do
	begin
		if nama=arrC[i].NamaBaju then
		begin
			temp := arrC[i];
			arrC[i]:=arrC[NC];
			arrC[NC]:=temp;
			NC:= NC-1;
		end;
	end;
end;

function discountGrosir (diskon : integer; jumlahBeli : integer) : real;
{fungsi ini digunakan untuk menghitung diskon (dalam persen) yang diberikan, maksimum 50 persen}
{fungsi ini digunakan di calculatePrice}

{algoritma fungsi}
begin
	if (jumlahBeli div 10)*diskon <= 50 then //kasus diskon kurang dari 50 persen
	begin
		discountGrosir := (jumlahBeli div 10) * diskon/100;
	end	else	//(jumlahBeli mod 10) * diskon > 50, diskon maksimum
		begin
			discountGrosir := 50/100;
		end
end;

function calculatePrice(arrC : array of cart; NC : integer; arrEx : array of ekspedisi;
NE : integer; namaEkspedisi : string; jenisLayanan : string; arrSb : array of stokbaju;
NSb : integer) : real;
{fungsi untuk menghitung total uang yang harus dibayar oleh user ditambah ongkos kirim}

{kamus lokal}
var
	i, j : integer;
	tempEkspedisi : ekspedisi;
	jumlahBeli : integer;
	diskon : integer;
	HargaTotal :real;
	
begin
	{memasukkan array ekspedisi di sebuah temporary array}
	for i := 1 to NE do
	begin
		if (arrEx[i].namaEkspedisi = namaEkspedisi) and (arrEx[i].jenisLayanan = jenisLayanan) then
		begin
			tempEkspedisi := arrEx[i];
		end
	end;
	
	{menghitung uang yang harus dibayar pembeli ditambah dengan ongkos kirim}
	HargaTotal:=0;
	for i:=1 to NC do
	begin
		for j:=1 to NSB do
		begin
			if arrC[i].NamaBaju=arrSB[j].NamaBaju then
			begin
				diskon:=arrSB[j].GrosirDiscount;
				JumlahBeli:=arrC[i].jumlahBeliS+arrC[i].jumlahBeliM+arrC[i].jumlahBeliL+arrC[i].jumlahBeliXL;
				HargaTotal:=HargaTotal+arrC[i].harga*JumlahBeli*(1-discountGrosir(diskon,JumlahBeli))+tempEkspedisi.BiayaKirimPerKg*arrC[i].beratPerBajuKg*JumlahBeli;
			end;
		end;
	end;
	calculatePrice:=HargaTotal;
end;

Procedure updateClothes (var arrSB : array of StokBaju; NSB : integer; arrC : array of cart; NC : integer);
{prosedur ini digunakan untuk memperbarui isi stok baju (dalam array)}

{Kamus Lokal}
var
JumlahBeli :integer;
i, j : integer;

{Algoritma Prosedur}
begin
	for j:=1 to NC do
	begin
		for i:=1 to NSB do
		begin
			if arrC[j].namaBaju = arrSB[i].namaBaju then
			begin
				{Update jumlah baju dari setelah checkout}
				arrSB[i].KetersediaanUkuranS:= arrSB[i].KetersediaanUkuranS-arrC[j].JumlahBeliS;
				arrSB[i].KetersediaanUkuranM:= arrSB[i].KetersediaanUkuranM-arrC[j].JumlahBeliM;
				arrSB[i].KetersediaanUkuranL:= arrSB[i].KetersediaanUkuranL-arrC[j].JumlahBeliL;
				arrSB[i].KetersediaanUkuranXL:= arrSB[i].KetersediaanUkuranXL-arrC[j].JumlahBeliXL;
				JumlahBeli:= arrC[j].JumlahBeliS+arrC[j].JumlahBeliM+arrC[j].JumlahBeliL+arrC[j].JumlahBeliXL;
				arrSB[i].JumlahPembelian:=arrSB[i].JumlahPembelian+JumlahBeli;
			end;
		end;
	end;
end;

procedure checkout(var arrC : array of cart; var NC : integer);
{fungsi untuk membeli semua barang yang ada di shopping cart}

{kamus lokal}
var
	ekspedisi, layanan, tempTanggal, tujuan : string;
	tanggalKirim, tanggalSampai : tanggal;
	i : integer;
	jumlahBeli, lamaPengiriman : integer;
	berat : real;
	biaya : longint;
	temp : integer;

{algoritma prosedur}
begin
	if NC=0 then
	begin
		writeln('Anda belum memasukkan barang ke Cart');
		writeln
	end else
		begin
			{membaca input dari user}
			write('Nama Ekspedisi : ');
			readln(ekspedisi);
			write('Jenis layanan : ');
			readln(layanan);
			write('Tanggal kirim (dd/mm/yy) : ');
			readln(tempTanggal);
			write('Kota tujuan : ');
			readln(tujuan);
			tanggalKirim.dd := strToInt(copy(tempTanggal, 1, 2));
			tanggalKirim.mm := strToInt(copy(tempTanggal, 4, 2));
			tanggalKirim.yy := strToInt(copy(tempTanggal, 7, 2));
			
			{menampilkan barang yang dibeli, lengkap dengan harga}
			berat := 0;
			for i := 1 to NC do
			begin
				writeln(i,'.',arrC[i].namaBaju);
				writeln('Warna : ', arrC[i].warnaBaju);
				if arrC[i].jumlahBeliS <> 0 then
				begin
					write('S: ', arrC[i].jumlahBeliS,' ');
				end;
				if arrC[i].jumlahBeliM <> 0 then
				begin
					write('M: ', arrC[i].jumlahBeliM,' ');
				end;
				if arrC[i].jumlahBeliL <> 0 then
				begin
					write('L: ', arrC[i].jumlahBeliL,' ');
				end;
				if arrC[i].jumlahBeliXL <> 0 then
				begin
					write('XL: ', arrC[i].jumlahBeliXL);
				end;
				writeln;
				jumlahBeli := arrC[i].jumlahBeliS + arrC[i].jumlahBeliM + arrC[i].jumlahBeliL + arrC[i].jumlahBeliXL;
				writeln('Berat : ', arrC[i].beratPerBajuKg*jumlahBeli:0:2);
				writeln('Rp ', arrC[i].harga, ' x ', jumlahBeli, ' = Rp ', arrC[i].harga*jumlahBeli);
				berat := berat + arrC[i].beratPerBajuKg*jumlahBeli;
				writeln;
			end;
			//menampilkan total harga
			writeln('Total : ', calculatePrice(arrC, NC, arrEkspedisi, NeffEks, ekspedisi, layanan, arrStokBaju, NeffSb):0:2);
			writeln('Berat : ', berat:0:2);
			
			{proses mencari lama pengiriman}
			for i := 1 to NeffEks do
			begin
				if (arrEkspedisi[i].namaEkspedisi = ekspedisi) and (arrEkspedisi[i].jenisLayanan = layanan) and
				(arrEkspedisi[i].namaKota = tujuan) then
				begin
					lamaPengiriman := arrEkspedisi[i].lamaPengiriman;
					biaya := arrEkspedisi[i].biayaKirimPerKg
				end
			end;
			
			{menambah tanggal untuk mencari tanggal sampai}
			penambahanTanggal(tanggalKirim, tanggalSampai, lamaPengiriman);
			writeln('Barang Anda akan diterima pada: ', tanggalSampai.dd, '/', tanggalSampai.mm, '/', tanggalSampai.yy);
			
			{update baju}
			updateClothes(arrStokBaju, NeffSb, arrCart, NeffC);
			
			{memasukkan file ke transaksi}
			for i := 1 to NC do
			begin
				temp := NeffTr + i + 1;
				arrTransaksi[temp].namaBaju := arrC[i].namaBaju;
				arrTransaksi[temp].warnaBaju := arrC[i].warnaBaju;
				arrTransaksi[temp].beratPerBajuKg := arrC[i].beratPerBajUKg;
				arrTransaksi[temp].bahanBaju := arrC[i].bahanBaju;
				arrTransaksi[temp].harga := arrC[i].harga;
				arrTransaksi[temp].jumlahBeliS := arrC[i].jumlahBeliS;
				arrTransaksi[temp].jumlahBeliM := arrC[i].jumlahBeliM;
				arrTransaksi[temp].jumlahBeliL := arrC[i].jumlahBeliL;
				arrTransaksi[temp].jumlahBeliXL := arrC[i].jumlahBeliXL;
				arrTransaksi[temp].namaEkspedisi := ekspedisi;
				arrTransaksi[temp].jenisLayanan := layanan;
				arrTransaksi[temp].namaKotaTujuan := tujuan;
				arrTransaksi[temp].biayaKirimPerKg := biaya;
				arrTransaksi[temp].lamaPengiriman := lamaPengiriman;
				arrTransaksi[temp].tanggalKirim := tempTanggal;
			end;
			NeffTr := temp - 1;
			
			{pengosongan cart}
			NC := 0;
		end;
end;

procedure showTransaction(arrTr : array of transaksi; NTr : integer);
{prosedur untuk menampilkan semua data sejarah transaksi sesuai tanggal transaksi}

{kamus lokal}
var
	i : integer;
	
{algoritma prosedur}
begin
	for i := 1 to NTr do
	begin
		writeln(i, '.', arrTr[i].namaBaju);
		writeln('Warna : ', arrTr[i].warnaBaju);
		writeln('Berat per baju : ', arrTr[i].beratPerBajuKg:4:1);
		writeln('Bahan : ', arrTr[i].bahanBaju);
		writeln('Jumlah Beli : ');
		writeln('S : ', arrTr[i].jumlahBeliS, ' M: ',
		arrTr[i].jumlahBeliM, ' L: ', arrTr[i].jumlahBeliL, ' XL: ',
		arrTr[i].jumlahBeliXL);
		writeln('Rp ', arrTr[i].harga);
		writeln('Ekspedisi : ', arrTr[i].namaEkspedisi, ' Layanan : ',
		arrTr[i].JenisLayanan);
		writeln('Kota Tujuan : ', arrTr[i].namaKotaTujuan);
		writeln('Biaya kirim per kg : ', arrTr[i].biayaKirimPerKg, ' Lama Pengiriman : ', arrTr[i].lamaPengiriman);
		writeln('Tanggal Kirim : ', arrTr[i].tanggalKirim)
	end;
end;

procedure retur(arrTr : array of transaksi; NTr : integer; arrSb : array of StokBaju;
				NSb : integer; tanggalA : string);
{prosedur untuk menghitng uang yang harus dikembalikan untuk barang yang dikembalikan karena cacat, dsb}

{kamus lokal}
var
	nama : string;
	i, j : integer;
	diskon, jumlahBeli : integer;
	total : real;
	
{algoritma prosedur}
begin
	{membaca input dari user}
	write('Nama baju : ');
	readln(nama);
	
	{mencari baju di transaksi yang memenuhi kriteria}
	for i := 1 to NTr do
	begin
		if arrTr[i].namaBaju = nama then
		begin
			if daysBetween(tanggalA, arrTr[i].tanggalKirim) <= 14 then
			begin
				jumlahBeli := arrTr[i].jumlahBeliS + arrTr[i].jumlahBeliM +
				arrTr[i].jumlahBeliL + arrTr[i].jumlahBeliXL;
				for j := 1 to NSb do
				begin
					if nama = arrSb[i].namabaju then
					begin
						diskon := arrSb[i].grosirdiscount;
					end
				end;
				write('Biaya pembelian akan kami kembalikan sebesar Rp. ');
				total := arrTr[i].harga*(jumlahBeli)*(1 + (jumlahBeli mod 10)*diskon/100) +
							(arrTr[i].beratPerBajuKg)*jumlahBeli*(arrTr[i].biayaKirimPerKg);
				writeln(total:0:2);
			end else
			begin  //kasus untuk jumlah beli lebih dari yang ditawarkan
				writeln('Permintaan tidak bisa diproses, pengembalian harus dilakukan dalam 14 hari setelah pembelian.');
			end
		end
	end;
end;

procedure exit(var sb : text; var tr : text; var c : text;
arrSB : array of StokBaju; arrTr : array of transaksi; arrC : array of cart;
NSB : integer; NTr : integer; NC : integer);
{prosedur yang mengakhiri aplikasi online shop yang sedang berjalan dan menyimpan perubahan ke file eksternal}

{kamus lokal}
var
	i : integer;
	tempSb, tempC, tempTr : string;
	
{algoritma prosedur}
begin
	{proses penyimpanan stok baju}
	assign(sb, 'stokbaju.txt');
	rewrite(sb);
	for i := 1 to NSB do
	begin
		tempSb := concat(arrSb[i].namaBaju, ' | ', arrSb[i].kategoriBaju, ' | ', arrSb[i].genderPemakai,
		' | ', arrSb[i].warnaBaju, ' | ', floatToStr(arrSb[i].beratPerBajuKg), ' | ', arrSb[i].bahanBaju, ' | ',
		intToStr(arrSb[i].harga), ' | ', intToStr(arrSb[i].ketersediaanUkuranS), ' | ', intToStr(arrSb[i].ketersediaanUkuranM), ' | ',
		intToStr(arrSb[i].ketersediaanUkuranL), ' | ', intToStr(arrSb[i].ketersediaanUkuranXL), ' | ', intToStr(arrSb[i].jumlahPembelian),
		' | ', intToStr(arrSb[i].grosirDiscount));
		write(sb, tempSb);
		write(sb, #13);
	end;
	close(sb);
	
	{proses penyimpanan transaksi}
	assign(tr, 'transaksi.txt');
	rewrite(tr);
	if NTr <> 0 then 
	begin
		for i := 1 to NTr do
		begin
			tempTr := concat(arrTr[i].namaBaju, ' | ', arrTr[i].warnaBaju, ' | ', floatToStr(arrTr[i].beratPerBajuKg),
			' | ', arrTr[i].bahanBaju, ' | ', intToStr(arrTr[i].harga), ' | ', intToStr(arrTr[i].JumlahBeliS), ' | ', intToStr(arrTr[i].jumlahBeliM),
			' | ', intToStr(arrTr[i].jumlahBeliL), ' | ', intToStr(arrTr[i].jumlahBeliXL), ' | ', arrTr[i].namaEkspedisi, ' | ',
			arrTr[i].jenisLayanan, ' | ', arrTr[i].namaKotaTujuan, ' | ', intToStr(arrTr[i].biayaKirimPerKg), ' | ',
			intToStr(arrTr[i].lamaPengiriman), ' | ', arrTr[i].tanggalKirim);
			write(tr, temptr);
			write(tr, #13);
		end;
	end;
	close(tr);
	
	{proses penyimpanan cart}
	assign(c, 'cart.txt');
	rewrite(c);
	if NC <> 0 then
	begin
		for i := 1 to NC do
		begin
			tempC := concat(arrC[i].namaBaju, ' | ', arrC[i].warnaBaju, ' | ', floatToStr(arrC[i].beratPerBajuKg), ' | ', arrC[i].bahanBaju, ' | ', intToStr(arrC[i].harga), ' | ',
			intToStr(arrC[i].jumlahBeliS), ' | ', intToStr(arrC[i].jumlahBeliM), ' | ', intToStr(arrC[i].jumlahBeliL), ' | ',
			intToStr(arrC[i].jumlahBeliXL));
			write(c, tempC);
			write(c, #13);
		end;
	end;
	close(c);
	halt;
end;

procedure eksekusiPilihan(choice : string);
{prosedur untuk mengeksekusi prosedur lain yang dipilih user}
begin
	case choice of
		'showPopulars'			: showPopulars(arrStokBaju, NeffSB);
		'showDetailProduct' 	: showDetailProduct(arrStokBaju, NeffSb);
		'searchClothesByKeyword': searchClothesByKeyword(arrStokBaju, NeffSb);
		'sortPrice' 			: sortPrice(arrStokBaju, NeffSb);
		'filterClothes' 		: filterClothes(arrStokBaju, NeffSB);
		'filterByPrice' 		: filterByPrice(arrStokBaju, NeffSB);
		'showExpedition' 		: showExpedition(arrEkspedisi, NeffEks);
		'addToCart' 			: addToCart(arrCart, NeffC, arrStokBaju, NeffSb);
		'removeFromCart' 		: removeFromCart(arrCart, NeffC);
		'checkOut'				: checkout(arrCart, NeffC);
		'showTransaction'		: showTransaction(arrTransaksi, NeffTr);
		'retur'					: retur(arrTransaksi, NeffTr, arrStokBaju, NeffSb, tanggalSekarang);
		'exit'					: exit(fileStokBaju, fileTransaksi, fileCart,
										arrStokBaju, arrTransaksi, arrCart,
										NeffSB, NeffTr, NeffC);
	end;
end;

{A L G O R I T M A   U T A M A }
begin
	{Inisialisasi}
	load;
	{membaca tanggal hari ini dari user}
	write('Masukkan tanggal (dd/mm/yy) : ');
	readln(tanggalSekarang);
	
	{start screen}
	writeln('=====================================================');
	writeln('.............Welcome to TokoBaju.com!................');
	writeln('..................Happy shopping!....................');
	writeln('=====================================================');
	writeln;
	repeat
		{menampilkan menu pilihan}
		writeln('Menu : ');
		writeln('1.  showPopulars');
		writeln('2.  showDetailProduct');
		writeln('3.  searchClothesByKeyword');
		writeln('4.  sortPrice');
		writeln('5.  filterClothes');
		writeln('6.  filterByPrice');
		writeln('7.  showExpedition');
		writeln('8.  addToCart');
		writeln('9.  removeFromCart');
		writeln('10. checkOut');
		writeln('11. showTransaction');
		writeln('12. retur');
		writeln('13. exit');
		writeln;
		{membaca input user}
		write('> '); readln(pilihan); 
		
		{eksekusi fungsi/prosedur sesuai pilihan user}
		eksekusiPilihan(pilihan);
	until pilihan = 'exit';
	
	
end.
