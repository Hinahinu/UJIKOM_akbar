<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Laporan;

use App\Libraries\Log;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Master\Hakakses\Model as RoleModel;
use App\Modules\Defaults\Master\Produk\VwDetailModel;
use Core\Facades\Response;
use App\Modules\Defaults\Middleware\Controller as MiddlewareHardController;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;


/**
 * @routeGroup("/laporan")
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
     * @routeGet("/datatable")
     * @routePost("/datatable")
     */
    public function datatableAction()
    {
        // var_dump(Request::getPost());exit;
        $pdam_id            = $this->session->user['pdam_id'];
        $filter_kasir       = Request::getPost('kasir');
        $filter_from        = Request::getPost('date_from');
        $filter_until       = Request::getPost('date_until');
        $harian             = Request :: getPost('harian');
        $tahunan            = Request :: getPost('tahunan');
        $bulanan            =  Request :: getPost("bulanan");
        $filter_transaksi   = Request::getPost('transaksi');
        // $nama               = Request::getPost('nama_kasir');
        
        $builder = $this->modelsManager->createBuilder()
                        ->columns('*')
                        ->from(VwTransaksiModel::class)
                        ->where("1=1")
                        ->andWhere("pdam_id = '$pdam_id'");


        if($filter_from && $filter_until){
            $builder->andWhere("date(created_at) BETWEEN :from: AND :until:", ['from' => $filter_from, 'until' => $filter_until]);     

        }
        
        if($harian){
            $builder->andWhere("date(created_at) = '$harian'");
        }
        if($tahunan){
            $builder->andWhere("YEAR(created_at) = '$tahunan'");
        }
        if($bulanan){
            $yearMonth = explode('-', $bulanan);
            $year = $yearMonth[0];
            $month = $yearMonth[1];
            // var_dump($year, $month);exit;
            $builder->andWhere("YEAR(created_at) = '$year' and Month(created_at) = '$month'");
        }
        
        if($filter_kasir) {
            $builder->andWhere("kode_kasir = '$filter_kasir' ");
        }
        if($filter_transaksi){
            $builder->andWhere("id = '$filter_transaksi' ");
        }
        

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();

        // var_dump($dataTables);
        // die;
        
        
    }

    /**
     * @routeGet("/detail")
     */
    public function detailAction()
    {

    }

    /**
     * @routeGet("/laporanPdf")
     * @routePost("/laporanPdf")
     */
    public function laporanPdfAction($id)
    {
        
        $pdam_id = $this->session->user['pdam_id'];
        $filter_kasir       = Request::get('kasir');
        $name_kasir       = Request::get('nama_kasir');
        $filter_from        = Request::get('date_from');
        $format             = Request::get('format');
        $filter_until       = Request::get('date_until');
        $harian             = Request::get('harian');
        $tahunan            = Request::get('tahunan');
        $bulanan            = Request::get("bulanan");
        $filter_transaksi   = Request::get('transaksi');

        $this->view->setVar('module', $id);
        
        $this->view->setVar('kasir_name', $name_kasir);
        $this->view->setVar('dari', $filter_from);
        $this->view->setVar('sampai', $filter_until);
        $this->view->setVar('harian', $harian);
        $this->view->setVar('tahunan', $tahunan);
        $this->view->setVar('bulanan', $bulanan);
        $this->view->setVar('format', $format);
        $this->view->setVar('trans', $filter_transaksi);

       
        
        
        // var_dump( $filter_from, $filter_until);
        // die;
        
        $builder = $this->modelsManager->createBuilder()
                        ->columns('*')
                        ->from(VwModel::class)
                        ->where("1=1")
                        ->andWhere("pdam_id = '$pdam_id'");


        if($filter_transaksi) {
            $builder->andWhere("trans_id = '$filter_transaksi' ");
        }
        
        if($filter_kasir) {
            $builder->andWhere("kode_kasir LIKE '%$filter_kasir%'");
        }
        

        
        if($filter_from && $filter_until){
            $builder->andWhere("date(tanggal) BETWEEN :from: AND :until:", ['from' => $filter_from, 'until' => $filter_until]);     

        }
        
        if($harian){
            $builder->andWhere("date(tanggal) = '$harian'");
        }
        if($tahunan){
            $builder->andWhere("YEAR(tanggal) = '$tahunan'");
        }
        if($bulanan){
            $yearMonth = explode('-', $bulanan);
            $year = $yearMonth[0];
            $month = $yearMonth[1];
            // var_dump($year, $month);exit;
            $builder->andWhere("YEAR(tanggal) = '$year' and Month(tanggal) = '$month'");
        }
        
        if($filter_kasir) {
            $builder->andWhere("kode_kasir = '$filter_kasir' ");
        }
        
        
        

        $result = $builder->getQuery()->execute();

        

        $this->view->setVar('result', $result->toArray());

    }

    
 /**
     * @routeGet("/datatabledetail")
     * @routePost("/datatabledetail")
     */
    public function datatabledetailAction()
    {
        $pdam_id = $this->session->user['pdam_id'];
        $detail = $this->request->getPost("id"); // Ambil diFilter dari permintaan POST
        $builder = $this->modelsManager->createBuilder()
        ->columns('*')
        ->from(VwModel::class)
        ->where("1=1")
        ->andWhere(" trans_id ='$detail' and pdam_id = '$pdam_id'");




        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();

    }

   
}