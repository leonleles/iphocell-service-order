<?php

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

        // creates the form
        $this->form = new BootstrapFormBuilder('form_search_costumers');
        $this->form->setFormTitle('Clientes');

        $name = new TEntry('name');
        $this->form->addFields( [new TLabel('Nome:')], [$name] );

        // add form actions
        $this->form->addAction('Buscar', new TAction([$this, 'onSearch']), 'fa:search blue');
        $this->form->addActionLink('Novo',  new TAction(['IphoCellClientForm', 'onClear']), 'fa:plus-circle green');
        $this->form->addActionLink('Limpar',  new TAction([$this, 'clear']), 'fa:eraser red');

        // keep the form filled with the search data
        $this->form->setData( TSession::getValue('StandardDataGridView_filter_data') );

        // creates the DataGrid
        $this->datagrid = new BootstrapDatagridWrapper(new TDataGrid);
        $this->datagrid->width = "100%";

        // creates the datagrid columns
        $col_id    = new TDataGridColumn('ipc_client_id', 'Id', 'right');
        $col_name  = new TDataGridColumn('ipc_client_name', 'Nome', 'left');
        $col_cpf  = new TDataGridColumn('ipc_client_cpf', 'CPF', 'left');
        $col_birthday  = new TDataGridColumn('ipc_client_birthday', 'Data de Nascimento', 'left');

        $this->datagrid->addColumn($col_name);
        $this->datagrid->addColumn($col_cpf);
        $this->datagrid->addColumn($col_birthday);

        $col_name->setAction( new TAction([$this, 'onReload']), ['order' => 'ipc_client_name']);

        $action1 = new TDataGridAction(['IphoCellClientForm', 'onEdit'],   ['key' => '{ipc_client_id}'] );
        $action2 = new TDataGridAction([$this, 'onDelete'],   ['key' => '{ipc_client_id}'] );

        $this->datagrid->addAction($action1, 'Editar',   'far:edit blue');
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

    function onNew () {
    }

    function onEdit() {
    }
}