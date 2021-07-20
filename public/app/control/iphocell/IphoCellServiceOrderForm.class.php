<?php

use Adianti\Control\TAction;
use Adianti\Control\TPage;
use Adianti\Database\TCriteria;
use Adianti\Database\TFilter;
use Adianti\Database\TTransaction;
use Adianti\Validator\TRequiredValidator;
use Adianti\Widget\Container\TVBox;
use Adianti\Widget\Dialog\TMessage;
use Adianti\Widget\Form\TDate;
use Adianti\Widget\Form\TDateTime;
use Adianti\Widget\Form\TEntry;
use Adianti\Widget\Form\THidden;
use Adianti\Widget\Form\TLabel;
use Adianti\Widget\Form\TText;
use Adianti\Widget\Util\TTextDisplay;
use Adianti\Widget\Util\TXMLBreadCrumb;
use Adianti\Widget\Wrapper\TDBCombo;
use Adianti\Widget\Wrapper\TDBUniqueSearch;
use Adianti\Wrapper\BootstrapFormBuilder;

class IphoCellServiceOrderForm extends TPage
{
    private $form;

    function __construct()
    {
        parent::__construct();

        $this->form = new BootstrapFormBuilder('form_service_order');
        $this->form->setFormTitle('Manutenção');
        $this->form->setFieldSizes('100%');
        $this->form->generateAria();

        $filter_customer = new TCriteria;
        $filter_customer->add(new TFilter('ipc_client_exclude', '=', '0'));

        $filter_status = new TCriteria;
        $filter_status->add(new TFilter('ipc_os_exclude', '=', '0'));

        $id = new THidden('ipc_so_id');
        $title = new TEntry('ipc_so_title');
        $title->setMaxLength(255);
        $description = new TText('ipc_so_description');
        $prev_date = new TDateTime('ipc_so_prediction_date');
        $prev_date->setMask('dd/mm/yyyy hh:ii');
        $prev_date->setDatabaseMask('yyyy-mm-dd hh:ii:00');

        $customer = new TDBUniqueSearch(
            'ipc_so_client_id',
            'iphocell',
            'IphoCellClient',
            'ipc_client_id',
            'ipc_client_name',
            'ipc_client_name',
            $filter_customer
        );

        $customer->setSize('100%');

        $status = new TDBCombo(
            'ipc_so_status_id',
            'iphocell',
            'IphocellOrderStatus',
            'ipc_os_id',
            'ipc_os_name',
            'ipc_os_id',
            $filter_status
        );

        $status->setSize('100%');

        $title->addValidation('Título', new TRequiredValidator);
        $customer->addValidation('Cliente', new TRequiredValidator);
        $status->addValidation('Status', new TRequiredValidator);

        $this->form->addFields(
            [$id]
        );

        $row = $this->form->addFields(
            [new TLabel('Título: *'), $title]
        );
        $row->layout = ['col-sm-12', 'col-sm-12'];


        $row = $this->form->addFields(
            [new TLabel('Descrição:'), $description]
        );
        $row->layout = ['col-sm-12', 'col-sm-12'];

        $row = $this->form->addFields(
            [new TLabel('Cliente: *'), $customer],
            [new TLabel('Status: *'), $status],
            [new TLabel('Previsão:'), $prev_date]
        );
        $row->layout = ['col-sm-4', 'col-sm-4', 'col-sm-4'];

        $this->form->setData((object)['ipc_so_status_id' => 1]);

        $this->form->addAction('Salvar', new TAction([$this, 'onSave']), 'fa:save green');
        $this->form->addActionLink('Limpar', new TAction([$this, 'onClear']), 'fa:eraser red');
         $this->form->addActionLink('Manutenções',  new TAction(['IphoCellServiceOrderList', 'onReload']), 'fa:table blue');

        $vbox = new TVBox;
        $vbox->style = 'width: 100%';
        $vbox->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $vbox->add($this->form);
        parent::add($vbox);
    }

    /**
     * method onSave()
     * Executed whenever the user clicks at the save button
     */
    function onSave()
    {
        try {
            TTransaction::open('iphocell');

            $this->form->validate();

            $data = $this->form->getData();

            $object = new IphoCellServiceOrder;
            $object->fromArray((array)$data);
            $object->store();

            $this->form->setData($object);

            TTransaction::close();

            new TMessage('info', 'Manutenção adicionada com sucesso!');;
        } catch (Exception $e) {
            new TMessage('error', $e->getMessage());
            $this->form->setData($this->form->getData());
            TTransaction::rollback();
        }
    }

    public function onClear()
    {
        $this->form->clear(TRUE);
    }

    function onEdit($param)
    {
        try {
            if (isset($param['ipc_so_id'])) {
                $key = $param['ipc_so_id'];
                TTransaction::open('iphocell');
                $object = new IphoCellServiceOrder($key);

                $this->form->setData($object);
                TTransaction::close();
            } else {
                $this->form->clear(true);
            }
        } catch (Exception $e) {
            new TMessage('error', $e->getMessage());
            TTransaction::rollback();
        }
    }
}
