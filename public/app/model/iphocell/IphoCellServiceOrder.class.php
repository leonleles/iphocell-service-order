<?php

use Adianti\Database\TRecord;

class IphoCellServiceOrder extends TRecord
{
    const TABLENAME = 'iphocell_service_order';
    const PRIMARYKEY= 'ipc_so_id';
    const IDPOLICY =  'max'; // {max, serial}

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
}