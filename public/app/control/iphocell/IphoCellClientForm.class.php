<?php

class IphoCellClientForm extends TPage
{
    private $form;

    function __construct()
    {
        parent::__construct();

        $this->form = new BootstrapFormBuilder('form_client');
        $this->form->setFormTitle('Cliente');
        $this->form->setFieldSizes('100%');
        $this->form->generateAria();

        $id       = new THidden('ipc_client_id');
        $name     = new TEntry('ipc_client_name');
        $cpf     = new TEntry('ipc_client_cpf');
        $birthday     = new TDate('ipc_client_birthday');

        $this->form->addFields(
            [$id]
        );

        $row = $this->form->addFields(
            [new TLabel('asdasd:'), $name],
            [new TLabel('CPF:'),  $cpf],
            [new TLabel('Data de Nascimento:'), $birthday]
        );

        $row->layout = ['col-sm-6', 'col-sm-3', 'col-sm-3'];

        $name->addValidation('Name', new TRequiredValidator);

        $this->form->addAction('Salvar', new TAction([$this, 'onSave']), 'fa:save green');
        $this->form->addActionLink('Limpar',  new TAction([$this, 'onClear']), 'fa:eraser red');
        // $this->form->addActionLink('Listing',  new TAction(['CompleteDataGridView', 'onReload']), 'fa:table blue');

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

            $object = new IphoCellClient;
            $object->fromArray((array) $data);
            $object->store();

            $this->form->setData($object);

            TTransaction::close();

            new TMessage('info', 'Cliente adicionado com sucesso');;
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
            if (isset($param['ipc_client_id'])) {
                $key = $param['ipc_client_id'];
                TTransaction::open('iphocell');
                $object = new IphoCellClient($key);
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
