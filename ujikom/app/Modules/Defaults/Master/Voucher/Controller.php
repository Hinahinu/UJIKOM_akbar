<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Master\Voucher;

use App\Libraries\Log;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Master\Hakakses\Model as RoleModel;
use Core\Facades\Response;
use App\Modules\Defaults\Middleware\Controller as MiddlewareHardController;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;
use App\Modules\Defaults\Master\Voucher\Model as Model;

/**
 * @routeGroup("/master/voucher")
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
        $pdam_id = $this->session->user['pdam_id'];
        $status = Request::getPost('status');
        
        $builder = $this->modelsManager->createBuilder()
                        ->columns('*')
                        ->from(VwModel::class)
                        ->where("1=1")
                        ->andWhere("pdam_id = '$pdam_id'");

        if($status) {
            $builder->andWhere("status LIKE '%$status%'");
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
        $pdam_id = $this->session->user['pdam_id'];
        $sessUser = $this->session->user['nama'];
        $data = [
            'kode'              => Request::getPost('kode'),
            'diskon'            => Request::getPost('diskon'),
            'qty'               => Request::getPost('qty'),
            'active_at'         => Request::getPost('active_at'),
            'expired_at'        => Request::getPost('expired_at'),
            'pdam_id'           => $pdam_id,
        ];
        $create = new Model($data);
        $result = $create->save();

        $log = new Log(); 
        $log->write("Insert Data Master-Referensi Barang-Barang", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Barang\Controller", "INSERT");

        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }

    /**
     * @routePost("/update")
     */
    public function updateAction()
    {
        $pdam_id = $this->session->user['pdam_id'];
        $sessUser = $this->session->user['nama'];
        
        $id = Request::getPost('id');
        $pdam_id = $this->session->user['pdam_id'];
        $data = [
            'kode'              => Request::getPost('kode'),
            'diskon'            => Request::getPost('diskon'),
            'qty'               => Request::getPost('qty'),
            'active_at'         => Request::getPost('active_at'),
            'expired_at'        => Request::getPost('expired_at'),
            'pdam_id'           => $pdam_id,
        ];
        $update = Model::findFirst($id);
        $update->assign($data);

        $result = $update->save();

        $log = new Log(); 
        $log->write("Update Data Master-Referensi Barang-Barang", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Barang\Controller", "UPDATE");

        return Response::setJsonContent([
            'message' => 'Success',
        ]);
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
        $delete = Model::findFirst($id);

        $result = $delete->delete();

        $log = new Log(); 
        $log->write("Delete Data Master-Referensi Barang-Barang", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Barang\Controller", "DELETE");

        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }
    
}