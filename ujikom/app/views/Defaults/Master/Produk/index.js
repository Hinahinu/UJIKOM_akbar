window.defaultUrl = `${baseUrl}/master/produk/`;
var table;
var rupiahFields = ["hargajual", "hpp"];
// var bahanData = [];
// var dataToSend;
var bahanData = [];
var formatRupiah;
var order = 1;
$(document).ready(function () {
  let modal = $("#formModal");
  let modal2 = $("#formStok");
  viewDatatable();
  select2data();

  $("#btn-refresh-data").click(function () {
    $("#filterModal").find("input[type=checkbox]").prop("checked", false);
    $("input[name=search_kode]").val("");
    $("input[name=search_kode]").prop("disabled", true);
    $("input[name=search_nama]").val("");
    $("input[name=search_nama]").prop("disabled", true);
    $("select[name=kategori_id_search]").val("").trigger("change");
    $("select[name=kategori_id_search]").prop("disabled", true);
    table.ajax.reload();
  });

  $("#btn-search").click(function () {
    $("#filterModal").modal("show");
  });

  $("#btn-edit").click(function () {
    let selected = table
      .row({
        selected: true,
      })
      .data();
    if (_.isEmpty(selected)) {
      notification("warning", "Pilih Data Terlebih Dahulu");
      return false;
    }
    if (selected) {
      modal2.find("input[name=_type]").val("edit");
      modal2.find("input[name=id]").val(selected.id);
      modal2.find("input[name=stok").val(selected.stok);
      resetErrors();
      modal2.modal("show");
    }
  });
  $("#btn-detail").on("click", function () {
    $("#komposisi").empty();
    let selected = table
      .row({
        selected: true,
      })
      .data();
    if (_.isEmpty(selected)) {
      notification("warning", "Pilih Data Terlebih Dahulu");
      return false;
    }
    if (selected) {
      console.log(JSON.stringify(selected));
      modal.find("input[name=_type]").val("edit");
      modal.find("input[name=id]").val(selected.id);
      modal.find("input[name=filename]").val();
      console.log("value select 2", selected.gambar);
      modal.find("input[name=nama]").val(selected.nama);

      $("select[name=kategori]").select2("trigger", "select", { data: { id: selected.kategori_id, text: selected.kategori } });
      modal.find("input[name=hpp]").val(selected.hpp);
      modal.find("input[name=hargajual]").val(selected.harga);
      modal.find("input[name=stok]").val(selected.stok);
      dataUntung();
      convertRupiah();
      resetErrors();
      modal.modal("show");
    }
  });

  $("#btn-delete").on("click", async function () {
    let selected = table
      .row({
        selected: true,
      })
      .data();
    if (_.isEmpty(selected)) {
      notification("warning", "Pilih Data Terlebih Dahulu");
      return false;
    }
    if (selected && (await confirmDelete()).value) {
      $.post(defaultUrl + "delete?id=" + selected.id)
        .done(function () {
          notification("success", "Data berhasil dihapus");
          table.ajax.reload();
          $("#btn-edit").addClass("disabled");
          $("#btn-delete").addClass("disabled");
        })
        .fail(function () {
          notification("danger", "Data gagal dihapus");
        });
    }
  });

  $("#btn-add").click(function () {
    $("#komposisi").empty();
    modal.find(`input[name="nama"]`).val("");
    modal.find(`input[name="gambar"]`).val("");
    modal.find(`select[name="kategori"]`).val(null).trigger("change"); // Reset select2
    // modal.find(`select[name="bahan[]"]`).val(null).trigger('change'); // Reset select2
    modal.find(`input[name="jumlah[]"]`).val("1");
    modal.find(`input[name="hpp"]`).val("");
    modal.find(`input[name="hargajual"]`).val("");
    modal.find(`input[name="stok  "]`).val("");
    modal.find(`input[name="_type"]`).val("create");
    dataUntung();
    tambahBahan();
    resetErrors();
    $("#formModal").modal("show");
  });

  $("#tambah").on("click", function () {
    tambahBahan();
  });
  $("#formStok form").submit(function (ev) {
    ev.preventDefault();

    let submitButton = $(this).find("[type=submit]");
    let originalContent = submitButton.html();
    submitButton.html('<i class="fa fa-spin fa-spinner"></i> Menyimpan...');
    submitButton.prop("disabled", true);
    var formData = new FormData($(this)[0]);
    // formData.append("id", selected.id); // Menambahkan ID terpilih
    console.log(formData);
    $.ajax({
      url: defaultUrl + "stok",
      type: "POST",
      data: formData,
      contentType: false,
      processData: false,
      success: function (response) {
        // Handle respons dari server di sini
        notification("success", "Data berhasil disimpan");
        submitButton.html(originalContent);
        submitButton.prop("disabled", false);
        table.ajax.reload();
        console.log(response);
        modal2.modal("hide");
      },
    });
  });
  //     e.preventDefault();

  //     let bahanData = []; // Inisialisasi variabel bahanData
  //     let formData = new FormData(); // Buat objek FormData untuk mengirim data termasuk gambar

  //     modal.find(`select[name="bahan[]"]`).each(function (index){
  //         var bahan = $(this).val();
  //         var jumlah = $(`input[name="jumlah[]"]`).eq(index).val();
  //         var total = $(`input[name="total[]"]`).eq(index).val();

  //         bahanData.push({bahan: bahan, jumlah: jumlah, total: total});
  //     });

  //     console.log(bahanData);

  //     // Tambahkan data bahan ke FormData
  //     formData.append('bahan_data', JSON.stringify(bahanData));

  //     // Tambahkan data lain ke FormData
  //     formData.append('nama', $('input[name="nama"]').val());
  //     formData.append('kategori', $('select[name="kategori"]').val());
  //     formData.append('hpp', $(`input[name="hpp"]`).val());
  //     formData.append('harga_jual', $(`input[name="hargajual"]`).val());

  //     // Ambil file gambar dari input dengan id 'gambar'
  //     let gambarFile = $('input[name="filename"]')[0].files[0]; // Ganti 'gambar' dengan id yang sesuai

  //     // Tambahkan file gambar ke FormData
  //     formData.append('gambar', gambarFile);

  //     $.ajax({
  //         url: defaultUrl + "store",
  //         method: 'POST',
  //         data: formData,
  //         processData: false, // Set false agar FormData tidak diproses secara otomatis
  //         contentType: false, // Set false agar tipe konten tidak diatur secara otomatis
  //         success: function(response){
  //             console.log(response);
  //         },
  //         error: function(xhr, status, error){
  //             console.error('Error: ', error);
  //             console.error('Status: ', status);
  //             console.error('XHR Response: ', xhr);
  //         }
  //     });
  // });

  modal.find("form").on("submit", function (ev) {
    ev.preventDefault();

    let submitButton = $(this).find("[type=submit]");
    let originalContent = submitButton.html();

    let type = $("[name=_type]").val();
    let id = $("[name=id]").val();
    let url = type == "create" ? defaultUrl + "store" : defaultUrl + "update";
    var formData = new FormData();

    modal.find(`select[name="bahan[]"]`).each(function (index) {
      var bahan = $(this).val();
      var jumlah = $(`input[name="jumlah[]"]`).eq(index).val();
      var total = $(`input[name="total[]"]`).eq(index).val();

      bahanData.push({ bahan: bahan, jumlah: jumlah, total: total });
    });
    console.log(bahanData);

    // Tambahkan data bahan ke FormData
    formData.append("bahan_data", JSON.stringify(bahanData));

    // Tambahkan data lain ke FormData
    formData.append("nama", $('input[name="nama"]').val());
    formData.append("kategori", $('select[name="kategori"]').val());
    formData.append("hpp", $(`input[name="hpp"]`).val());
    formData.append("harga_jual", $(`input[name="hargajual"]`).val());
    formData.append("stok", $(`input[name="stok"]`).val());

    let gambarFile = $('input[name="filename"]')[0].files[0]; // Ganti 'gambar' dengan id yang sesuai
    formData.append("gambar", gambarFile);

    // formData.append("filename", $("#filename").prop("files")[0]);
    $(this)
      .serializeArray()
      .forEach((item) => formData.append(item.name, item.value));

    $.ajax({ url, data: formData, processData: false, contentType: false, type: "POST" })
      .done(function (response) {
        notification("success", "Data berhasil disimpan");
        modal.modal("hide");
        table.ajax.reload();
      })
      .fail(function (jqXHR) {
        if (jqXHR && jqXHR.responseJSON && jqXHR.responseJSON.errors) {
          let errors = jqXHR.responseJSON.errors;
          for (let field in errors) {
            let el = $(`[name=${field}]`);
            el.toggleClass("brc-danger-m2");
            el.next().text(errors[field]).show();
            el.prev().toggleClass("text-danger-d1");
          }
        }
      })
      .always(function () {
        submitButton.html(originalContent);
        submitButton.prop("disabled", false);
      });
  });
});

function viewDatatable() {
  table = $("#datatable")
    .DataTable({
      ajax: {
        url: defaultUrl + "datatable",
        type: "post",
        data: function (d) {
          var formData = $("#form-filter").serializeArray();
          $.each(formData, function (key, val) {
            d[val.name] = val.value;
          });
        },
      },
      serverSide: true,
      processing: true,
      responsive: true,
      selected: false,
      aaSorting: [],
      columnDefs: [
        {
          searchable: false,
          targets: [0],
        },
      ],
      columns: [
        {
          data: "id",
          orderable: false,
          render: function (data, index, row, meta) {
            return meta.row + meta.settings._iDisplayStart + 1 + ".";
          },
        },
        {
          data: "nama",
        },
        {
          data: "kategori",
        },
        {
          data: "gambar",
          render: function (data, type, row) {
            if (type === "display" && data) {
              return `<img src="{{url('UploadImage')}}/` + data + '" width="150px" height="100px" />';
            } else {
              return data;
            }
          },
        },

        {
          data: "hpp",
          render: function (data) {
            return '<span class="price">' + formatRupiah(data, "Rp. ") + "</span>";
          },
        },
        {
          data: "harga",
          render: function (data) {
            return '<span class="price">' + formatRupiah(data, "Rp. ") + "</span>";
          },
        },
        {
          data: "stok",
        },
      ],
      createdRow: function (row, data, index) {
        $(row).attr("data-value", encodeURIComponent(JSON.stringify(data)));
        $("thead").css({ "vertical-align": "middle", "text-align": "center" });
        $("td", row).css({ "vertical-align": "middle", padding: "0.5em", cursor: "pointer" });
        $("td", row).first().css({ width: "3%", "text-align": "center" });
        //Default
        $("td", row).eq(1).css({ "text-align": "left", "font-weight": "normal" });
        $("td", row).eq(-1).css({ "text-align": "center", width: "9%" });
      },
    })
    .on("click", "tr", function () {
      if ($(this).hasClass("selected")) {
        $("#btn-detail").removeClass("disabled");
        $("#btn-edit").removeClass("disabled");
        $("#btn-delete").removeClass("disabled");
      } else {
        $("#btn-detail").addClass("disabled");
        $("#btn-edit").addClass("disabled");
        $("#btn-delete").addClass("disabled");
      }
    });
}

function resetErrors() {
  $(".form-control").each(function (i, el) {
    $(el).removeClass("brc-danger-m2");
    $(el).next().text("").hide();
    $(el).prev().removeClass("text-danger-d1");
  });
}

function confirmDelete() {
  let swalWithBootstrapButtons = Swal.mixin({
    buttonsStyling: false,
  });

  return swalWithBootstrapButtons.fire({
    title: "Apakah anda yakin?",
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

//fungsi tampil kategori
function dataUntung() {
  $.ajax({
    url: defaultUrl + "datauntung", // Ganti dengan URL aksi yang sesuai
    method: "GET",
    dataType: "json",
    success: function (data) {
      if (data.data && data.data.length > 0) {
        for (var i = 0; i < data.data.length; i++) {
          createUntung(data.data[i]);
        }
      }
    },
    error: function (xhr, status, error) {
      console.error("Error:", error);
      console.error("Status:", status);
      console.error("XHR Response:", xhr.responseText);
    },
  });
  //membuat kartu/card
  function createUntung(data) {
    var untung = $(`<input type="hidden" name="untung" value="${data.margin}">`);

    $("#komposisi").after(untung);
    console.log("DICETAK BOR");
  }
}

//form action

function tambahBahan(datanya) {
  if (datanya != 0 && datanya != "" && datanya != null) {
    console.log("isi datanya" + JSON.stringify(datanya));
    console.log(datanya.bahan);
    var siu = { data: { id: datanya.bahan_id, text: datanya.bahan, jumlah: datanya.jumlah_bahan, harga: datanya.harga_bahan } };
    console.log("data-bahan=" + JSON.stringify(siu));
    var harganya = datanya.harga_bahan / datanya.jumlah_bahan;
    var tr = $("<tr></tr>");
    var tdBahan = $(`<td></td>`);
    var bahan = $(`<select style="width: 100%;" name="bahan[]" class="select2 select2bahan"  required><option value='${datanya.bahan_id}'>${datanya.bahan}</option></select>`); // .select2("trigger", "select", { data: { id: datanya.bahan_id } });
    bahan.attr("data-harga", harganya);
    var tdJumlah = $(`<td></td>`);
    var jumlah = $(`<input style="width: 100%;" type="text"  name="jumlah[]" class="form-control " value="${formatRupiah(datanya.jumlah, datanya.nama_satuan + ": ")}" required>`);
    var tdTotal = $(`<td></td>`);
    var total = $(`<input style="width: 100%;" type="text" class="form-control" id="total" name="total[]" value="${formatRupiah(parseInt(datanya.harga).toString(), "Rp. ")}" disabled>`);
    var aksi = $(`<td><b style=" width: 80%;" id="kurang" class="btn btn-danger"><i class="fas fa-minus"></i></b></td>`);
  } else {
    console.log("tambah bro");
    var tr = $("<tr></tr>");
    var tdBahan = $(`<td></td>`);
    var bahan = $(`<select style="width: 100%;" name="bahan[]" class="select2 select2bahan" required></select>`);
    var tdJumlah = $(`<td></td>`);
    var jumlah = $(`<input style="width: 100%;" type="text" class="form-control" name="jumlah[]" | value="1" required>`);
    var tdTotal = $(`<td></td>`);
    var total = $(`<input style="width: 100%;" type="text" class="form-control" id="total" name="total[]"  disabled>`);
    var aksi = $(`<td><b style=" width: 80%;" id="kurang" class="btn btn-danger"><i class="fas fa-minus"></i></b></td>`);
  }

  //mengambil data option yang dipilih
  bahan.on("change", function () {
    var selectedData = $(this).select2("data")[0];
    bahanHarga = selectedData.harga / selectedData.jumlah;
    nambah = formatRupiah(jumlah.val(), selectedData.nama_satuan + ": ");
    jumlah.val(nambah);
    digunakan = convertToNumber(jumlah.val());
    $(this).attr("data-harga", bahanHarga);
    console.log("DATANYA BRO " + digunakan);
    var dataHasil = bahanHarga * digunakan;
    // console.log('ini hasil' + hasil);
    var formattedHasil = formatRupiah(dataHasil.toString(), "Rp. ");
    console.log("ini format hasil" + formattedHasil);
    total.val(formattedHasil);
    hPP();
  });
  //------------------------------------
  //mengambil data jumlah digunakan
  jumlah.on("input", function () {
    // console.log('henshin');
    nilai = $(this).val();
    var selectedData = bahan.select2("data")[0];
    // console.log(selectedData)
    console.log(formatSatuan(nilai.toString(), selectedData.nama_satuan));
    formattedNilai = formatSatuan(nilai, "gram");
    // if($(this).val() < 1){
    //     alert('Jumlah Tidak Valid');
    //     $(this).val(1);
    //     // salah =1;
    //     // formattedNilai=formatSatuan(salah, 'gram');
    //     // $(this).val(formattedNilai);
    // }
    digunakan = convertToNumber(jumlah.val());
    var dataBahan = bahan.data("harga");
    subtotal = dataBahan * digunakan;
    var formattedSubTotal = formatRupiah(subtotal.toString(), "Rp. ");
    total.val(formattedSubTotal);
    hPP();
    nambah = formatRupiah($(this).val(), selectedData.nama_satuan + ": ");
    $(this).val(nambah);
  });
  //-------------------------------
  //menghapus tr
  aksi.on(`click`, function () {
    tr.remove();
    hPP();
  });
  //--------------------------------

  tdBahan.append(bahan);
  tdJumlah.append(jumlah);
  tdTotal.append(total);
  tr.append(tdBahan);
  tr.append(tdJumlah);
  tr.append(tdTotal);
  tr.append(aksi);
  // Masukkan baris baru setelah baris dengan ID 'komposisi'
  $("#komposisi").append(tr);

  // Inisialisasi Select2 pada elemen yang baru
  hPP();
  select2data();
}

$("#kurang").on("click", function () {
  // console.log('kurang bro');
  var jumlahRow = $("#komposisi").length;
  if (jumlahRow > 1) {
    // Menghapus baris terakhir
    $("#komposisi:last").remove();
  } else {
    alert("Harus Ada Bahan");
  }
});

function hPP() {
  var hpp = 0;
  var keuntungan = parseFloat($(`input[name="untung"]`).val());
  // console.log(keuntungan)
  Array.from($(`form [name="total[]"]`)).forEach(function (el) {
    total = convertToNumber(el.value);
    hpp += total;
  });

  var hargaJual = hpp * keuntungan + hpp;
  // console.log('ini hpp '+ hpp);
  // console.log('ini untng '+ keuntungan);
  // console.log('ini hgj '+ hargaJual);
  formattedHpp = formatRupiah(parseInt(hpp).toString(), "Rp. ");
  formattedHj = formatRupiah(parseInt(hargaJual).toString(), "Rp. ");
  $(`form [name="hpp"]`).val(formattedHpp);
  $(`form [name="hargajual"]`).val(formattedHj);
}

function select2data() {
  $(".select2bahan").select2({
    allowClear: true,
    theme: "bootstrap4",
    width: "auto",
    ajax: {
      url: "{{ url('panel/referensi/getBahan') }}",
      data: function (params) {
        return {
          q: params.term,
          page: params.page || 1,
        };
      },
      processResults: function (response) {
        var data = JSON.parse(response);
        console.log(data);
        return {
          results: data.data.map(function (i) {
            i.id = i.id;
            i.text = i.nama;
            i.jumlah = i.jumlah;
            i.nama_satuan = i.nama_satuan;
            i.harga = i.harga;
            // $('#isinya').text(i.id);
            // console.log(i);
            return i;
          }),
          pagination: {
            more: data.has_more,
          },
        };
      },
    },
  });

  $(".select2kategori").select2({
    allowClear: true,
    theme: "bootstrap4",
    width: "auto",
    ajax: {
      url: "{{ url('panel/referensi/getKategori') }}",
      data: function (params) {
        return {
          q: params.term,
          page: params.page || 1,
        };
      },
      processResults: function (response) {
        var data = JSON.parse(response);
        console.log(data);
        return {
          results: data.data.map(function (i) {
            i.id = i.id;
            i.text = i.nama;

            return i;
          }),
          pagination: {
            more: data.has_more,
          },
        };
      },
    },
  });
}

// function formatsatuan(angka, prefix){
//     number = toString(angka) + ' ' +prefix;
//     return number;
// }
function formatSatuan(angka, satuan) {
  var number_string = angka.toString().replace(/[^,\d]/g, ""),
    split = number_string.split(","),
    sisa = split[0].length % 3,
    hasil = split[0].substr(0, sisa),
    ribuan = split[0].substr(sisa).match(/\d{3}/gi);

  if (ribuan) {
    var separator = sisa ? "." : "";
    hasil += separator + ribuan.join(".");
  }

  hasil = split[1] !== undefined ? hasil + "," + split[1] : hasil;

  if (satuan !== undefined) {
    hasil += " " + satuan;
  }

  return hasil;
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
  return Number(rupiahValue.replace(/[^0-9,-]+/g, ""));
}

// Contoh penggunaan:
// var formattedKembalian = formatRupiah(kembalian.toString(), "Rp. ");
// var kembalianNumber = convertToNumber(formattedKembalian);
// console.log(kembalianNumber); // Output akan berupa nilai numerik dari kembalian dalam rupiah

// <a href="#" class="btn mr-1 btn-warning mb-2 radius-2"id="btn-edit">
// <i class="fa fa-pencil-alt text-140 align-text-bottom mr-2"></i>
// Edit
// </a>
