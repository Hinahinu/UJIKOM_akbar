<?php
//Controller.php
declare(strict_types=1);

namespace App\Modules\Defaults\Master\Produk;

use App\Libraries\Log;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Master\Hakakses\Model as RoleModel;
use Core\Facades\Response;
use App\Modules\Defaults\Middleware\Controller as MiddlewareHardController;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;
use App\Modules\Defaults\Master\Produk\ProdukModel as ProdukModel;
use App\Modules\Defaults\Master\Produk\ProDetailModel as ProDetailModel;

/**
 * @routeGroup("/master/produk")
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

    /**
     * @routeGet("/strukPdf")
     * @routePost("/strukPdf")
     */
    public function strukPdfAction($id)
    {
        $var = "Ramdani";
        $this->view->setVar('data-nama', $var);
    }







    /**
     * @routeGet("/datatable")
     * @routePost("/datatable")
     */
    public function datatableAction()
    {
        // var_dump(Request::getPost());exit;
        $pdam_id = $this->session->user['pdam_id'];
        $search_nama = Request::getPost('search_nama');
        $search_kode = Request::getPost('search_kode');
        $kategori_id_search = Request::getPost('kategori_id_search');
        $barang_kategori_id_id = Request::getPost('barang_kategori_id_id');
        $nama_barang = Request::getPost('nama_barang');

        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(VwModel::class)
            ->where("1=1")
            ->andWhere("pdam_id = '$pdam_id'");

        if ($nama_barang) {
            $builder->andWhere("nama LIKE '%$nama_barang%'");
        }
        if ($search_nama) {
            $builder->andWhere("nama LIKE '%$search_nama%'");
        }
        if ($search_kode) {
            $builder->andWhere("kode = '$search_kode'");
        }

        if ($kategori_id_search) {
            $builder->andWhere("kategori_id = '$kategori_id_search'");
        }
        if ($barang_kategori_id_id) {
            $builder->andWhere("id_kategori = '$barang_kategori_id_id   '");
        }



        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }

    /**
     * @routeGet("/detail")
     */
    public function detailAction()
    {
    }

    /**
     * @routePost("/store")
     */
    public function storeAction()
    {
        try {
            $pdam_id = $this->session->user['pdam_id'];

            // Ambil data dari request
            $nama = Request::getPost('nama');
            $kategori = Request::getPost('kategori');
            $hpp = Request::getPost('hpp');
            $stok = Request::getPost('stok');
            $harga_jual = Request::getPost('harga_jual');
            $bahan_data = Request::getPost('bahan_data');
            $bahan_data = json_decode($bahan_data, true); // Dekode data JSON menjadi array asosiatif

            

            function convertToNumber($rupiahValue) {
                return (float) preg_replace('/[^0-9,-]/', '', $rupiahValue);
            }

            // Contoh penggunaan:
            $formattedHpp = convertToNumber($hpp);
            $formattedHargaJual = convertToNumber($harga_jual);
            // $formattedHargaJual = convertToNumber($total);

            // var_dump($bahan_data);
            // die;
            $this->db->begin();

            if ($this->request->hasFiles() && $file = $this->request->getUploadedFiles()[0]) {
                $target_dir = "UploadImage/";
                if (!file_exists($target_dir)) {
                    mkdir($target_dir, 0777, true);
                }

                $allowedExtensions = ['jpg', 'png', 'webp', 'jpeg'];
                $ext = strtolower(pathinfo($file->getName(), PATHINFO_EXTENSION));

                if (in_array($ext, $allowedExtensions)) {
                    $name = md5(strval(rand())) . '.' . $ext;
                    $target_file = $target_dir . $name;
                    if ($file->moveTo($target_file)) {
                        $gambar = $name;
                        echo "File berhasil diunggah.";
                    } else {
                        echo "Gagal mengunggah file.";
                    }
                } else {
                    echo "Hanya file dengan ekstensi .jpg dan .png yang diperbolehkan.";
                }
            }

            // Simpan data ke tabel ProdukModel
            $produk = new ProdukModel();
            $produk->kategori_id = $kategori;
            $produk->nama = $nama;
            $produk->stok = $stok;
            if (isset($gambar) && !empty($gambar)) {
                $produk->gambar = $gambar;
            }
            $produk->hpp = $formattedHpp;
            $produk->harga_jual = $formattedHargaJual;
            $produk->pdam_id = $pdam_id;





            $produk->save();

            $produk_id = $produk->id;

            // Simpan data ke tabel ProDetailModel
            foreach ($bahan_data as $bahan) {
                $produkDetail = new ProDetailModel();
                $produkDetail->produk_id = $produk_id;
                $produkDetail->bahan_id = $bahan['bahan'];
                $produkDetail->jumlah = $bahan['jumlah'];
                $produkDetail->stok = $bahan['stok'];
                $produkDetail->harga = convertToNumber($bahan['total']);
                $produkDetail->pdam_id = $pdam_id;
                $produkDetail->save();
            }

            $this->db->commit();

            return Response::setJsonContent([
                'message' => 'Data Terkirim',
                'produk_id' => $produk_id,
            ]);
        } catch (\Exception $e) {
            // Rollback transaksi jika terjadi kesalahan
            $this->db->rollback();

            return Response::setJsonContent([
                'error' => 'Gagal menyimpan data: ' . $e->getMessage(),
            ]);
        }
    }


    //     public function storeAction()
    // {
    //     if ($this->request->isPost()) {
    //         $pdam_id = $this->session->user['pdam_id'];

    //         $input_harga = $this->request->getPost('harga_sewa');

    //         $harga_hanya_angka = preg_replace("/[^0-9]/", "", $input_harga);

    //         echo $harga_hanya_angka; 

    //         $data = [
    //             'merk' => $this->request->getPost('merk'),
    //             'jenis'       => $this->request->getPost('jenis'),
    //             'jumlah_kursi'      => $this->request->getPost('jumlah_kursi'),
    //             'cc'      => $this->request->getPost('cc'),
    //             'harga_sewa'     => $harga_hanya_angka,
    //             'gambar'     => '',
    //             'pdam_id'    => $pdam_id
    //         ];
    //         // var_dump($data);exit;

    //         if ($this->request->hasFiles() && $file = $this->request->getUploadedFiles()[0]) {
    //             $target_dir = "UploadImage/";
    //             if (!file_exists($target_dir)) {
    //                 mkdir($target_dir, 0777, true);
    //             }

    //             $allowedExtensions = ['jpg', 'png', 'webp', 'jpeg'];
    //             $ext = strtolower(pathinfo($file->getName(), PATHINFO_EXTENSION));

    //             if (in_array($ext, $allowedExtensions)) {
    //                 $name = md5(strval(rand())) . '.' . $ext;
    //                 $target_file = $target_dir . $name;
    //                 if ($file->moveTo($target_file)) {
    //                     $data['gambar'] = $name;
    //                     echo "File berhasil diunggah.";
    //                 } else {
    //                     echo "Gagal mengunggah file.";
    //                 }
    //             } else {
    //                 echo "Hanya file dengan ekstensi .jpg dan .png yang diperbolehkan.";
    //             }
    //         }

    //         $create = new Model($data);
    //         $result = $create->save();

    //         $log = new Log();
    //         $log->write("Insert Data Master-Referensi Barang-Satuan", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Satuan\Controller", "INSERT");

    //         return Response::setJsonContent([
    //             'message' => 'Success',
    //         ]);
    //     }
    // }




    /**
     * @routePost("/update")
     */
    public function updateAction()
    {
        // try {

            $id = Request::getPost('id');

            $pdam_id = $this->session->user['pdam_id'];

            // Ambil data dari request
            $nama = Request::getPost('nama');
            $kategori = Request::getPost('kategori');
            $hpp = Request::getPost('hpp');
            $harga_jual = Request::getPost('hargajual');
            $bahan_data = Request::getPost('bahan_data');
            $stok = Request::getPost('stok');
            $bahan_data = json_decode($bahan_data, true); // Dekode data JSON menjadi array asosiatif
            $rupiahValue = "Rp. 5.000,00";

            // Menghilangkan karakter non-numeric kecuali koma dan minus
            function convertToNumber($rupiahValue) {
                return (float) preg_replace('/[^0-9,-]/', '', $rupiahValue);
            }
            // var_dump($bahan_data);
            // die;
            if ($this->request->hasFiles() && $file = $this->request->getUploadedFiles()[0]) {
                $target_dir = "UploadImage/";
                if (!file_exists($target_dir)) {
                    mkdir($target_dir, 0777, true);
                }

                $allowedExtensions = ['jpg', 'png', 'webp', 'jpeg'];
                $ext = strtolower(pathinfo($file->getName(), PATHINFO_EXTENSION));

                if (in_array($ext, $allowedExtensions)) {
                    $name = md5(strval(rand())) . '.' . $ext;
                    $target_file = $target_dir . $name;
                    if ($file->moveTo($target_file)) {
                        $gambar = $name;
                        echo "File berhasil diunggah.";
                    } else {
                        echo "Gagal mengunggah file.";
                    }
                } else {
                    echo "Hanya file dengan ekstensi .jpg dan .png yang diperbolehkan.";
                }
            }
            // $this->db->begin();
            
            // Simpan data ke tabel ProdukModel
            $produk = ProdukModel::findFirst([
                'conditions' => 'id = :id:',
                'bind' => ['id' => $id], // Sesuaikan dengan nilai yang sesuai
            ]);
            // $produk->id = $id;
            $produk->kategori_id = $kategori;
            $produk->nama = $nama;
            $produk->stok = $stok;
            $produk->hpp = convertToNumber($hpp);
            if (isset($gambar) && !empty($gambar)) {
                $produk->gambar = $gambar;
            }
            $produk->harga_jual = convertToNumber($harga_jual);
            $produk->pdam_id = $pdam_id;

            $produk->save();



            // Simpan data ke tabel ProDetailModel
            // Simpan data ke tabel ProDetailModel
            foreach ($bahan_data as $bahan) {
                $produkDetail = ProDetailModel::findFirst([
                    'conditions' => 'produk_id = :produk_id: AND bahan_id = :bahan_id:',
                    'bind' => [
                        'produk_id' => $id,
                        'bahan_id' => $bahan['bahan']
                    ],
                ]);

                if ($produkDetail) {
                    // Jika entri sudah ada, lakukan update
                    $produkDetail->jumlah = $bahan['jumlah'];
                    $produkDetail->harga = convertToNumber($bahan['total']);
                    $produkDetail->pdam_id = $pdam_id;
                    $produkDetail->save();
                } else {
                    // Jika entri belum ada, buat entri baru
                    $newProdukDetail = new ProDetailModel();
                    $newProdukDetail->produk_id = $id;
                    $newProdukDetail->bahan_id = $bahan['bahan'];
                    $newProdukDetail->jumlah = $bahan['jumlah'];
                    $newProdukDetail->harga = convertToNumber($bahan['total']);
                    $newProdukDetail->pdam_id = $pdam_id;
                    $newProdukDetail->save();
                }
            }


            // $this->db->commit();

            return Response::setJsonContent([
                'message' => 'Data Terkirim',
                'produk_id' => $id,
            ]);
        // } catch (\Exception $e) {
        //     // Rollback transaksi jika terjadi kesalahan
        //     $this->db->rollback();

        //     return Response::setJsonContent([
        //         'error' => 'Gagal menyimpan data: ' . $e->getMessage(),
        //     ]);
        // }
    }
    /**
     * @routePost("/stok")
     */
    public function stokAction()
    {
        // try {

            $id = Request::getPost('id');

            $pdam_id = $this->session->user['pdam_id'];

            // Ambil data dari request
            
            $stok = Request::getPost('stok');

            // Menghilangkan karakter non-numeric kecuali koma dan minus
            
            
            // $this->db->begin();
            
            // Simpan data ke tabel ProdukModel
            $produk = ProdukModel::findFirst([
                'conditions' => 'id = :id:',
                'bind' => ['id' => $id], // Sesuaikan dengan nilai yang sesuai
            ]);
            $produk->stok = $stok;
            $produk->pdam_id = $pdam_id;

            $produk->save();

            return Response::setJsonContent([
                'message' => 'Data Terkirim',
                'produk_id' => $id,
            ]);
        // } catch (\Exception $e) {
        //     // Rollback transaksi jika terjadi kesalahan
        //     $this->db->rollback();

        //     return Response::setJsonContent([
        //         'error' => 'Gagal menyimpan data: ' . $e->getMessage(),
        //     ]);
        // }
    }

    /**
     * @routePost("/delete")
     */
    public function deleteAction()
    {
        $id = Request::get('id');
        $data = [
            'id'            => Request::get('id')
        ];
        $delete = ProdukModel::findFirst($id);

        $result = $delete->delete();

        $log = new Log();
        $log->write("Delete Data Master-Referensi Barang-Barang", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Barang\Controller", "DELETE");

        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }


    /**
     * @routeGet("/databahan")
     * @routePost("/databahan")
     */
    public function databahanAction()
    {
        $pdam_id = $this->session->user['pdam_id'];
        $id_produk = $this->request->getPost("id"); // Ambil diFilter dari permintaan POST
        // $newFilter = $this->request->getPost("newFilter"); // Ambil newFilter dari permintaan POST

        $builder = $this->modelsManager->createBuilder()
            ->columns('*')
            ->from(VwDetailModel::class)
            ->where("1=1")
            ->andWhere("produk_id = '$id_produk' and pdam_id = '$pdam_id'");


        $result = $builder->getQuery()->execute();

        $jsonResult = [
            'message' => 'Aksi datacardAction berhasil dipanggil.',
            'data' => $result->toArray(),
        ];

        return $this->response->setJsonContent($jsonResult);
    }


    // 
    // public function updateAction()
    // {
    //     $id = Request::getPost('id');

    //     $data = [
    //         'nama'          => Request::getPost('nama'),
    //         'updated_at' => date('Y-m-d H:i:s')
    //     ];
    //     $update = Model::findFirst($id);
    //     $update->assign($data);

    //     $result = $update->save();

    //     $log = new Log(); 
    //     $log->write("Update Data Master-Referensi Barang-Satuan", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Satuan\Controller", "UPDATE");

    //     return Response::setJsonContent([
    //         'message' => 'Success',
    //     ]);
    // }

}
