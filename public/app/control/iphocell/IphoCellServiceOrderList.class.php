<?php

use Adianti\Control\TAction;
use Adianti\Control\TPage;
use Adianti\Database\TCriteria;
use Adianti\Database\TExpression;
use Adianti\Database\TFilter;
use Adianti\Database\TRepository;
use Adianti\Database\TTransaction;
use Adianti\Registry\TSession;
use Adianti\Widget\Container\TPanelGroup;
use Adianti\Widget\Container\TVBox;
use Adianti\Widget\Datagrid\TDataGrid;
use Adianti\Widget\Datagrid\TDataGridAction;
use Adianti\Widget\Datagrid\TDataGridActionGroup;
use Adianti\Widget\Datagrid\TDataGridColumn;
use Adianti\Widget\Datagrid\TPageNavigation;
use Adianti\Widget\Dialog\TMessage;
use Adianti\Widget\Dialog\TQuestion;
use Adianti\Widget\Form\TDate;
use Adianti\Widget\Form\TEntry;
use Adianti\Widget\Form\TLabel;
use Adianti\Widget\Util\TXMLBreadCrumb;
use Adianti\Widget\Wrapper\TDBCombo;
use Adianti\Widget\Wrapper\TDBMultiSearch;
use Adianti\Widget\Wrapper\TDBUniqueSearch;
use Adianti\Wrapper\BootstrapDatagridWrapper;
use Adianti\Wrapper\BootstrapFormBuilder;

class IphoCellServiceOrderList extends TPage
{
    protected $form;     // registration form
    protected $datagrid; // listing
    protected $pageNavigation;

    // trait with onReload, onSearch, onDelete...
    use Adianti\Base\AdiantiStandardListTrait;

    /**
     * Class constructor
     * Creates the page, the form and the listing
     */
    public function __construct($param = null)
    {
        parent::__construct();

        $this->setDatabase('iphocell');        // defines the database
        $this->setActiveRecord('IphoCellServiceOrder');       // defines the active record
        $this->setDefaultOrder('ipc_so_opening_date', 'desc');  // define the default order

        $criteria = new TCriteria();
        $criteria->add(new TFilter('ipc_so_exclude', '=', 0));

        $this->setCriteria($criteria);

        // creates the form
        $this->form = new BootstrapFormBuilder('form_search_services');
        $this->form->setFormTitle('Manutenções');

        $filter_customer = new TCriteria;
        $filter_customer->add(new TFilter('ipc_client_exclude', '=', '0'));

        $filter_status = new TCriteria;
        $filter_status->add(new TFilter('ipc_os_exclude', '=', '0'));

        $search = new TEntry('search');
        $search->setSize('100%');
        $this->form->setFieldSizes('100%');
        $this->form->generateAria();

        $customer = new TDBUniqueSearch(
            'customer_id',
            'iphocell',
            'IphoCellClient',
            'ipc_client_id',
            'ipc_client_name',
            'ipc_client_name',
            $filter_customer
        );

        $customer->setSize('100%');

        $status = new TDBCombo(
            'status_id',
            'iphocell',
            'IphocellOrderStatus',
            'ipc_os_id',
            'ipc_os_name',
            'ipc_os_id',
            $filter_status
        );

        $status->setSize('100%');

        $opening_date = new TDate('opening_date');
        $opening_date->setMask('dd/mm/yyyy');
        $opening_date->setDatabaseMask('yyyy-mm-dd');

        $prev_date = new TDate('prev_date');
        $prev_date->setMask('dd/mm/yyyy');
        $prev_date->setDatabaseMask('yyyy-mm-dd');

        $row = $this->form->addFields(
            [new TLabel('Digite o que procura:'), $search],
            [new TLabel('Data de abertura:'), $opening_date],
            [new TLabel('Data de previsão:'), $prev_date]
        );

        $row->layout = ['col-sm-6', 'col-sm-3', 'col-sm-3'];

        $row = $this->form->addFields(
            [new TLabel('Cliente:'), $customer],
            [new TLabel('Status:'), $status]
        );

        $row->layout = ['col-sm-6', 'col-sm-6'];

        // add form actions
        $this->form->addAction('Buscar', new TAction([$this, 'onSearch']), 'fa:search blue');
        $this->form->addActionLink('Limpar', new TAction([$this, 'onClear']), 'fa:eraser red');
        $this->form->addActionLink('Novo', new TAction(['IphoCellServiceOrderForm', 'onClear']), 'fa:plus-circle green');

        // keep the form filled with the search data
//        $this->form->setData(TSession::getValue('IphoCellServiceOrder_filter_data'));

        // creates the DataGrid
        $this->datagrid = new BootstrapDatagridWrapper(new TDataGrid);
        $this->datagrid->datatable = 'true';
        $this->datagrid->width = "100%";

        // creates the datagrid columns
        $col_id = new TDataGridColumn('ipc_so_id', 'Id', 'right');
        $col_name = new TDataGridColumn('ipc_so_title', 'Título', 'left');
        $col_description = new TDataGridColumn('ipc_so_description', 'Descrição', 'left');
        $col_opening = new TDataGridColumn('ipc_so_opening_date', 'Abertura', 'left');
        $col_prediction = new TDataGridColumn('ipc_so_prediction_date', 'Previsão', 'left');
        $col_client = new TDataGridColumn('{customer->ipc_client_name}', 'Cliente', 'left');
        $row_status = $col_status = new TDataGridColumn('{status->ipc_os_name}', 'Status', 'left');

        $row_status->setTransformer(function ($value, $object, $row) {
            $style = '';

            if ($object->status->ipc_os_id == 1) {
                $style = 'color: #007bff';
            } else if ($object->status->ipc_os_id == 2) {
                $style = 'color: #dd5a43';
            } else if ($object->status->ipc_os_id == 3) {
                $style = 'color: #ff00ed';
            } else if ($object->status->ipc_os_id == 4) {
                $style = 'color: #31b131';
            }

            return "<span style='$style'>$value</span>";
        });

        $col_opening->setTransformer(function ($value, $object, $row) {
            return date('d/m/Y H:i', strtotime($value));
        });
        $col_prediction->setTransformer(function ($value, $object, $row) {
            if (!$value) return $value;

            return date('d/m/Y H:i', strtotime($value));
        });

        $this->datagrid->addColumn($col_name);
        $this->datagrid->addColumn($col_description);
        $this->datagrid->addColumn($col_opening);
        $this->datagrid->addColumn($col_prediction);
        $this->datagrid->addColumn($col_client);
        $this->datagrid->addColumn($col_status);

        $col_name->setAction(new TAction([$this, 'onReload']), ['order' => 'ipc_so_title']);

        $action1 = new TDataGridAction(['IphoCellServiceOrderForm', 'onEdit'], ['key' => '{ipc_so_id}']);
        $action1->setLabel('Editar');
        $action1->setImage('fa:edit blue');

        $action2 = new TDataGridAction([$this, 'onDelete'], ['key' => '{ipc_so_id}']);
        $action2->setLabel('Apagar');
        $action2->setImage('fa:trash-alt red');

        $action_group = new TDataGridActionGroup('', 'fa:th');
        $action_group->addAction($action1);
        $action_group->addAction($action2);

        $this->datagrid->addActionGroup($action_group);

        // create the datagrid model
        $this->datagrid->createModel();

        // creates the page navigation
        $this->pageNavigation = new TPageNavigation;
        $this->pageNavigation->setAction(new TAction(array($this, 'onReload')));

        // creates the page structure using a table
        $vbox = new TVBox;
        $vbox->style = 'width: 100%';
        $vbox->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $vbox->add($this->form);
        $vbox->add(TPanelGroup::pack('', $this->datagrid, $this->pageNavigation));

        // add the table inside the page
        parent::add($vbox);
    }

    /**
     * Clear filters
     */
    function onClear()
    {
        $this->clearFilters();
        $this->onReload();
    }

    function clearFilters()
    {
        TSession::setValue('IphoCellServiceOrder_find_search_title_filter', null);
        TSession::setValue('IphoCellServiceOrder_find_search_description_filter', null);
        TSession::setValue('IphoCellServiceOrder_find_customer_filter', null);
        TSession::setValue('IphoCellServiceOrder_filter_data', null);
        $this->form->clear();
    }

    public function onDelete($param)
    {
        $action = new TAction(array($this, 'Delete'));
        $action->setParameters($param); // pass the key parameter ahead

        new TQuestion(TAdiantiCoreTranslator::translate('Do you really want to delete ?'), $action);
    }

    /**
     * Delete a record
     */
    public function Delete($param)
    {
        try {
            TTransaction::open('iphocell');
            $object = new IphoCellServiceOrder($param['ipc_so_id'], FALSE);

            $object->ipc_so_exclude = 1;

            $object->fromArray((array)$object);
            $object->store();

            TTransaction::close();
            $action = new TAction(array($this, 'onReload'));
            new TMessage('info', TAdiantiCoreTranslator::translate('Record deleted'), $action); // success message
        } catch (Exception $e) // in case of exception
        {
            new TMessage('error', '<b>Error</b> ' . $e->getMessage()); // shows the exception error message
            TTransaction::rollback(); // undo all pending operations
        }
    }

    function onSearch()
    {
        // get the search form data
        $data = $this->form->getData();

//        TSession::setValue('IphoCellServiceOrder_filter_data', $data);

        // fill the form with data again
        $this->form->setData($data);

        $param = array();
        $param['offset'] = 0;
        $param['first_page'] = 1;
        $this->onReload($param, $data);
    }

    public function onReload($param = NULL, $data = null)
    {
        try {
            TTransaction::open('iphocell');

            $repository = new TRepository('IphoCellServiceOrder');
            $limit = 10;

            $criteria = new TCriteria;
            $criteria->add(new TFilter('ipc_so_exclude', '=', 0));

            $param['order'] = 'ipc_so_opening_date';
            $param['direction'] = 'desc';

            $criteria->setProperties($param); // order, offset
            $criteria->setProperty('limit', $limit);

            if (isset($data->search) && !empty($data->search)) {
                $filter_title = new TFilter('ipc_so_title', 'like', "%{$data->search}%");
                $filter_description = new TFilter('ipc_so_description', 'like', "%{$data->search}%");

                $criteria->add($filter_title, TExpression::OR_OPERATOR);
                $criteria->add($filter_description, TExpression::OR_OPERATOR);
            }

            if (isset($data->customer_id) && !empty($data->customer_id)) {
                $filter_customer = new TFilter('ipc_so_client_id', '=', $data->customer_id);
                $criteria->add($filter_customer, TExpression::AND_OPERATOR);
            }

            if(isset($data->status_id) && !empty($data->status_id)) {
                $filter_status = new TFilter('ipc_so_status_id', '=', $data->status_id);
                $criteria->add($filter_status, TExpression::AND_OPERATOR);
            }

            if(isset($data->opening_date) && !empty($data->opening_date)) {
                $filter_opening_date = new TFilter('ipc_so_opening_date', 'LIKE', "%$data->opening_date%");
                $criteria->add($filter_opening_date, TExpression::AND_OPERATOR);
            }

            if(isset($data->prev_date) && !empty($data->prev_date)) {
                $filter_prev_date = new TFilter('ipc_so_prediction_date', 'LIKE', "%$data->prev_date%");
                $criteria->add($filter_prev_date, TExpression::AND_OPERATOR);
            }

            $objects = $repository->load($criteria);

            $this->datagrid->clear();

            if ($objects) {
                foreach ($objects as $object) {
                    $this->datagrid->addItem($object);
                }
            }

            $criteria->resetProperties();
            $count = $repository->count($criteria);

            $this->pageNavigation->setCount($count); // count of records
            $this->pageNavigation->setProperties($param); // order, page
            $this->pageNavigation->setLimit($limit); // limit

            TTransaction::close();
            $this->loaded = true;
        } catch (Exception $e) {
            new TMessage('error', $e->getMessage());
            TTransaction::rollback(); // undo all pending operations
        }

        $this->loaded = TRUE;
    }

}