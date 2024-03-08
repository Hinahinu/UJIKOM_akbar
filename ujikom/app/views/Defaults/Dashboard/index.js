window.defaultUrl = `${baseUrl}dashboard/`;
var table;
var tableDetail;
var order = 1;
$(document).ready(function () {
    let modal = $('#formModal');
    

viewDatatable();
pendapatan();




// $("")

$.get(defaultUrl + "voucherAktif", function (data) {
    $("#voucher").text(data);
  });

$.get(defaultUrl + "transaksiBulanan", function (data) {
    $("#transaksi").text(data);
  });

$.get(defaultUrl + "pendapatanBulanan", function (data) {
    if(data != 0 != '' !=null ){
        $("#pendapatan").text(formatRupiah(data, "Rp. "));
    }else{
        console.log('ini yang jalan')
        $("#pendapatan").text('Rp. 0');
    }
  });

$.get(defaultUrl + "transaksiHarian", function (data) {
    $("#trans_harian").text(data);
  });
  
$.get(defaultUrl + "pendapatanHarian", function (data) {
    if(data  != 0 != '' !=null){
        
        $("#pendapatan_harian").text(formatRupiah(data, "Rp. "));
    }else{
        
        $("#pendapatan_harian").text('Rp. 0');
    }
  });


var tp = <?= json_encode($total_pendapatan) ?>;
var bp = <?= json_encode($bulan_pendapatan) ?>;
var pr = <?= json_encode($produk_dibeli) ?>;
var totalTahunBulan = <?= json_encode($bulanTahun) ?>;

var tahunBulan = totalTahunBulan.map(item => item.nama_bulan);
var noBulan = totalTahunBulan.map(item => item.bulan);
var pendapatanBulan = totalTahunBulan.map(item => parseInt(item.total));




console.log('SATU '+ tahunBulan);
console.log('DUA '+ noBulan);
console.log('TIGA '+ pendapatanBulan);

console.log('PENDAPATAN: '+ JSON.stringify(totalTahunBulan));
console.log('PENDAPATAN object : '+ totalTahunBulan);
console.log('AHAHA'+ JSON.stringify(tp));
console.log('AHIIHI'+ JSON.stringify(bp));

var bulanPendapatan = bp.map(item => item.bulan);
var totalValues = tp.map(item => parseInt(item.total));
var produk = JSON.stringify(pr);
console.log('ini data produk' + produk);
// Ubah struktur data yang dimiliki ke dalam format yang diharapkan oleh Highcharts
var newData = pr.map(item => {
    return {
        name: item.produk,
        y: parseFloat(item.qty)
    };
});
console.log(newData);
// var bulanValues1 = bulan1.map(item => item.bulan);
// var totalValues1 = total1.map(item => parseInt(item.nik));



Highcharts.chart('container', {
    title: {
        text: null,
        align: 'left'
    },
    // subtitle: {
    //     text: 'Source: ',
    //     align: 'left'
    // },
    yAxis: {
        title: {
            text: null
        }
    },
    xAxis: {
        accessibility: {
            rangeDescription: 'Month'
        },
        categories: tahunBulan
        // categories: ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember']

    },
    legend: {
        
        layout: 'horizontal',
        align: 'center',
        verticalAlign: 'bottom'
    },
    plotOptions: {
        series: {
            label: {
                connectorAllowed: false
            }, 
            pointStart: 0
            // pointStart: noBulan[0]
        }
    },
    series: [{
        name: 'Pendapatan',
        data: pendapatanBulan
    }],
    responsive: {
        rules: [{
            condition: {
                maxWidth: 300
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }
});




Highcharts.chart('container-pie', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: null,
        align: 'left'
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    accessibility: {
        point: {
            valueSuffix: '%'
        }
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: false
            },
            showInLegend: true
        }
    },
    series: [{
        name: 'Brands',
        colorByPoint: true,
        data: newData,
    }]
});


});


function viewDatatable(){
    table = $("#datatable").DataTable({
        ajax: {
            url: defaultUrl + "datatable",
            "type": "post",
			"data": function (d) {
				var formData = $("#form-filter").serializeArray();
                $.each(formData, function (key, val) {
					d[val.name] = val.value;
				});
			}
        },
        serverSide: true,
        processing: true,
        responsive: true,
        selected: false,
        aaSorting: [],
        columnDefs: [{
            searchable: false,
            targets: [0]
        }],
        columns: [{
                data: 'id',
                orderable: false,
                render: function(data, index, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1 + ".";
                },
            },
            {
                data: 'id'
            },
            {
                data: 'kode_kasir'
            },
            
            {
                data: 'nama_kasir'
            },
            {
                data: 'total',
                render: function(data){
                    return '<span class="price">' + formatRupiah(data, "Rp. ") + '</span>';
                }
            }, 
            {
                data: 'voucher_kode'
            },
            {
                data: "diskon",
                render: function (data) {
                    if (data !== null && data !== "" && parseFloat(data) !== 0) {
                    diskon = parseFloat(data) * 100;
                    return '<span class="price">' + diskon + "%" + "</span>";
                    } else {
                    return "";
                    }
                },
            },
            {
                data: 'grand_total',
                render: function(data){
                    return '<span class="price">' + formatRupiah(data, "Rp. ") + '</span>';
                }
            }, 
            
            {
                data: 'bayar',
                render: function(data){
                    return '<span class="price">' + formatRupiah(data, "Rp. ") + '</span>';
                }
            }, 
            {
                data: 'kembalian',
                render: function(data){
                    return '<span class="price">' + formatRupiah(data, "Rp. ") + '</span>';
                }
            },
            
        ],
            "createdRow": function (row, data, index) {
                $(row).attr('data-value', encodeURIComponent(JSON.stringify(data)));
                $("thead").css({ "vertical-align": "middle", "text-align": "center", });
                $("td", row).css({ "vertical-align": "middle", padding: "0.5em", 'cursor': 'pointer' });
                $("td", row).first().css({ width: "3%", "text-align": "center", });
                //Default
                $('td', row).eq(1).css({ 'text-align': 'left', 'font-weight': 'normal' });
                 $('td', row).eq(-1).css({ 'text-align': 'center', width: "9%" });
                
                
            }

    }).on( 'click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$('#btn-detail').removeClass("disabled");
			$('#btn-delete').removeClass("disabled");
		} else {
			$('#btn-detail').addClass("disabled");
			$('#btn-delete').addClass("disabled");
        }
	});

}


function viewDatatableDetail(datanya){
    tableDetail;
    tableDetail = $("#datatabledetail").DataTable({
        ajax: {
            url: defaultUrl + "datatabledetail",
            "type": "post",
			"data": {
                id : datanya,
            }
        },
        serverSide: true,
        processing: true,
        responsive: true,
        selected: false,
        aaSorting: [],
        columnDefs: [{
            searchable: false,
            targets: [0]
        }],
        columns: [{
            data: 'id',
            orderable: false,
            render: function(data, index, row, meta) {
                return meta.row + meta.settings._iDisplayStart + 1 + ".";
            },
        },
            {
                data: 'nama_produk'
            },
            
            {
                data: 'qty'
            },
             
            {
                data: 'harga',
                render: function(data){
                    return '<span class="price">' + formatRupiah(data, "Rp. ") + '</span>';
                }
            }, 
            {
                data: 'sub_total',
                render: function(data){
                    return '<span class="price">' + formatRupiah(data, "Rp. ") + '</span>';
                }
            },
            
        ],
            "createdRow": function (row, data, index) {
                $(row).attr('data-value', encodeURIComponent(JSON.stringify(data)));
                $("thead").css({ "vertical-align": "middle", "text-align": "center", });
                $("td", row).css({ "vertical-align": "middle", padding: "0.5em", 'cursor': 'pointer' });
                $("td", row).first().css({ width: "3%", "text-align": "center", });
                //Default
                $('td', row).eq(1).css({ 'text-align': 'left', 'font-weight': 'normal' });
                
                
                
            }

    });

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
    element.addEventListener("keyup", function (e) {
      element.value = formatRupiah(this.value, "Rp. ");
    });
  });

function convertRupiah(){
    rupiahFields.forEach(function (field) {
      var element = document.getElementById(field);
      element.value = formatRupiah(element.value, "Rp. ");
    });
}


function pendapatan(){
    var tahun = <?= json_encode($tahun); ?>;
    console.log('ini tahun' + tahun)
    $(`#pendapatan-tahun`).text(`pendapatan - ` + tahun )
}