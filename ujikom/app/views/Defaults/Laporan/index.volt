{% extends 'template/dashboard.volt' %} {% block title %}Laporan Transaksi {% endblock %} {% block content %}
<style>
  .select2-container--bootstrap4 .select2-selection--single {
    height: calc(3em) !important;
  }
  /* CSS */
  .price {
    float: right;
  }
  form table {
    box-sizing: border-box;
  }
</style>

<div class="page-content">
  <div class="col-12 p-0 pl-3 pr-3">
    <div class="card ccard mx-auto" style="width: 98%; position: sticky">
      <div class="card-header pb-1 align-middle" style="border-top-left-radius: 0.4rem; border-top: 4px solid #693f3f; border-top-right-radius: 0.4rem; border-bottom: 1px solid #e0e5e8 !important">
        <h4 class="card-title text-dark-m3 mt-2">Laporan-Transaksi</h4>
        <div class="page-tools mt-3 mt-sm-0 mb-sm-n1 card-toolbar"></div>
      </div>

      <!-- Modal Search -->

      <!-- Modal content-->

      <div class="form-filter w-200 p-2 m-2">
        <form class="form-horizontal w-100" id="form-filter">
          <div class="row">
            <div class="col-6">
              <div class="input-group mb-2 input-filter">
                <div class="input-group-prepend" style="width: 10% !important">
                  <span class="input-group-text">
                    <input type="checkbox" class="ace-switch" />
                  </span>
                </div>
                <div class="input-group-prepend">
                  <span class="input-group-text"> Nama Kasir </span>
                </div>
                <input type="hidden" name="nama_kasir" id="nama_kasir" class="form-control" required />
                <select type="text" id="kasir" name="kasir" class="select2 select2kasir" disabled=""></select>
              </div>
            </div>
            <div class="col-6">
              <div class="input-group mb-2 input-filter">
                <div class="input-group-prepend" style="width: 10% !important">
                  <span class="input-group-text">
                    <input type="checkbox" class="ace-switch" />
                  </span>
                </div>
                <div class="input-group-prepend">
                  <span class="input-group-text"> Transaksi Id </span>
                </div>
                <select type="text" id="transaksi" name="transaksi" class="select2 select2transaksi" disabled=""></select>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-4">
              <div class="input-group mb-2 input-filter">
                <div class="input-group-prepend" style="width: 15% !important">
                  <span class="input-group-text">
                    <input type="checkbox" class="ace-switch" />
                  </span>
                </div>
                <div class="input-group-prepend">
                  <span class="input-group-text"> Pilih Format </span>
                </div>

                <select type="text" id="format" name="format" class="form-control" disabled="true" required>
                  <option value="">-- Pilih Format --</option>
                  <option value="rentang_tanggal">Rentang Tanggal</option>
                  <option value="harian">Harian</option>
                  <option value="bulanan">Bulanan</option>
                  <option value="tahunan">tahunan</option>
                </select>
                <div class="baru"></div>
              </div>
            </div>
            <div class="col-8">
              <div class="format-field" id="format-field"></div>
            </div>
          </div>
        </form>
        <div class="tombol" style="display: flex; justify-content: right; align-items: center">
          <button type="button" class="btn btn-warning text-120 radius-2 mr-2" id="btn-reset">Reset</button>
          <button type="button" class="btn btn-default submit-filter mr-2 text-120 radius-2" data-dismiss="modal">Cari Data</button>
          <a href="#" class="btn btn-danger radius-2 btn-detail text-120" id="btn-pdf">
            <i class="fa fa-file-alt text-110 align-text-bottom mr-2"></i>
            Download
          </a>
        </div>
      </div>

      <!-- <div class="card-body p-3">
        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive-md">
              <table id="datatable" class="table table-bordered border-0 w-100 table-striped-secondary text-dark-m1 mb-0">
                <thead>
                  <tr class="text-white text-center brc-black-tp10" style="background-color: #693f3f">
                    <th style="vertical-align: middle">#</th>
                    <th style="vertical-align: middle">Trans Id</th>
                    <th style="vertical-align: middle">Kode Kasir</th>
                    <th style="vertical-align: middle">Nama Kasir</th>
                    <th style="vertical-align: middle">Total</th>
                    <th style="vertical-align: middle">Voucher</th>
                    <th style="vertical-align: middle">Diskon</th>
                    <th style="vertical-align: middle">Grand Total</th>
                    <th style="vertical-align: middle">Bayar</th>
                    <th style="vertical-align: middle">Kembalian</th>
                  </tr>
                </thead>
                <tbody></tbody>
              </table>
            </div>
          </div>
        </div>
      </div> -->
    </div>
  </div>
</div>

<!-- Modal Form -->
<div id="formModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
  <div class="modal-dialog radius-4">
    <!-- Modal content-->
    <div class="modal-content radius-4">
      <div class="modal-header radius-t-4" style="background-color: #004225">
        <h4 class="modal-title text-white"><i class="fa fa-list text-white"></i>&nbsp;&nbsp; Detail - Transaksi</h4>
        <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
      </div>
      <form class="form-horizontal" enctype="multipart/form-data" action="javascript:;">
        <div class="modal-body">
          <div class="card ccard mx-auto" style="width: 98%; position: sticky">
            <div class="card-header pb-1 align-middle" style="border-top-left-radius: 0.4rem; border-top: 4px solid #004225; border-top-right-radius: 0.4rem; border-bottom: 1px solid #e0e5e8 !important"></div>

            <div class="card-body p-3">
              <div class="row">
                <div class="col-md-12">
                  <div class="table-responsive-md">
                    <table id="datatabledetail" class="table table-bordered border-0 w-100 table-striped-secondary text-dark-m1 mb-0">
                      <thead>
                        <tr class="text-white text-center brc-black-tp10" style="background-color: #004225">
                          <th style="vertical-align: middle">#</th>
                          <th style="vertical-align: middle">Produk</th>
                          <th style="vertical-align: middle">Qty</th>
                          <th style="vertical-align: middle">Harga</th>
                          <th style="vertical-align: middle">Total</th>
                        </tr>
                      </thead>
                      <tbody></tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

{% endblock %} {% block inline_script %}
<script>
  {% include 'Defaults/Laporan/index.js' %}
</script>
{% endblock %}
