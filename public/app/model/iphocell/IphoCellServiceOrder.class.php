<?php

use Adianti\Database\TRecord;

class IphoCellServiceOrder extends TRecord
{
    const TABLENAME = 'iphocell_service_order';
    const PRIMARYKEY = 'ipc_so_id';
    const IDPOLICY = 'max'; // {max, serial}

    public function __construct($id = NULL)
    {
        parent::__construct($id);
        parent::addAttribute('ipc_so_title');
        parent::addAttribute('ipc_so_description');
        parent::addAttribute('ipc_so_opening_date');
        parent::addAttribute('ipc_so_prediction_date');
        parent::addAttribute('ipc_so_status_id');
        parent::addAttribute('ipc_so_client_id');
        parent::addAttribute('ipc_so_exclude');
    }

    public function set_status(IphocellOrderStatus $object)
    {
        $this->status = $object;
        $this->ipc_so_status_id = $object->ipc_so_status_id;
    }

    public function get_status()
    {
        if (empty($this->status))
            $this->status = new IphocellOrderStatus($this->ipc_so_status_id);

        return $this->status;
    }

    public function set_customer(IphoCellClient $object)
    {
        $this->customer = $object;
        $this->ipc_so_client_id = $object->ipc_so_client_id;
    }

    public function get_customer()
    {
        if (empty($this->customer))
            $this->customer = new IphoCellClient($this->ipc_so_client_id);

        return $this->customer;
    }
}