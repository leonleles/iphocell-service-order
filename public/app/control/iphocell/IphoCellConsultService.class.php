<?php

use Adianti\Control\TAction;
use Adianti\Control\TPage;
use Adianti\Database\TCriteria;
use Adianti\Database\TFilter;
use Adianti\Database\TRepository;
use Adianti\Database\TTransaction;
use Adianti\Validator\TRequiredValidator;
use Adianti\Widget\Container\TVBox;
use Adianti\Widget\Datagrid\TDataGrid;
use Adianti\Widget\Datagrid\TDataGridColumn;
use Adianti\Widget\Dialog\TMessage;
use Adianti\Widget\Form\TDate;
use Adianti\Widget\Form\TEntry;
use Adianti\Widget\Form\THidden;
use Adianti\Widget\Form\TLabel;
use Adianti\Widget\Util\TTextDisplay;
use Adianti\Widget\Util\TXMLBreadCrumb;
use Adianti\Wrapper\BootstrapFormBuilder;

class IphoCellConsultService extends TPage
{
    private $form;
    private $vbox;
    private $status_order;
    private $customer;
    private $last_service;
    private $datagrid;

    function __construct()
    {
        parent::__construct();

        $this->form = new BootstrapFormBuilder('form_consult_service');
        $this->form->setFormTitle('Consultar');
        $this->form->setFieldSizes('100%');
        $this->form->generateAria();

        $cpf = new TEntry('cpf');
        $cpf->setMask('000.000.000-00', true);

        $birthday = new TDate('birthday');
        $birthday->setMask('dd/mm/yyyy');
        $birthday->setDatabaseMask('yyyy-mm-dd');

        $cpf->addValidation('CPF', new TRequiredValidator);
        $birthday->addValidation('Data de Nascimento', new TRequiredValidator);

        $row = $this->form->addFields(
            [new TLabel('CPF: *'), $cpf],
            [new TLabel('Data de Nascimento: *'), $birthday]
        );

        $row->layout = ['col-sm-6', 'col-sm-6'];

        $this->form->addAction('Consultar', new TAction([$this, 'onSearch']), 'fa:eye green');


        $this->vbox = new TVBox;
        $this->vbox->style = 'width: 100%; margin-bottom: 120px';
        $this->vbox->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $this->vbox->add($this->form);

        parent::add($this->vbox);
    }

    private function getStatusOrder()
    {
        try {

            TTransaction::open('iphocell');

            $repository = new TRepository('IphocellOrderStatus');
            $criteria = new TCriteria;

            $param['order'] = 'ipc_os_id';
            $param['direction'] = 'asc';

            $criteria->setProperties($param);

            $filter_explude = new TFilter('ipc_os_exclude', '=', "0");
            $criteria->add($filter_explude);

            $this->status_order = $repository->load($criteria);

            $criteria->resetProperties();

            TTransaction::close();
        } catch (Exception $e) {
            new TMessage('error', $e->getMessage());
        }
    }

    private function getCustomer($param)
    {
        try {

            $repository = new TRepository('IphoCellClient');
            $criteria = new TCriteria;
            $criteria->setProperties(['limit' => 1]);


            $filter_explude = new TFilter('ipc_client_exclude', '=', "0");
            $criteria->add($filter_explude);

            $filter_cpf = new TFilter('ipc_client_cpf', '=', trim($param->cpf));
            $criteria->add($filter_cpf);

            $filter_birthday = new TFilter('ipc_client_birthday', '=', trim($param->birthday));
            $criteria->add($filter_birthday);

            $this->customer = $repository->load($criteria)[0] ?? [];

            $criteria->resetProperties();

        } catch (Exception $e) {
            new TMessage('error', $e->getMessage());
        }
    }

    private function getLastService()
    {
        try {

            $repository = new TRepository('IphoCellServiceOrder');
            $criteria = new TCriteria;
            $criteria->setProperties(['limit' => 1, 'order' => 'ipc_so_opening_date', 'direction' => 'desc']);


            $filter_explude = new TFilter('ipc_so_exclude', '=', "0");
            $criteria->add($filter_explude);

            $filter_customer = new TFilter('ipc_so_client_id', '=', $this->customer->ipc_client_id);
            $criteria->add($filter_customer);

            $this->last_service = $repository->load($criteria)[0] ?? [];

            $criteria->resetProperties();

        } catch (Exception $e) {
            new TMessage('error', $e->getMessage());
        }
    }

    public function onSearch()
    {
        try {
            $this->form->validate();

            $data = $this->form->getData();

            TTransaction::open('iphocell');

            $this->getCustomer($data);

            $lastServiceFormatted = $this->last_service;

            if (empty($this->customer)) {
                new TMessage('error', 'Não encontramos seu usuário. Verifique os dados e tente novamente!');
                return;
            }

            $this->getLastService();

            if (empty($this->last_service)) {
                new TMessage('warning', 'Não encontramos serviços para os dados informados.');
                return;
            }

            $this->getStatusOrder();

            if (!empty($this->status_order)) {
                $this->step = new TPageStep;
                foreach ($this->status_order as $obj_status) {
                    $this->step->addItem($obj_status->ipc_os_name);
                }
                $this->step->select($lastServiceFormatted->status->ipc_os_name);
            }

            $text = new TTextDisplay('<p style="text-align: center; margin: 30px auto; max-width: 700px">Olá <b>' . $this->customer->ipc_client_name . '</b>, bem vindo ao seu serviço de acompanhamento de manutenção. Estamos exibindo abaixo, o status atual da sua última manutenção.</p>', '#757575', 14);
            $text2 = new TTextDisplay('<p style="text-align: center; margin: 30px auto; max-width: 700px"><b>' . $this->last_service->ipc_so_title . '</b></p>', '#757575', 12);

            $this->datagrid = new TDataGrid;
            $this->datagrid->style = 'width: 100%; margin-top: 60px';
            $this->datagrid->datatable = 'true';
            $this->datagrid->width = "100%";

            $description = new TDataGridColumn('ipc_so_description', 'Descrição', 'center');
            $opening_date = new TDataGridColumn('ipc_so_opening_date', 'Data de Abertura', 'center');
            $prediction_date = new TDataGridColumn('ipc_so_prediction_date', 'Data de Previsão/Conclusão', 'center');
            $status = new TDataGridColumn('{status->ipc_os_name}', 'Status', 'center');

            $this->datagrid->addColumn($description);
            $this->datagrid->addColumn($opening_date);
            $this->datagrid->addColumn($prediction_date);
            $this->datagrid->addColumn($status);

            $this->datagrid->createModel();

            $lastServiceFormatted->ipc_so_opening_date = date('d/m/Y H:i', strtotime($lastServiceFormatted->ipc_so_opening_date));
            $lastServiceFormatted->ipc_so_prediction_date = date('d/m/Y H:i', strtotime($lastServiceFormatted->ipc_so_prediction_date));

            $this->datagrid->addItem($lastServiceFormatted);

            TTransaction::close();

            $this->vbox->add($text);
            $this->vbox->add($text2);
            $this->vbox->add($this->step);
            $this->vbox->add($this->datagrid);

        } catch (Exception $e) {
            new TMessage('error', $e->getMessage());
            $this->form->setData($this->form->getData());
        }
    }
}
