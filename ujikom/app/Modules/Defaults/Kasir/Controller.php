<?php
//Controller.php
declare(strict_types=1);

namespace App\Modules\Defaults\Kasir;

use App\Libraries\Log;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Master\Hakakses\Model as RoleModel;
use Core\Facades\Response;
use App\Modules\Defaults\Middleware\Controller as MiddlewareHardController;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;
use App\Modules\Defaults\Kasir\Model as Model;
use App\Modules\Defaults\Kasir\TransaksiModel as TransaksiModel;
use App\Modules\Defaults\Kasir\TransaksiDetailModel as TransaksiDetailModel;

/**
 * @routeGroup("/kasir")
 */
class Controller extends BaseController
{
    /**
     * @routeGet("/")
     */
    public function indexAction($id)
    {
        
        $this->view->setVar('module', $id);
    }



    //controller.php
    /**
     * @routeGet("/datakategori")
     * @routePost("/datakategori")
     */
    public function datakategoriAction()
    {
        $pdam_id = $this->session->user['pdam_id'];


        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(KategoriModel::class)
            ->where("1=1")
            ->andWhere("pdam_id = '$pdam_id'");

        $result = $builder->getQuery()->execute();

        $jsonResult = [
            'message' => 'Aksi DATA KATEGORI berhasil dipanggil.',
            'data' => $result->toArray(),
        ];

        return $this->response->setJsonContent($jsonResult);
    }


    /**
     * @routeGet("/datavoucher")
     * @routePost("/datavoucher")
     */
    public function datavoucherAction()
    {
        $pdam_id = $this->session->user['pdam_id'];
        $voucher_kode = $this->request->getPost("kodeVoucher"); // Ambil diFilter dari permintaan POST
        // $newFilter = $this->request->getPost("newFilter"); // Ambil newFilter dari permintaan POST

        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(VoucherModel::class)
            ->where("1=1")
            ->andWhere("kode = '$voucher_kode' and pdam_id = '$pdam_id'");

        // if ($newFilter) {
        //     $builder->andWhere("nama LIKE '%$newFilter%'");
        // }

        $result = $builder->getQuery()->execute();

        $jsonResult = [
            'message' => 'Aksi datacardAction berhasil dipanggil.',
            'data' => $result->toArray(),
        ];

        return $this->response->setJsonContent($jsonResult);
    }

    /**
     * @routeGet("/datacard")
     * @routePost("/datacard")
     */
    public function datacardAction()
    {
        $pdam_id = $this->session->user['pdam_id'];
        $diFilter = $this->request->getPost("diFilter"); // Ambil diFilter dari permintaan POST
        $newFilter = $this->request->getPost("newFilter"); // Ambil newFilter dari permintaan POST

        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(VwModel::class)
            ->where("1=1")
            ->andWhere("pdam_id = '$pdam_id'");

        if ($diFilter) {
            $builder->andWhere("kategori LIKE '%$diFilter%'");
        }
        if ($newFilter) {
            $builder->andWhere("nama LIKE '%$newFilter%'");
        }

        $result = $builder->getQuery()->execute();

        $jsonResult = [
            'message' => 'Aksi datacardAction berhasil dipanggil.',
            'data' => $result->toArray(),
        ];

        return $this->response->setJsonContent($jsonResult);
    }


    /**
     * @routePost("/store")
     */
    public function storeAction()
    {
        // Ambil data dari permintaan POST
        $nama = $this->session->user['nama'];
        $kasir = $this->session->user['kasir_kode'];
        $voucher_kode = Request::getPost('voucher_kode');
        $voucher_diskon = Request::getPost('diskon');
        $voucher_potongan = Request::getPost('potongan');
        $produk_data = Request::getPost('produk_data'); // Harus berisi array data produk
        $total = Request::getPost('total');
        $grand_total = Request::getPost('grand_total');
        $bayar = Request::getPost('bayar');
        $kembalian = Request::getPost('kembalian');

            function convertToNumber($rupiahValue) {
                return (float) preg_replace('/[^0-9,-]/', '', $rupiahValue);
            }

            // Contoh penggunaan:
            $formattedTotal = convertToNumber($total);
            $formattedBayar = convertToNumber($bayar);
            $formattedKembalian = convertToNumber($kembalian);
            $formattedGrand = convertToNumber($grand_total);
           


        $allData = [
            'nama' => $nama,
            'kode' => $kasir,
            'produk_data' => $produk_data,
            'kode_voucher' => $voucher_kode,
            'diskon_voucher' => $voucher_diskon,
            'potongan_voucher' => $voucher_potongan,
            'total' => $total,
            'grand_total' => $grand_total,
            'tunai' => $bayar,
            'kembali' => $kembalian,

        ];

        $this->db->begin();
        // Simpan data ke tabel 'transaksi'
        $transaksi = new TransaksiModel();
        $transaksi->kode_kasir = $kasir;
        $transaksi->total = $formattedTotal;
        $transaksi->voucher_kode = $voucher_kode;
        $transaksi->grand_total = $formattedGrand;
        $transaksi->bayar = $formattedBayar;
        $transaksi->kembalian = $formattedKembalian;
        $transaksi->created_at = date('Y-m-d H:i:s');
        $transaksi->save();

        // Ambil ID yang baru saja disimpan
        $transaksi_id = $transaksi->id;
        $transaksi_tanggal = $transaksi->created_at;

        // Simpan data ke tabel 'transaksi_detail'
        foreach ($produk_data as $produk) {
            $transaksiDetail = new TransaksiDetailModel();
            $transaksiDetail->transaksi_id = $transaksi_id;
            $transaksiDetail->produk_id = $produk['id'];
            $transaksiDetail->qty = $produk['qty'];
            $transaksiDetail->sub_total = $produk['subtotal'];
            $transaksiDetail->save();
        }

        $this->db->commit();

        $allData['transaksi_id'] = $transaksi_id;
        $allData['transaksi_tanggal'] = $transaksi_tanggal;
        return Response::setJsonContent([
            'message' => 'Data berhasil disimpan.',
            'struk' => $allData, // Anda dapat menambahkan informasi lain yang Anda butuhkan
        ]);
    }

    /**
     * @routeGet("/strukPdf")
     */
    public function strukPdfAction()
    {
        $struk = request::get('struk');
        // $tanggal = request::get('transaksi_tanggal');
        // $nama = request::get('nama');
        // $kode = request::get('kode');
        // $produk = request::get('produk_data'); //berisi array
        // $kode_voucher = request::get('kode_voucher');
        // $diskon_voucher = request::get('diskon_voucher');
        // $potongan = request::get('potongan_voucher');
        // $total = request::get('total');
        // $tunai = request::get('tunai');
        // $kembali = request::get('kembali');
        // $var = "Ramdani"; 
        // $data = ;

        $this->view->setVar('struk', $struk);
        // return Response::setJsonContent([
        //     'message' => 'Data berhasil disimpan.',
        //     'struk' => $struk, // Anda dapat menambahkan informasi lain yang Anda butuhkan
        // ]);
    }

}
