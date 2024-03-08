<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Master\Kasir;

use App\Libraries\Log;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Master\Hakakses\Model as RoleModel;
use Core\Facades\Response;
use App\Modules\Defaults\Middleware\Controller as MiddlewareHardController;
use Core\Facades\Request;
use Core\Paginator\DataTables\DataTable;
use App\Modules\Defaults\Master\Kasir\Model as Model;

/**
 * @routeGroup("/master/kasir")
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
        $pdam_id = $this->session->user['pdam_id'];
        $search_nama = Request::getPost('search_nama');
        $search_kode = Request::getPost('search_kode');

        $builder = $this->modelsManager->createBuilder()
                        ->columns('*')
                        ->from(Model::class)
                        ->where("1=1")
                        ->andWhere("pdam_id = '$pdam_id'");

        if($search_nama) {
            $builder->andWhere("nama LIKE '%$search_nama%'");
        }

        if($search_kode) {
            $builder->andWhere("kode LIKE '%$search_kode%'");
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
        $pass = Request::getPost('password'); 
        $hash = password_hash($pass, PASSWORD_DEFAULT);
        
        $data = [ 
            'nama'                  => Request::getPost('nama'),
            'kode'                  => Request::getPost('kode'),
            'password'              => $pass,
            'password_hash'         => $hash,
            'pdam_id'       => $pdam_id,
        ];

        $create = new Model($data);
        $result = $create->save();

        $log = new Log(); 
        $log->write("Insert Data Master-Referensi Barang-Satuan", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Satuan\Controller", "INSERT");

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
        $pass = Request::getPost('password'); 
        $hash = password_hash($pass, PASSWORD_DEFAULT);

        $data = [
            'nama'                  => Request::getPost('nama'),
            'kode'                  => Request::getPost('kode'),
            'password'              => $pass,
            'password_hash'         => $hash,
            'pdam_id'               => $pdam_id,
        ];
        $update = Model::findFirst($id);
        $update->assign($data);

        $result = $update->save();

        $log = new Log(); 
        $log->write("Update Data Master-Referensi Barang-Satuan", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Satuan\Controller", "UPDATE");

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
            'id' => $id
        ];
        $delete = Model::findFirst($id);

        $result = $delete->delete();

        $log = new Log(); 
        $log->write("Delete Data Master-Referensi Barang-Satuan", $data, $result, "App\Modules\Defaults\Master\ReferensiBarang\Satuan\Controller", "DELETE");

        return Response::setJsonContent([
            'message' => 'Success',
        ]);
    }
    
}