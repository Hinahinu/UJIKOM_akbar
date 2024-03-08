{% extends 'template/dashboard.volt' %} {% block title %}Kasir {% endblock %} {% block content %}

<style>
  .cardp {
    max-height: max-content;
  }
  .card-data-img-wrapper {
    /* min-height: 144px; */
    min-height: 116px;
    max-height: 144px;
    box-sizing: border-box;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
  }

  .card-data-img-wrapper img {
    /* margin: 15px;
			padding: 15px; */
    border-radius: 8px;
  }
  .produk-data {
    max-height: 82px;
    min-height: 81px;
  }
  .produk-left img {
    width: 100%;
    /* padding: 10px; */
    /* max-height: 75px; */
  }
  .produk-left {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .select2-container--bootstrap4 .select2-selection--single {
    height: calc(3em) !important;
  }
  /* CSS */
  .price {
    float: right;
  }
  * {
    box-sizing: border-box;
    font-family: "Roboto", Arial, sans-serif;
  }
  .order {
    text-align: center;
    margin: 10px;
  }
  .produk {
    border-radius: 10px;
    cursor: pointer;
  }
  .price {
    color: #693f3f;
    /* color:#f05a59; */
  }
  .kategori {
    border: 2px solid #693f3f;
  }
  .kategori i,
  .kategori b {
    color: #693f3f;
  }
  .img-wrapper img {
    /* max-width: 100%; */
    /* max-height: 100%; */
    max-height: min-content;
  }
  .img-wrapper {
    width: 100%;
    height: 100%;
  }
  .kartu-wrapper {
    margin: 10px;
    padding: 10px;
  }

  .kartu {
    max-width: 342px;
    padding: 10px;
  }
  .kartu-left,
  .kartu-middle,
  .kartu-right {
    max-width: 342px;
    height: 90px;
    padding: 1;
    box-sizing: border-box;
  }
  .produk-data {
    position: relative;
    padding: 10px; /* Sesuaikan sesuai kebutuhan */
  }
  .produk-right {
    padding: 10px;
  }
  .tombolfilter {
    height: 37px;
    width: 90px;
  }
  .tombolsearch {
    height: 35px;
    width: 420px;
  }
  .btn-x {
    position: absolute;
    top: 0;
    right: 0;
    margin: 5px;
    /* background-c	olor: red; Sesuaikan warna sesuai kebutuhan */
    color: white;
    border: none;
    width: 9%;
    padding: 1px;
    cursor: pointer;
  }
  .qty-box .btn {
    font-size: 45%;
    border-radius: 8px; /* Ubah ke nilai yang lebih rendah untuk membuatnya lebih persegi */
    padding: 3px;
  }
  .qty-box i {
    padding: 0;
    margin: 0;
    /* font-size: 50%; */
  }
  .produk-price {
    color: #65451f;
    /* color:#f05a59; */
    margin-top: 15px;
  }
  .qty-box {
    /* background-color: aqua; */
    width: 40%;
    display: flex;
    align-items: center;
    justify-content: center;
    position: absolute;
    margin: 5px;
    right: 0;
    bottom: 10px;
  }
  .harga {
    text-align: right;
  }
  .qty-box input {
    width: 50%;
    border: none;
    background-color: transparent;
    padding: 4px;
    text-align: center;
  }

  .card-field {
    min-height: 580px;
    max-height: 580px;
  }
  .search .left .wadah,
  .search .right button {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .payment table tr input {
    /* border-bottom: 1px solid black; */
    color: #65451f;
  }

  .dipilih {
    background-color: #693f3f;
  }
  .dipilih i,
  .dipilih b {
    color: #faeed1;
  }

  /* scroll bar gpt */
  /* Untuk browser yang mendukung properti scrollbar-width */
  .overflow-auto::-webkit-scrollbar {
    width: 5px; /* Atur lebar scrollbar */
  }

  /* Atur lebar scrollbar untuk browser yang tidak mendukung properti scrollbar-width */
  .overflow-auto {
    scrollbar-width: thin;
  }

  /* Warna latar belakang scrollbar */
  .overflow-auto::-webkit-scrollbar-track {
    background: #fff;
  }

  /* Warna scroll handle atau thumb */
  .overflow-auto::-webkit-scrollbar-thumb {
    background-color: #888;
    border-radius: 10px;
  }

  /* Ketika scroll handle diklik */
  .overflow-auto::-webkit-scrollbar-thumb:hover {
    background-color: #555;
  }
</style>
<div class="container-fluid">
  <div class="row">
    <!-- LEFT BAR -->
    <div class="col-8" style="height: 50px; background-color: #f5f5f5; border-right: solid 1px gray; border-bottom: solid 2px gray">
      <div class="row">
        <div class="left col-6 position-relative p-2 m-0">
          <div class="search tombolsearch row bg-light p-0 m-0" style="border-radius: 8px; background-color: #f8f4ff">
            <div class="left col-1 p-0 m-0" style="background-color: #f8f4ff; border-top-left-radius: 8px; border-bottom-left-radius: 8px">
              <div class="wadah w-100 h-100">
                <h4 class="mt-2"><i class="fas fa-search"></i></h4>
              </div>
            </div>
            <div class="middel col-10 p-0 m-0">
              <input type="text" name="filter" id="filter" class="form-control w-100 h-100" placeholder="Search..." style="border: 0; background: transparent; background-color: #f8f4ff" />
            </div>
            <div class="right col-1 p-0 m-0" style="background-color: #f8f4ff; border-top-right-radius: 8px; border-bottom-right-radius: 8px">
              <button class="btn w-100 h-100" id="bersih">
                <h4><i class="far fa-times-circle"></i></h4>
              </button>
            </div>
          </div>
        </div>
        <div class="right col-6 p-2 ml-1 row">
          <div class="page-kategori overflow-auto col-12 p-0 m-0" style="max-width: 473px">
            <!-- tombol netral filter  -->
            <button id="unfilter" class="btn tombolfilter kategori btn-kategori dipilih radius-2 p-2 mr-1">
              <i class="fa fa-align-justify text-110 align-text-bottom"></i>
              <b>Semua</b>
            </button>
            <!-- CATEGORI DARI AJAX KATEGORI  -->
          </div>
        </div>
        <div class="produk">
          <div id="card-field" class="card-field overflow-auto row p-3 mr-2 mt-1">{# hasil dari ajax cardata disini #}</div>
        </div>
      </div>
    </div>
    <!-- RIGHT BAR -->
    <div class="col-4" style="background-color: #f5f5f5; border-left: 2px solid gray">
      <div class="row">
        <div class="col-12">
          <div class="m-2">
            <div class="row">
              <div class="col-10">
                <h2 class="mt-2"><i class="fas fa-shopping-cart mr-3"></i>KERANJANG</h2>
              </div>
              <div class="batal col-2">
                <button type="reset" id="btn-batal" class="mt-2 btn btn-danger rounded-lg" style="display: flex; justify-content: center; align-items: center; width: 40px; height: 30px">
                  <h2 style="display: flex; justify-content: center; align-items: center"><i class="fas fa-trash" style="color: #faeed1; width: 30px; height: 20px"></i></h2>
                </button>
              </div>
            </div>
            <hr style="background-color: black" />
          </div>
        </div>
      </div>
      <div class="">
        <form action="" id="formForm" class=" ">
          <div id="order" class="overflow-auto" style="min-height: 315px; max-height: 315px"></div>

          <!-- <div class="payment   p-1" style="background-color:#EAC696; border-top: 2px solid #65451F; border-bottom: 2px solid #65451F;"> -->
          <div class="payment p-0 pb-4" style="border-top: 2px solid #65451f">
            <!-- <div class="content border rounded-lg shadow" style="background-color:#ECE3CE;"> -->
            <div class="content border rounded-lg shadow p-1" style="background-color: #f8f4ff">
              <table border="0" class="w-100 table-sm mt-1">
                <tr>
                  <td>
                    <h5><b>Total</b></h5>
                  </td>
                  <td><input type="text" name="total" id="total" value="0" class="w-100 h-100 input harga price" style="border: 0; background: transparent; font-size: 1.25rem; font-weight: bold" disabled required /></td>
                </tr>
                <tr id="voucher">
                  <td>
                    <h5><b>Voucher</b></h5>
                  </td>
                  <td>
                    <input
                      type="text"
                      placeholder="Voucher..."
                      class="w-50 h-100 rounded p-1 input"
                      style="border: 1px solid #65451f; margin-left: 150px; background: transparent; font-weight: bold; font-size: 1.25rem"
                      name="voucher"
                      id="voucher"
                    />
                  </td>
                </tr>
                <input type="hidden" name="diskon" value="0" />
                <input type="hidden" id="potongan" name="potongan" value="0" />
                <input type="hidden" id="kode_voucher" name="kode_voucher" value="0" />

                <tr class="diskon">
                  <td>
                    <h5><b>Diskon</b></h5>
                  </td>
                  <td><input type="text" value="0" id="diskon" class="w-100 h-100 input harga price" style="border: 0; background: transparent; font-size: 1.25rem; font-weight: bold" disabled required /></td>
                </tr>
                <tr>
                  <td>
                    <h5><b>Grand Total</b></h5>
                  </td>
                  <td><input type="text" name="grand_total" id="grand_total" value="0" class="w-100 h-100 input harga price" style="border: 0; background: transparent; font-size: 1.25rem; font-weight: bold" disabled required /></td>
                </tr>
                <tr>
                  <td>
                    <h5><b>Bayar</b></h5>
                  </td>
                  <td>
                    <input
                      type="text"
                      name="tunai"
                      id="tunai"
                      placeholder="Bayar Rp. "
                      class="w-50 h-100 p-1 rounded input harga"
                      style="border: 1px solid; background: transparent; font-size: 1.25rem; font-weight: bold; margin-left: 150px"
                      required
                    />
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5><b>Kembalian</b></h5>
                  </td>
                  <td>
                    <input type="text" name="kembalian" id="kembalian" value="0" class="w-100 h-100 input harga" style="border: 0; background: transparent; font-size: 1.25rem; font-weight: bold" disabled required />
                  </td>
                </tr>
              </table>
              <div class="kirim p-2">
                <button name="submit" id="submit" class="btn rounded-pill" style="width: 100%; background-color: #693f3f; color: #faeed1">
                  <h5>
                    <b><i class="fas fa-print mr-2"></i>Cetak Struk</b>
                  </h5>
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

{# ________________________________________________________________________________________________ #} {% endblock %} {% block inline_script %}
<script>
  {% include 'Defaults/Kasir/index.js' %}
</script>
{% endblock %}
