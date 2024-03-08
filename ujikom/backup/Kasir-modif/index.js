window.defaultUrl = `${baseUrl}kasir/`;
var diFilter = "";
var newFilter = "";
var kodeVoucher = "";  
var subtotal = ""; 
var potonganHarga;
var produkData = []; //variable untuk menampung data produk
var dataToSend; //variable untuk menampung data yang akan di kirim






var rupiahFields = [
    "tunai",
  ];


$(document).ready(function() {
    let modal = $('#formModal');

    

    viewDataKategori();//panggil fungsi kategori
    viewDatacard();//panggil fungsi card data

// Your debounce function
function debounce(func, delay) {
  let timeout;
  return function () {
    const context = this;
    const args = arguments;
    clearTimeout(timeout);
    timeout = setTimeout(function () {
      func.apply(context, args);
    }, delay);
  };
}

// Your event handler
function filterKeyup() {
  newFilter = $('input[name=filter]').val();
  ////console.log('FILTER BRAY ' + newFilter);
  viewDatacard(newFilter);
}

function voucherKeyup() {
    kodeVoucher = $(this).val();
    $('form [name=diskon]').val(0);
    // ////console.log('VALIDASI VOUCHER BRAY '+ kodeVoucher);
    viewDataVoucher(kodeVoucher);//panggil fungsi voucher
}

function tunaiKeyup() { 
    pembayaran();
}


// Attach the debounced event handler to the input element
$('input[name=filter]').on('keyup', debounce(filterKeyup, 1000)); // Adjust the delay (in milliseconds) as needed
$('input[name=voucher]').on('input', debounce(voucherKeyup, 300)); // Adjust the delay (in milliseconds) as needed
$('input[name=tunai]').on('input', debounce(tunaiKeyup, 100)); // Adjust the delay (in milliseconds) as needed
;


$(`input[name="tunai"]`).on('keyup', function(){
 var tunai = $(this).val();
var formattedTunai = formatRupiah(tunai.toString(), "Rp. ")
$(this).val(formattedTunai);
});
//menghlangkan filter
$('#unfilter').on('click',function(){
            diFilter = '';
            ////console.log('YANG ININIH BRO: ' + diFilter);
            viewDatacard(diFilter);
        });
$(`#btn-batal`).on('click', function(){
    $(`#order`).empty();
});

// $(`input[name="qty[]"]`).on('input', function(){
//     isiSubtotal();
//     totalHarga();
// });

$('#formForm').on('submit', function(e){
    e.preventDefault(); //mencegah perilaku default pengiriman form tradisional
    var bayar = convertToNumber($(`input[name="total"]`).val());
    var total = convertToNumber($(`input[name="tunai"]`).val());
    if(bayar > total){
        return alert('Uang Kurang');
    }else if(bayar < total - 100000){
        return alert('Uang Lebih');
    }
    //mengumpulkan data produk dari elemen input
    $(`input[name="produk_id[]"]`).each(function (index) {
        var produkId = $(this).val();
        var produkNama = $(`input[name="produknama[]"]`).eq(index).val();
        var produkHarga = $(`input[name="produkharga[]"]`).eq(index).val();
        var qty = $(`input[name="qty[]"]`).eq(index).val();
        var subTotal = $(`input[name="subtotal[]"]`).eq(index).val();
        //tambah jika perlu
        produkData.push({id: produkId,nama: produkNama, qty: qty,harga: produkHarga , subtotal: subTotal});
    });

    //Data yang akan di kirim
    dataToSend = {
        bayar : $(`input[name="tunai"]`).val(),
        kembalian : $(`input[name="kembalian"]`).val(),
        voucher_kode : $(`input[name="voucher_kode"]`).val(),
        diskon : $(`input[name="diskon"]`).val(),
        potongan : $(`input[name="potongan"]`).val(),
        total: $(`input[name="total"]`).val(),
        produk_data: produkData
    };
    
    
    //tambah ajax
    $.ajax({
        url: defaultUrl + "store",
        method: 'POST',
        data: dataToSend,
        success: function(response) {
            console.log(response);

            var struk = response.struk ;
            alert("Transaksi Berhasil");
            $.ajax({
                url: defaultUrl + "strukPdf",
                method: 'POST',
                data: struk,
                success: function() {
                    console.log("ahai ahai ");  
                    
                    
                    
                    
                },
                error: function( xhr, status, error) {
                    //tanganin kesalahan jika terjadi
                    console.error('Error: ', error);
                    console.error('Status: ', status );
                    console.error('XHR Response: ', xhr.responseText);
                }
            });
            window.open(defaultUrl + "strukPdf?" + $.param(response), '_blank');            
            $('#formForm')[0].reset();
            $('#order').empty();
        },
        error: function( xhr, status, error) {
            //tanganin kesalahan jika terjadi
            console.error('Error: ', error);
            console.error('Status: ', status );
            console.error('XHR Response: ', xhr.responseText);
        }
    });
});

    $("#btn-refresh-data").click(function () {
        $('#filterModal').find('input[type=checkbox]').prop("checked", false);
        $('input[name=search_kode]').val('');
        $('input[name=search_kode]').prop('disabled', true);
        $('input[name=search_nama]').val('');
        $('input[name=search_nama]').prop('disabled', true);
        $("select[name=kategori_id_search]").val('').trigger('change');
        $("select[name=kategori_id_search]").prop('disabled', true);
        table.ajax.reload();
    });

    $("#btn-search").click(function () {
        $('#filterModal').modal('show');
    });

    



    

    
});



//index.js
function pembayaran(){
    var tunai = $(`form [name="tunai"]`).val();
    var total =  $(`form [name="total"]`).val();
        // var formattedKembalian = formatRupiah(kembalian.toString(), "Rp. ");
        var tunaiNumber = convertToNumber(tunai);
        var totalNumber = convertToNumber(total);

    var kembalian = tunaiNumber - totalNumber;

    // Format kembalian menjadi rupiah
    formattedKembalian = formatKembalian(kembalian.toString(), "Rp. ")    

    // Set nilai formattedKembalian ke elemen dengan ID kembalian
    $(`#kembalian`).val(formattedKembalian);
}



//fungsi tampilan kartu

function viewDatacard (filter){
    //console.log('MASUK FUNGSI DATA CARD COYY');
    // Menghapus kartu yang ada sebelum menampilkan kartu yang baru
    $("#card-field").empty();

    $.ajax({
        url: defaultUrl + "datacard", // Ganti dengan URL aksi yang sesuai
        method: 'POST',
        dataType: 'json',
        data: {
        diFilter: diFilter,
        newFilter: newFilter, // Kirim diFilter sebagai parameter
        },
        success: function(data) {
            
            // //console.log(data); // Menampilkan data dalam konsol
            // Selanjutnya, Anda dapat melakukan apa yang Anda inginkan dengan data ini
            if(data.message){
                //menampilkan pesan dari aksi datacardAction
                console.log("pemberitahuan", data.message,"success");
            }
            if(data.data && data.data.length > 0) {
                for (var i = 0; i < data.data.length; i++) {
                    var cardWrap = createCard(data.data[i]);
                    var filterCard = filter;
                    //tambahkan kartu ke elemen dengan ID
                    $("#card-field").append(cardWrap); //di elemen ID "card-field"
                    //console.log('DARI MANA ' + filterCard);
                }
            }
        },
        //menampilkan pesan kesalahan
        error: function(xhr, status, error) {
            console.error('Error:', error);
            console.error('Status:', status);
            console.error('XHR Response:', xhr.responseText);
            // Tampilkan pesan kesalahan atau tindakan lain yang sesuai
        }
    });
    //membuat kartu atau card

    function createCard(data) {
        var cardWrap = $(`<div class='card-wrapper p-2 col-3'></div>`); //bungkus kartu
        var card = $(`<div class='card cardp produk'  data-card='${JSON.stringify(data)}'></div>`); //kartu
        var cardImgWrap = $("<div class='card-data-img-wrapper container-fluid' style='widht:100%;'></div>"); //bungkus gambar
        var cardImg = $(`<img class='image' src="{{url('UploadImage')}}/${data.gambar}" style='width: 100%;'alt='Gambar Produk'>`); //bungkus gambar
        var cardBody = $("<div class='card-body card-data-body'></div>");
        var cardTextWrap = $("<div class='card-text-wrapper d-flex text-middle text-center align-items-center flex-column'></div>"); // bungkus text
        var cardTitle = $("<h5 class='card-title text-dark m-2'></h5>").html("<b>" + data.nama + "</b>"); //judul 
        var cardPrice = $("<h5 class='card-title price m-2'></h5>").html("<b>" + formatRupiah(data.harga, "Rp. ") + "</b>"); //harga
        

        //pengelompokan kartu
        cardImgWrap.append(cardImg);
        cardTextWrap.append(cardTitle);
        cardTextWrap.append(cardPrice);
        cardBody.append(cardTextWrap);
        card.append(cardImgWrap);
        card.append(cardBody);
        cardWrap.append(card);

        // //console.log("INI DATANYA COYY"+ data.nama);


        
        //klik untuk tambah kartu
        card.on('click',function(){
            //console.log('KARTU DI CLICK BRO');
            var selectedCard = $(this).data('card');
            //console.log(selectedCard);
            onCardClick(selectedCard);
            //console.log('KARTU BERES DI TAMBAHIN BRO');   
            // var rCard = $('cart').data[selectedCard];
            // return rCard;
            
        });

        return cardWrap;

    }
    
    
    
}




    //fungsi saat kartu di klik
    function onCardClick(cardData) {
        //console.log('MASUK FUNGI ON CARD CLICK');
        //tempat kartu mau dicetak
        var order = $('#order');
        
         // Mengecek apakah kartu dengan data yang sama sudah ada dalam keranjang
        var existCard = order.find(`[data-card='${JSON.stringify(cardData)}']`);
        //console.log('CEK JIKA ADA KARTU YANG SAMA' + cardData.nama);
        
        //jika tidak ada yang sama 
        if (existCard.length === 0) {
            var newCard = newCreateCard(cardData); // memanggil fungsi cetak kartu
            newCard.attr('data-card', JSON.stringify(cardData)); // menambah atribut pada kartu yang dicetak
            order.append(newCard);
            // mencetak kartu baru
            // //console.log(cardData.harga);
        } else  //jika ada yang sama
            //tambah 1 di qty card tersebut
        { 
            var quantityInput = existCard.find(`input[name="qty[]"]`);
            var currentValue = parseInt(quantityInput.val());
            quantityInput.val(currentValue + 1);
            var subTotalInput = existCard.find(`input[name="subtotal[]"]`);
            var harga = Number(cardData.harga);
            // var isi = harga
            // console.log(harga);
            subTotalInput.val(quantityInput.val() * harga)
            // console.log(cardData);
            // isiSubtotal()



            //console.log('KARTUNYA DUPLIKAT BRO');
        }
        totalHarga();
    }

       


//fungsi card keranjang
function newCreateCard(data) {
    
    
    // src="` + data + '" width="150px" height="100px" 
    var cardWrap = $(`<div class='produk-wrapper  p-1'></div>`); //bungkus kartu
    var card = $("<div class='produk-data container-fluid p-1 bg-light row'></div>"); //kartu
    var cardLeft = $("<div class='produk-left container-fluid col-4 '></div>");
    var img = $(`<img src="{{url('UploadImage')}}/${data.gambar}" class=" w-100 p-1 " alt="">`);
    var cardRight = $("<div class='produk-right  container-fluid col-8'></div>"); // bungkus text
    var cardTitle = $("<h5 class='produk-name text-dark'></h5>").html(`<b>` + data.nama + `</b>`); //judul 
    var cardPrice = $("<h5 class='produk-price'></h5>").text(formatRupiah(data.harga, "Rp. ")); //harga
    
    //data yang akan di input
    var cardId = $(`<input type='hidden' name='produk_id[]'>`).val(data.id); 
    var cardProduk = $(`<input type='hidden' name='produknama[]'>`).val(data.nama); 
    var cardHarga = $(`<input type='hidden' name='produkharga[]'>`).val(data.harga); 
    var cardSubTotal = $(`<input type='hidden' name='subtotal[]' id='subtotal' value='${data.harga}'>`); //harga
    
    //tombol batal
    var cancel = $(`<b id="btn-x" class="btn btn-x btn-danger"><i class="fas fa-times"></i></b>`);
    var qtyBox = $(`<div class="qty-box"></div>`);
    var btnPlus = $(`<b class="btn btn-danger" id="btn-plus"><i class="fas fa-plus"></i></b>`);
    var qty = $(`<input type='text' id='qty' name='qty[]' class='container-fluid' value="1" >`);
    var btnMinus = $(`<b class="btn btn-warning" id="btn-minus"><i class="fas fa-minus"></i></b>`);
    
    btnPlus.on('click', function() {
        var currentValue = parseInt(qty.val()); // Mengambil nilai saat ini dari input
        qty.val(currentValue + 1); // Menambahkan 1 ke nilai saat ini dan menetapkannya kembali ke elemen input
        
        isiSubtotal();
    });
    
    btnMinus.on('click', function(){
        var currentValue = parseInt(qty.val()); // Mengambil nilai saat ini dari input
        if(currentValue > 1){
            qty.val(currentValue - 1);
            
        }else{
            alert('Qty Tidak Valid')
        }
        isiSubtotal();
    });

    qty.on('input', function() {
        
        isiSubtotal();
    });

    cancel.on('click', function(){
        cardWrap.remove();
        isiSubtotal();
    });

    
    function isiSubtotal(){
        var nilai = parseInt($(qty).val());
        subTotal = data.harga * nilai; 
        // var subtotalInput = $(this).closest('.card-wrapper').find('input[name=subtotal]');
        cardSubTotal.val(subTotal);
        // //console.log(subTotal); 
        totalHarga();
    }

    

    qtyBox.append(btnPlus);
    qtyBox.append(qty);
    qtyBox.append(btnMinus);
    
    // //console.log(data);
    
    //pengelompokan kartu
    cardLeft.append(img);
    cardRight.append(cardId);
    cardRight.append(cardProduk);
    cardRight.append(cardTitle);
    cardRight.append(cancel);
    cardRight.append(cardHarga);
    cardRight.append(cardPrice);
    cardRight.append(qtyBox);
    cardRight.append(cardSubTotal);
    // cardBody.append(cardTextWrap);
    card.append(cardLeft);
    card.append(cardRight);
    cardWrap.append(card);

    totalHarga();
    
    
    // //console.log('KARTU BARU BERES DIBUAT');
    return cardWrap;

}

//funsi total harga
function totalHarga() {
    // formatRupiah();
    //console.log('masuk fungsi total harga');
    // Array.from($('form [name=subtotal]')).reduce((acc, i) => acc + Number(i.value), 0)
    // Array.from($('form [name=subtotal]')).reduce((total, el) => total + Number(el.value), 0)
    // //console.log(potonganHarga + 'diskon blay');
    var total = 0;
    var diskon = parseFloat($('form [name=diskon]').val());
    Array.from($(`form [id=subtotal]`)).forEach(function(el) {
        var subtotal = Number(el.value);
        total += subtotal;
    });

    //console.log(total + ' diskon nyah');
    var potongan =  total * diskon ;
    $(`#potongan`).val(potongan);
    var hasil = total - potongan ;
    //console.log('hasilnyah ' +hasil );
     var formattedTotal = formatRupiah(total.toString(), "Rp. ");
    $('#total').val(formattedTotal);

    pembayaran();
    // console.log('INI DEFAULT URL' + defaultUrl);
    // console.log('INI BASE URL' + baseUrl);
}


//fungsi tampil kategori
function viewDataKategori (){
    //console.log('MASUK DUNGSI KATeGOrI COY');
    $.ajax({
        url: defaultUrl + "datakategori", // Ganti dengan URL aksi yang sesuai
        method: 'POST',
        dataType: 'json',
        success: function(data) {
            // //console.log(data); // Menampilkan data dalam konsol
            // Selanjutnya, Anda dapat melakukan apa yang Anda inginkan dengan data ini
            if(data.message){
                //menampilkan pesan dari aksi datacardAction
                //console.log("pemberitahuan", data.message,"success");
            }
            if(data.data && data.data.length > 0) {
                for (var i = 0; i < data.data.length; i++) {
                    var filterKategori = createFilter(data.data[i]);
                    //tambahkan kartu ke elemen dengan ID
                    $(".page-kategori").append(filterKategori); //di elemen ID "card-field"
                }
            }
        },
        //menampilkan pesan kesalahan
        error: function(xhr, status, error) {
            console.error('Error:', error);
            console.error('Status:', status);
            console.error('XHR Response:', xhr.responseText);
            // Tampilkan pesan kesalahan atau tindakan lain yang sesuai
        }
    });
    //membuat kartu/card
    function createFilter(data) {
        // ----
        var tombol = $(`<button class="btn mr-1 kategori  mb-2 radius-2" data-toggle="modal" style="float:right"></button>`);
        var icon = $(`<i class='fa ${data.icon} text-110 align-text-bottom mr-2 '></i>`);
        var tebal = $(`<b ></b>`).text(data.nama);
    
        // ===
        //pengelompokan kartu
        
        tombol.append(icon);
        tombol.append(tebal);
        //console.log("NAMA KATEGORI: " + data.nama)

        tombol.on('click',function(){
            diFilter = data.nama.toLowerCase();
            viewDatacard(diFilter);
        });
        

        // //console.log(data);
        //klik untuk tambah kartu
        
        return tombol;

    }
    
}


//fungi validasi voucher
function viewDataVoucher (){
    $(".diskon").empty();
    //console.log('MASUK DUNGSI VOUCHER COYY');
    $.ajax({
        url: defaultUrl + "datavoucher", // Ganti dengan URL aksi yang sesuai
        method: 'POST',
        dataType: 'json',
        data:{
            kodeVoucher: kodeVoucher,

        },
        success: function(data) {
            // //console.log(data); // Menampilkan data dalam konsol
            
            
            if(data.message){
                //menampilkan pesan dari aksi datacardAction
                //console.log("pemberitahuan", data.message,"success");
            }
            if(data.data && data.data.length > 0) {
                for (var i = 0; i < data.data.length; i++) {
                    var voucher = createVoucher(data.data[i]);
                    //tambahkan kartu ke elemen dengan ID
                    // //console.log(`MASUK CETAK VOUCHER NIH` + voucher)
                    $(".diskon").append(voucher); //di elemen ID "card-field"
                    //console.log('VALID GAK NIH' + validasi);
                }
            }else{
                var voucher = createVoucher(data);
                    //tambahkan kartu ke elemen dengan ID
                    // //console.log(`MASUK CETAK VOUCHER NIH` + voucher)
                    $(".diskon").append(voucher);
            }
        },
        //menampilkan pesan kesalahan
        error: function(xhr, status, error) {
            console.error('Error:', error);
            console.error('Status:', status);
            console.error('XHR Response:', xhr.responseText);
            // Tampilkan pesan kesalahan atau tindakan lain yang sesuai
        }
    });
    //membuat card
    function createVoucher(data) {
        var tr = $('.diskon');
        var status = $("<td class=' p-1 '></td>").html('<h5><b>' + data.status + '</b></h5>');
        var potongan = $('form [name=diskon]');

        if((data.status == null) || (data.status == '') ){
            var valid = $("<td colspan='3' align='center' class=' p-1 '></td>").html('<h5><b>' + 'Kode Tidak Valid' + '</b></h5>');
            
            potongan.val(0);
            totalHarga();
            tr.append(valid);
            return tr;
        }else if(data.status == 'Aktif'){
            
            var persen = data.diskon * 100;
            var kodeVoucher = $("<input type='hidden' name='voucher_kode'>").val(data.kode);
            var diskon = $("<td class=' p-1 '></td>").html(`<input type='text' value='${persen + '%'}' disabled>`);
            
            potongan.val(data.diskon);
            totalHarga();
            tr.append(kodeVoucher);
            tr.append(status);
            tr.append(diskon);
            return tr;

        }else{
            var valid = $("<td colspan='3' align='center' class=' p-1 '></td>").html('<h5><b>' + 'Voucher Tidak Aktif' + '</b></h5>');
            
            potongan.val(0);
            totalHarga();
            tr.append(valid);
            return tr;
        }
        // Menggabungkan elemen-elemen ke dalam baris
            
    }
    
    
    
}






function resetErrors() {
    $('.form-control').each(function(i, el) {
        $(el).removeClass('brc-danger-m2');
        $(el).next().text('').hide();
        $(el).prev().removeClass('text-danger-d1');
    });
}

function confirmDelete() {
    let swalWithBootstrapButtons = Swal.mixin({
        buttonsStyling: false,
    });

    return swalWithBootstrapButtons.fire({
        title: 'Apakah anda yakin?',
        type: 'warning',
        showCancelButton: true,
        scrollbarPadding: false,
        confirmButtonText: 'Ya',
        cancelButtonText: 'Tidak',
        customClass: {
            confirmButton: 'btn btn-success mx-2 px-3 radius-2',
            cancelButton: 'btn btn-danger mx-2 px-3 radius-2'
        }
    });
}


function formatKembalian(angka, prefix) {
    // Check if the value is negative
    const isNegative = angka < 0;

    // Convert the number to a positive value for formatting
    const number_string = Math.abs(angka).toString();
    const split = number_string.split(",");
    const sisa = split[0].length % 3;
    let rupiah = split[0].substr(0, sisa);
    const ribuan = split[0].substr(sisa).match(/\d{3}/gi);

    if (ribuan) {
        separator = sisa ? "." : "";
        rupiah += separator + ribuan.join(".");
    }

    rupiah = split[1] !== undefined ? rupiah + "," + split[1] : rupiah;

    // Add the prefix and '-' sign if necessary
    const formatted = (isNegative ? "-" : "") + (prefix === undefined ? rupiah : prefix + rupiah);
    return formatted;
}

function formatRupiah(angka, prefix) {
    var number_string = angka.replace(/[^,\d]/g, "").toString(),
        split = number_string.split(","),
        sisa = split[0].length % 3,
        rupiah = split[0].substr(0, sisa),
        ribuan = split[0].substr(sisa).match(/\d{3}/gi);

    if (ribuan) {
        separator = sisa ? "." : "";
        rupiah += separator + ribuan.join(".");
    }

    rupiah = split[1] != undefined ? rupiah + "," + split[1] : rupiah;
    return prefix == undefined ? rupiah : prefix + rupiah;
}
rupiahFields.forEach(function (field) {
    var element = document.getElementById(field);
    element.addEventListener("change", function (e) {
      element.value = formatRupiah(this.value, "Rp. ");
    });
  });

function convertRupiah(){
    rupiahFields.forEach(function (field) {
      var element = document.getElementById(field);
      element.value = formatRupiah(element.value, "Rp. ");
    });
}

function convertToNumber(rupiahValue) {
    return Number(rupiahValue.replace(/[^\d,-]+/g, ""));
}
// function convertToNumber(rupiahValue) {
//     return Number(rupiahValue.replace(/[^0-9,-]+/g,""));
// }

// Contoh penggunaan:
// var formattedKembalian = formatRupiah(kembalian.toString(), "Rp. ");
// var kembalianNumber = convertToNumber(formattedKembalian);
// console.log(kembalianNumber); // Output akan berupa nilai numerik dari kembalian dalam rupiah



