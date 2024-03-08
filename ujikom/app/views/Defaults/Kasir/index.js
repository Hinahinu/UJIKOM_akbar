window.defaultUrl = `${baseUrl}kasir/`;
var diFilter = "";
var newFilter = "";
var kodeVoucher = "";
var subtotal = "";
var potonganHarga;
var produkData = [];
var dataToSend;

var rupiahFields = ["tunai"];

$(document).ready(function () {
  let modal = $("#formModal");

  viewDataKategori(); 
  viewDatacard();
  $(`form input[name="kode_voucher"]`).val("");
  // if($('input[name=voucher]') == '' || null ){
  //     console.log('ih kosong');
  // }
  // voucherKeyup();

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
    newFilter = $("input[name=filter]").val();
    console.log("filter kkey aktip");

    if (newFilter != "") {
      viewDatacard(newFilter);
    } else {
      viewDatacard();
    }
    ////console.log('FILTER BRAY ' + newFilter);
  }

  function voucherKeyup() {
    kodeVoucher = $(this).val();
    $("form [name=diskon]").val(0);
    // ////console.log('VALIDASI VOUCHER BRAY '+ kodeVoucher);

    if ($(this).val() == null || $(this).val() == "") {
      // console.log('kekosongan terpanggil')
      $("form [name=diskon]").val(0);
      $(`#diskon`).val(0);
    } else {
      viewDataVoucher(kodeVoucher); //panggil fungsi voucher
    }
  }

  function tunaiKeyup() {
    pembayaran();
  }

  $("input[name=filter]").on("keyup", debounce(filterKeyup, 1000)); 
  $("input[name=voucher]").on("input", debounce(voucherKeyup, 300)); 
  $("input[name=tunai]").on("input", debounce(tunaiKeyup, 100)); 
  $(`input[name="tunai"]`).on("keyup", function () {
    var tunai = $(this).val();
    var formattedTunai = formatRupiah(tunai.toString(), "Rp. ");
    $(this).val(formattedTunai);
  });
  //menghlangkan filter
  $("#unfilter").on("click", function () {
    diFilter = "";
    ////console.log('YANG ININIH BRO: ' + diFilter);
    viewDatacard(diFilter);
  });
  $(`#btn-batal`).on("click", function () {
    $(`#order`).empty();
    $("#formForm")[0].reset();
  });

  $("#formForm").on("submit", function (e) {
    produkData = [];
    e.preventDefault(); //mencegah perilaku default pengiriman form tradisional
    var bayar = convertToNumber($(`input[name="tunai"]`).val());
    var total = convertToNumber($(`input[name="grand_total"]`).val());
    if (total > bayar) {
      return alert("Uang Kurang");
    } else if (total < bayar - 100000) {
      return alert("Uang Lebih");
    }
    //mengumpulkan data produk dari elemen input
    $(`input[name="produk_id[]"]`).each(function (index) {
      var produkId = $(this).val();
      var produkNama = $(`input[name="produknama[]"]`).eq(index).val();
      var produkHarga = $(`input[name="produkharga[]"]`).eq(index).val();
      var qty = $(`input[name="qty[]"]`).eq(index).val();
      var subTotal = $(`input[name="subtotal[]"]`).eq(index).val();
      //tambah jika perlu
      produkData.push({ id: produkId, nama: produkNama, qty: qty, harga: produkHarga, subtotal: subTotal });
    });

    //Data yang akan di kirim
    dataToSend = {
      bayar: $(`input[name="tunai"]`).val(),
      kembalian: $(`input[name="kembalian"]`).val(),
      voucher_kode: $(`form input[name="kode_voucher" ]`).val(),
      diskon: $(`input[name="diskon"]`).val(),
      potongan: $(`input[name="potongan"]`).val(),
      total: $(`input[name="total"]`).val(),
      grand_total: $(`input[name="grand_total"]`).val(),
      produk_data: produkData,
    };

    $.ajax({
      url: defaultUrl + "store",
      method: "POST",
      data: dataToSend,
      success: function (response) {
        response.data;

        // Pastikan bahwa cetakStruk() dikonfigurasi dan digunakan dengan benar
        cetakStruk().then(function (cetakResult) {
          if (cetakResult.value) {
            window.open(defaultUrl + "strukPdf?" + $.param(response), "_blank");
          }
        });
        viewDataVoucher();
        pembersihan();
      },
      error: function (xhr, status, error) {
        console.error("Error: ", error);
        console.error("Status: ", status);
        console.error("XHR Response: ", xhr.responseText);
        alert("Terjadi kesalahan dalam melakukan transaksi.");
      },
    });
  });

  $(`.btn-kategori`).on("click", function () {
    $(".btn-kategori").removeClass("dipilih");

    // Menambahkan kelas 'active' hanya pada tombol yang diklik
    $(this).addClass("dipilih");
  });

  $(`#bersih`).on("click", function () {
    console.log("cleaning dipanggil");
    newFilter = $(`input[name=filter]`).val("");
    viewDatacard(newFilter); //panggil fungsi card data
  });
});

//index.js
function pembayaran() {
  var tunai = $(`form [name="tunai"]`).val();
  var total = $(`form [name="grand_total"]`).val();
  // var formattedKembalian = formatRupiah(kembalian.toString(), "Rp. ");
  var tunaiNumber = convertToNumber(tunai);
  var totalNumber = convertToNumber(total);

  var kembalian = tunaiNumber - totalNumber;

  // Format kembalian menjadi rupiah
  formattedKembalian = formatKembalian(kembalian.toString(), "Rp. ");

  // Set nilai formattedKembalian ke elemen dengan ID kembalian
  $(`#kembalian`).val(formattedKembalian);
}

function pembersihan() {
  // viewDataVoucher();
  // window.open(defaultUrl + "strukPdf?" + $.param(response), '_blank');
  $("#formForm")[0].reset();
  $("#order").empty();
  // $('#diskon').val(0);
  $("#diskon").val("");
}

//fungsi tampilan kartu

function viewDatacard(filter) {
  //console.log('MASUK FUNGSI DATA CARD COYY');
  // Menghapus kartu yang ada sebelum menampilkan kartu yang baru
  $("#card-field").empty();

  $.ajax({
    url: defaultUrl + "datacard", // Ganti dengan URL aksi yang sesuai
    method: "POST",
    dataType: "json",
    data: {
      diFilter: diFilter,
      newFilter: newFilter, // Kirim diFilter sebagai parameter
    },
    success: function (data) {
      // //console.log(data); // Menampilkan data dalam konsol
      // Selanjutnya, Anda dapat melakukan apa yang Anda inginkan dengan data ini
      if (data.message) {
        //menampilkan pesan dari aksi datacardAction
        console.log("pemberitahuan", data.message, "success");
      }
      if (data.data && data.data.length > 0) {
        for (var i = 0; i < data.data.length; i++) {
          var cardWrap = createCard(data.data[i]);

          //tambahkan kartu ke elemen dengan ID
          $("#card-field").append(cardWrap); //di elemen ID "card-field"
          //console.log('DARI MANA ' + filterCard);
        }
      }
    },
    //menampilkan pesan kesalahan
    error: function (xhr, status, error) {
      console.error("Error:", error);
      console.error("Status:", status);
      console.error("XHR Response:", xhr.responseText);
      // Tampilkan pesan kesalahan atau tindakan lain yang sesuai
    },
  });
  //membuat kartu atau card

  function createCard(data) {
    // var cardWrap = $(`<div class='card-wrapper pr-3 pl-3 pt-1 pb-1  col-3'></div>`); //bungkus kartu
    var cardWrap = $(`<div class='card-wrapper p-3 col-lg-3 col-md-6 col-sm-12 col-12' style=" width: 700px;"></div>`); //bungkus kartu
    // var card = $(`<div class='card cardp produk shadow ' style="background-color:#ECE3CE;"  data-card='${JSON.stringify(data)}'></div>`); //kartu
    var card = $(`<div class='card cardp produk shadow ' style="background-color:#F8F4FF; border: 3px solid #CCBBBB; width: 200px;"  data-card='${JSON.stringify(data)}'></div>`); //kartu
    var cardImgWrap = $("<div class='card-data-img-wrapper ' style='max-width:fit-content;'></div>"); //bungkus gambar
    var cardImg = $(`<img class='image' src="{{url('UploadImage')}}/${data.gambar}" style='width: 100%;'alt='Gambar Produk'>`); //bungkus gambar
    var cardBody = $("<div class='card-body card-data-body '></div>");
    var cardTextWrap = $("<div class='card-text-wrapper d-flex  text-middle text-center align-items-center flex-column'></div>"); // bungkus text
    var cardTitle = $("<h5 class='card-title text-dark '></h5>").html("<b>" + data.nama + "</b>"); //judul
    var cardPrice = $("<h5 class='card-title price mt-2'></h5>").html("<b>" + formatRupiah(data.harga, "Rp. ") + "</b>"); //harga

    if (data.stok == "0") {
      cardWrap = $(`<div class='card-wrapper p-3 col-lg-3 col-md-6 col-sm-12 col-12' style="filter: grayscale(100%) blur(1px);-webkit-filter: grayscale(100%) blur(1px);"></div>`); //bungkus kartu
    }

    //pengelompokan kartu
    cardImgWrap.append(cardImg);
    cardTextWrap.append(cardTitle);
    cardTextWrap.append(cardPrice);
    cardBody.append(cardTextWrap);
    card.append(cardImgWrap);
    card.append(cardBody);
    cardWrap.append(card);

    // //console.log("INI DATANYA COYY"+ data.nama);
    console.log(JSON.stringify(data));

    //klik untuk tambah kartu
    if (data.stok !== "0") {
      card.on("click", function () {
        //console.log('KARTU DI CLICK BRO');
        var selectedCard = $(this).data("card");
        //console.log(selectedCard);
        onCardClick(selectedCard);
        //console.log('KARTU BERES DI TAMBAHIN BRO');
        // var rCard = $('cart').data[selectedCard];
        // return rCard;
      });
    }

    return cardWrap;
  }
}

//fungsi saat kartu di klik
function onCardClick(cardData) {
  //console.log('MASUK FUNGI ON CARD CLICK');
  //tempat kartu mau dicetak
  var order = $("#order");

  // Mengecek apakah kartu dengan data yang sama sudah ada dalam keranjang
  var existCard = order.find(`[data-card='${JSON.stringify(cardData)}']`);
  //console.log('CEK JIKA ADA KARTU YANG SAMA' + cardData.nama);

  //jika tidak ada yang sama
  if (existCard.length === 0) {
    var newCard = newCreateCard(cardData);
    newCard.attr("data-card", JSON.stringify(cardData));
    order.append(newCard);
    // mencetak kartu baru
  }
  else {
    var quantityInput = existCard.find(`input[name="qty[]"]`);
    var currentValue = parseInt(quantityInput.val());

    quantityInput.val(currentValue + 1);
    var subTotalInput = existCard.find(`input[name="subtotal[]"]`);
    var harga = Number(cardData.harga);
    // var isi = harga
    // console.log(harga);
    subTotalInput.val(quantityInput.val() * harga);
    // console.log(cardData);
    // isiSubtotal()

    //console.log('KARTUNYA DUPLIKAT BRO');
  }
  totalHarga();
}

//fungsi card keranjang
function newCreateCard(data) {
  // src="` + data + '" width="150px" height="100px"
  var cardWrap = $(`<div class='produk-wrapper p-1 '></div>`); //bungkus kartu
  // var card = $("<div class='produk-data  p-1 m-1  border shadow  row'  style='widht:100%; border-radius: 8px; background-color:#ECE3CE;' ></div>"); //kartu
  var card = $("<div class='produk-data  p-1 m-1  border shadow  row'  style='widht:100%; border-radius: 8px; background-color:#f8f4ff;' ></div>"); //kartu
  // var cardLeft = $("<div class='produk-left container-fluid col-4 w-100 '></div>");
  var cardLeft = $("<div class='produk-left  col-4 p-0 m-0 '></div>");
  // var img = $(`<img src="{{url('UploadImage')}}/${data.gambar}" class=" " style="width:100%;" alt="">`);
  var img = $(`<img src="{{url('UploadImage')}}/${data.gambar}" class="p-0 m-0 rounded-lg" style="width:100%; height:74px" alt="">`);
  var cardRight = $("<div class='produk-right  container-fluid col-8'></div>"); // bungkus text
  var cardTitle = $("<h5 class='produk-name text-dark'></h5>").html(`<b>` + data.nama + `</b>`); //judul
  var cardPrice = $("<h5 class='produk-price'></h5>").html("<b>" + formatRupiah(data.harga, "Rp. ") + "</b>"); //harga

  //data yang akan di input
  var cardId = $(`<input type='hidden' name='produk_id[]'>`).val(data.id);
  var cardProduk = $(`<input type='hidden' name='produknama[]'>`).val(data.nama);
  var cardHarga = $(`<input type='hidden' name='produkharga[]'>`).val(data.harga);
  var cardSubTotal = $(`<input type='hidden' name='subtotal[]' id='subtotal' value='${data.harga}'>`); //harga

  //tombol batal
  var cancel = $(`<b id="btn-x" class="btn btn-x btn-danger"><i class="fas fa-times"></i></b>`);
  var qtyBox = $(`<div class="qty-box"></div>`);
  var btnPlus = $(`<b class="btn" style="background-color: lightblue;" id="btn-plus"><i class="fas fa-plus"></i></b>`);
  var qty = $(`<input type='text' id='qty' name='qty[]' class='container-fluid' value="1" >`);
  var btnMinus = $(`<b class="btn btn-danger" id="btn-minus"><i class="fas fa-minus"></i></b>`);

  btnPlus.on("click", function () {
    var currentValue = parseInt(qty.val()); // Mengambil nilai saat ini dari input
    qty.val(currentValue + 1); // Menambahkan 1 ke nilai saat ini dan menetapkannya kembali ke elemen input
    var inputQty = parseInt(qty.val());
    var stok = parseInt(data.stok); // Mendapatkan nilai stok dari elemen dengan id 'stok'

    // Mengonversi nilai input menjadi angka bulat (integer)
    inputQty = parseInt(inputQty);

    // Memastikan inputQty tidak melebihi stok yang tersedia
    if (inputQty > stok) {
      // Jika inputQty melebihi stok, atur nilai inputQty menjadi stok yang tersedia
      qty.val(stok);
    }

    isiSubtotal();
  });

  btnMinus.on("click", function () {
    var currentValue = parseInt(qty.val()); // Mengambil nilai saat ini dari input
    if (currentValue > 1) {
      qty.val(currentValue - 1);
    } else {
      alert("Qty Tidak Valid");
    }
    isiSubtotal();
  });

  qty.on("input", function () {
    var inputQty = $(this).val();
    var stok = parseInt(data.stok); // Mendapatkan nilai stok dari elemen dengan id 'stok'

    // Mengonversi nilai input menjadi angka bulat (integer)
    inputQty = parseInt(inputQty);

    // Memastikan inputQty tidak melebihi stok yang tersedia
    if (inputQty > stok) {
      // Jika inputQty melebihi stok, atur nilai inputQty menjadi stok yang tersedia
      $(this).val(stok);
    }

    // Memanggil fungsi untuk mengupdate subtotal
    isiSubtotal();
  });

  cancel.on("click", function () {
    cardWrap.remove();
    isiSubtotal();
  });

  function isiSubtotal() {
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
  var hasil = 0;
  var diskon = parseFloat($("form [name=diskon]").val());
  console.log("lhaa ini ada" + diskon);
  Array.from($(`form [id=subtotal]`)).forEach(function (el) {
    var subtotal = Number(el.value);
    total += subtotal;
  });

  //console.log(total + ' diskon nyah');
  var potongan = parseInt(total) * parseFloat(diskon);
  $(`#potongan`).val(parseInt(potongan));
  console.log("lha ini masil lanjut" + potongan);
  var hasil = total - potongan;
  console.log("kayanya disini ni " + hasil + " totalnya " + total + " potongannya " + potongan);
  //console.log('hasilnyah ' +hasil );
  var formattedTotal = formatRupiah(parseInt(total).toString(), "Rp. ");
  var formattedHasil = formatRupiah(parseInt(hasil).toString(), "Rp. ");
  $("#total").val(formattedTotal);
  $("#grand_total").val(formattedHasil);

  pembayaran();
  // console.log('INI DEFAULT URL' + defaultUrl);
  // console.log('INI BASE URL' + baseUrl);
}

//fungsi tampil kategori
function viewDataKategori() {
  //console.log('MASUK DUNGSI KATeGOrI COY');
  $.ajax({
    url: defaultUrl + "datakategori", // Ganti dengan URL aksi yang sesuai
    method: "POST",
    dataType: "json",
    success: function (data) {
      // //console.log(data); // Menampilkan data dalam konsol
      // Selanjutnya, Anda dapat melakukan apa yang Anda inginkan dengan data ini
      if (data.message) {
        //menampilkan pesan dari aksi datacardAction
        //console.log("pemberitahuan", data.message,"success");
      }
      if (data.data && data.data.length > 0) {
        for (var i = 0; i < data.data.length; i++) {
          var filterKategori = createFilter(data.data[i]);
          //tambahkan kartu ke elemen dengan ID
          $(".page-kategori").append(filterKategori); //di elemen ID "card-field"
        }
      }
    },
    //menampilkan pesan kesalahan
    error: function (xhr, status, error) {
      console.error("Error:", error);
      console.error("Status:", status);
      console.error("XHR Response:", xhr.responseText);
      // Tampilkan pesan kesalahan atau tindakan lain yang sesuai
    },
  });
  //membuat kartu/card
  function createFilter(data) {
    // ----

    var tombol = $(`<button class="btn tombolfilter kategori btn-kategori mr-2  radius-2 p-1 " data-toggle="modal" ></button>`);
    var icon = $(`<i class='fa ${data.icon} text-110 align-text-bottom mr-2 '></i>`);
    var tebal = $(`<b ></b>`).text(data.nama);

    // ===
    //pengelompokan kartu

    tombol.append(icon);
    tombol.append(tebal);
    //console.log("NAMA KATEGORI: " + data.nama)

    tombol.on("click", function () {
      $(".btn-kategori").removeClass("dipilih");

      // Menambahkan kelas 'active' hanya pada tombol yang diklik
      $(this).addClass("dipilih");
      diFilter = data.nama.toLowerCase();
      viewDatacard(diFilter);
    });

    // //console.log(data);
    //klik untuk tambah kartu

    return tombol;
  }
}

//fungi validasi voucher
function viewDataVoucher(kodeVoucher) {
  $("#diskon").empty();
  //console.log('MASUK DUNGSI VOUCHER COYY');
  $.ajax({
    url: defaultUrl + "datavoucher", // Ganti dengan URL aksi yang sesuai
    method: "POST",
    dataType: "json",
    data: {
      kodeVoucher: kodeVoucher,
    },
    success: function (data) {
      // //console.log(data); // Menampilkan data dalam konsol

      if (data.message) {
        //menampilkan pesan dari aksi datacardAction
        //console.log("pemberitahuan", data.message,"success");
      }
      if (data.data && data.data.length > 0) {
        for (var i = 0; i < data.data.length; i++) {
          // var voucher = createVoucher(data.data[i]);
          createVoucher(data.data[i]);
          //tambahkan kartu ke elemen dengan ID
          // //console.log(`MASUK CETAK VOUCHER NIH` + voucher)
          // $(".diskon").append(voucher); //di elemen ID "card-field"
          //console.log('VALID GAK NIH' + validasi);
        }
      } else {
        // var voucher = createVoucher(data);
        createVoucher(data);
        //tambahkan kartu ke elemen dengan ID
        // //console.log(`MASUK CETAK VOUCHER NIH` + voucher)
        // $(".diskon").append(voucher);
      }
    },
    //menampilkan pesan kesalahan
    error: function (xhr, status, error) {
      console.error("Error:", error);
      console.error("Status:", status);
      console.error("XHR Response:", xhr.responseText);
      // Tampilkan pesan kesalahan atau tindakan lain yang sesuai
    },
  });
  //membuat card
  function createVoucher(data) {
    var idDiskon = $(`#diskon`);
    var tr = $(".diskon");
    var status = $("<td class=' p-1 '></td>").html("<h5><b> Diskon </b></h5>");
    var potongan = $("form [name=diskon]");
    var kodeVoucher = $("<input type='hidden' name='voucher_kode'>");
    $(`form input[name="kode_voucher"]`).val("");

    console.log("ini bisa ningan ey" + JSON.stringify(kodeVoucher));

    if (data.status == null || data.status == "") {
      // var valid = $("<td colspan='3' align='center' class=' p-1 '></td>").html('<h5><b>' + 'Kode Tidak Valid' + '</b></h5>');
      idDiskon.val("Kode Tidak Valid");
      $(`form input[name="kode_voucher"]`).val("");
      potongan.val(0);
      totalHarga();
      // tr.append(valid);
      // return tr;
    } else if (data.status == "Aktif") {
      var persen = data.diskon * 100;
      // kodeVoucher.val(data.kode);
      $(`form input[name="kode_voucher"]`).val(data.kode);
      // var diskon = $("<td class=' p-1 '></td>").html(`<input type='text' value='${persen + '%'}' disabled>`);
      idDiskon.val(persen + "%");
      potongan.val(data.diskon);
      totalHarga();
      tr.append(kodeVoucher);
      // tr.append(status);
      // tr.append(diskon);
      // return tr;
    } else {
      var valid = $("<td colspan='3' align='center' class=' p-1 '></td>").html("<h5><b>" + "Voucher Tidak Aktif" + "</b></h5>");
      idDiskon.val("Voucher Tidak Aktif");
      $(`form input[name="kode_voucher"]`).val("");
      potongan.val(0);
      totalHarga();
      // tr.append(valid);
      // return tr;
    }
    // Menggabungkan elemen-elemen ke dalam baris
  }
}

function resetErrors() {
  $(".form-control").each(function (i, el) {
    $(el).removeClass("brc-danger-m2");
    $(el).next().text("").hide();
    $(el).prev().removeClass("text-danger-d1");
  });
}

function cetakStruk() {
  let swalWithBootstrapButtons = Swal.mixin({
    buttonsStyling: false,
  });

  return swalWithBootstrapButtons.fire({
    title: "Cetak Struk?",
    type: "warning",
    showCancelButton: true,
    scrollbarPadding: false,
    confirmButtonText: "Ya",
    cancelButtonText: "Tidak",
    customClass: {
      confirmButton: "btn btn-success mx-2 px-3 radius-2",
      cancelButton: "btn btn-danger mx-2 px-3 radius-2",
    },
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

function convertRupiah() {
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
