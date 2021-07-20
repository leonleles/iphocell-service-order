<?php

use Adianti\Database\TRecord;

class IphocellOrderStatus extends TRecord
{
    const TABLENAME = 'iphocell_order_status';
    const PRIMARYKEY= 'ipc_os_id';
    const IDPOLICY =  'max'; // {max, serial}

    public function __construct($id = NULL)
    {
        parent::__construct($id);
        parent::addAttribute('ipc_os_name');
        parent::addAttribute('ipc_os_exclude');
    }
}