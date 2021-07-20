<?php

use Adianti\Control\TAction;
use Adianti\Control\TPage;
use Adianti\Database\TCriteria;
use Adianti\Database\TFilter;
use Adianti\Database\TTransaction;
use Adianti\Registry\TSession;
use Adianti\Widget\Container\TPanelGroup;
use Adianti\Widget\Container\TVBox;
use Adianti\Widget\Datagrid\TDataGrid;
use Adianti\Widget\Datagrid\TDataGridAction;
use Adianti\Widget\Datagrid\TDataGridColumn;
use Adianti\Widget\Datagrid\TPageNavigation;
use Adianti\Widget\Dialog\TMessage;
use Adianti\Widget\Dialog\TQuestion;
use Adianti\Widget\Form\TEntry;
use Adianti\Widget\Form\TLabel;
use Adianti\Widget\Util\TXMLBreadCrumb;
use Adianti\Wrapper\BootstrapDatagridWrapper;
use Adianti\Wrapper\BootstrapFormBuilder;

class IphoCellClientList extends TPage
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
        $this->setActiveRecord('IphoCellClient');       // defines the active record
        $this->setDefaultOrder('ipc_client_name', 'asc');  // define the default order

        $form_filters = TSession::getValue('IphoCellClientList_filter_data');

        $criteria = new TCriteria();
        $criteria->add(new TFilter('ipc_client_exclude', '=', 0));

        if (isset($form_filters->name) && $name_filter = $form_filters->name) {
            $criteria->add(new TFilter('ipc_client_name', 'LIKE', $name_filter));
        }

        $this->setCriteria($criteria);


        // creates the form
        $this->form = new BootstrapFormBuilder('form_search_costumers');
        $this->form->setFormTitle('Clientes');

        $name = new TEntry('name');
        $this->form->addFields([new TLabel('Nome:')], [$name]);

        // add form actions
        $this->form->addAction('Buscar', new TAction([$this, 'onSearch']), 'fa:search blue');
        $this->form->addActionLink('Novo', new TAction(['IphoCellClientForm', 'onClear']), 'fa:plus-circle green');
        $this->form->addActionLink('Limpar', new TAction([$this, 'clear']), 'fa:eraser red');

        // keep the form filled with the search data
        $this->form->setData(TSession::getValue('IphoCellClientList_filter_data'));

        // creates the DataGrid
        $this->datagrid = new BootstrapDatagridWrapper(new TDataGrid);
        $this->datagrid->width = "100%";

        // creates the datagrid columns
        $col_id = new TDataGridColumn('ipc_client_id', 'Id', 'right');
        $col_name = new TDataGridColumn('ipc_client_name', 'Nome', 'left');
        $col_cpf = new TDataGridColumn('ipc_client_cpf', 'CPF', 'left');
        $col_birthday = new TDataGridColumn('ipc_client_birthday', 'Data de Nascimento', 'left');

        $this->datagrid->addColumn($col_name);
        $this->datagrid->addColumn($col_cpf);
        $this->datagrid->addColumn($col_birthday);

        $col_name->setAction(new TAction([$this, 'onReload']), ['order' => 'ipc_client_name']);

        $action1 = new TDataGridAction(['IphoCellClientForm', 'onEdit'], ['key' => '{ipc_client_id}']);
        $action2 = new TDataGridAction([$this, 'onDelete'], ['key' => '{ipc_client_id}']);

        $this->datagrid->addAction($action1, 'Editar', 'far:edit blue');
        $this->datagrid->addAction($action2, 'Deletar', 'far:trash-alt red');

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
    function clear()
    {
        $this->clearFilters();
        $this->onReload();
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
            $object = new IphoCellClient($param['ipc_client_id'], FALSE);

            $object->ipc_client_exclude = 1;

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

}