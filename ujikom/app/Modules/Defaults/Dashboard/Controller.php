<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Dashboard;

use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Master\Hakakses\Model as RoleModel;
use Core\Facades\Response;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;
use App\Modules\Defaults\Middleware\Controller as MiddlewareHardController;

/**
 * @routeGroup("/dashboard")
 */
class Controller extends MiddlewareHardController
{
    /**
     * @routeGet("/")
     */
    public function indexAction($id)
    {
        $nama = $this->session->user['nama'];
        $this->view->setVar('user', $nama );
        $tahun = date('Y');
        $this->view->tahun = $this->session->user['tahun'];
        
        $this->view->setVar('module', $id);
        // $this->view->setVar('tahun', $tahun);
        $total_pendapatan = TransaksiModel::query()
            ->columns(['MONTH(created_at) as bulan', 'SUM(total) as total'])
            ->groupBy('bulan')
            ->execute()
            ->toArray();

            $totalPendapatanTahunan = TransaksiModel::query()
            ->columns(['YEAR(created_at) as tahun', 'MONTH(created_at) as bulan', 'MONTHNAME(created_at) as nama_bulan', 'SUM(total) as total'])
            ->where('YEAR(created_at) = YEAR(curdate())')
            ->groupBy('tahun, bulan, nama_bulan')
            ->orderBy('bulan')
            ->execute()
            ->toArray();
        

        $bulan = TransaksiModel::query()
            ->distinct(true)
            ->columns(['MONTHNAME(created_at) as  bulan'])
            ->groupBy('bulan')
            ->execute()
            ->toArray();
        $produk_dibeli = VwModel::query()
            ->distinct(true)
            ->columns(['nama_produk as produk', 'sum(qty) as qty'])
            ->groupBy('produk')
            ->execute()
            ->toArray();

        $produk = VwModel::query()
            ->distinct(true)
            ->columns(['nama_produk as produk'])
            ->groupBy('produk')
            ->execute()
            ->toArray();

            // var_dump($produk);
            // die;
            // $voucher = VoucherModel::query()
            // ->columns(['COUNT(*) as total_aktif'])
            // ->where("status = 'Aktif' ")
            // ->execute()
            // ->toArray();
        


        $this->view->setVars([
            'total_pendapatan' => $total_pendapatan,
            'bulan_pendapatan' => $bulan,
            'produk' => $produk,
            'produk_dibeli' => $produk_dibeli,
            'bulanTahun'=>$totalPendapatanTahunan,
            'tahun' => $tahun,
        ]);
    }

    
    /**
     * @routeGet("/datatable")
     * @routePost("/datatable")
     */
    public function datatableAction()
    {
        // var_dump(Request::getPost());exit;
        $pdam_id = $this->session->user['pdam_id'];
        
        $builder = $this->modelsManager->createBuilder()
                        ->columns('*')
                        ->from(VwTransaksiModel::class)
                        ->where("1=1")
                        ->andWhere("DATE(created_at) = CURDATE() and pdam_id = '$pdam_id'");


        
        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();

        // var_dump($dataTables);
        // die;
        
        
    }
    /**
     * @routeGet("/voucherAktif")
     */
    public function getJumlahTersediaAction()
    {
        $this->view->disable();
        $tanggal = date('Y-m-d');
        $select = "SELECT COUNT(*) AS rowcount FROM vw_voucher WHERE status COLLATE utf8mb4_general_ci = 'Aktif' COLLATE utf8mb4_general_ci;";
        $result = $this->db->fetchAll($select);
    
        if (!empty($result)) {
            // Mengakses nilai 'rowcount' dari hasil fetchAll
            $jumlahTersedia = $result[0]['rowcount'];
            echo $jumlahTersedia;
        } else {
            echo "Data tidak ditemukan";
        }
    }
    

/**
     * @routeGet("/transaksiHari")
     */
    public function getJumlahTransaksiHariAction()
{
    $this->view->disable();
    
        $select = "SELECT COUNT(*) AS rowcount FROM transaksi WHERE date(created_at) = CURDATE();";
        $result = $this->db->fetchAll($select);
    
        if (!empty($result)) {
            // Mengakses nilai 'rowcount' dari hasil fetchAll
            $jumlahTersedia = $result[0]['rowcount'];
            echo $jumlahTersedia;
        } else {
            echo "Data tidak ditemukan";
        }
}

/**
     * @routeGet("/pendapatanBulanan")
     */
    public function getPendapatanBulananAction()
{
    $this->view->disable();
    
        $select = "SELECT 
        SUM(total) AS total  
    FROM 
        transaksi 
    WHERE 
        MONTH(created_at) = MONTH(CURDATE()) AND YEAR(created_at) = YEAR(CURDATE())
    GROUP BY 
        YEAR(created_at),
        MONTH(created_at);
    ";
        $result = $this->db->fetchAll($select);
    
        if (!empty($result)) {
            // Mengakses nilai 'rowcount' dari hasil fetchAll
            $jumlahTersedia = $result[0]['total'];
            echo $jumlahTersedia;
            
        } else {
            echo "Data tidak ditemukan";
        }
}

/**
     * @routeGet("/pendapatanHarian")
     */
    public function getPendapatanHarianAction()
{
    $this->view->disable();
    
        $select = "SELECT 
        
        SUM(total) AS total  
    FROM 
        transaksi 
    WHERE 
        DATE(created_at) = DATE(CURDATE())
    GROUP BY 
        DATE(created_at);
    ";
        $result = $this->db->fetchAll($select);
    
        if (!empty($result)) {
            // Mengakses nilai 'rowcount' dari hasil fetchAll
            $jumlahTersedia = $result[0]['total'];
            echo $jumlahTersedia;
            
        } else {
            echo "Data tidak ditemukan";
        }
}

/**
     * @routeGet("/transaksiBulanan")
     */
    public function getTransaksiBulananAction()
{
    $this->view->disable();
    
        $select = "SELECT COUNT(*) AS total FROM transaksi WHERE month(created_at) = month(CURDATE());";
        $result = $this->db->fetchAll($select);
    
        if (!empty($result)) {
            // Mengakses nilai 'rowcount' dari hasil fetchAll
            $jumlahTersedia = $result[0]['total'];
            echo $jumlahTersedia;
        } else {
            echo "Data tidak ditemukan";
        }
}

/**
     * @routeGet("/transaksiHarian")
     */
    public function getTransaksiHarianAction()
{
    $this->view->disable();
    
        $select = "SELECT COUNT(*) AS total FROM transaksi WHERE date(created_at) = date(CURDATE());";
        $result = $this->db->fetchAll($select);
    
        if (!empty($result)) {
            // Mengakses nilai 'rowcount' dari hasil fetchAll
            $jumlahTersedia = $result[0]['total'];
            echo $jumlahTersedia;
        } else {
            echo "Data tidak ditemukan";
        }
}

     /**
     * @routePost("/delete")
     */
    public function deleteAction()
    {
        $id = Request::get('id');
        $data = [
            'id'=> Request::get('id')
        ];
        $delete = TransaksiModel::findFirst($id);

        $result = $delete->delete();

        $log = new Log(); 
        $log->write("Delete Data Master-Referensi Barang-Barang", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Barang\Controller", "DELETE");

        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }
    
    
    

    }
    

