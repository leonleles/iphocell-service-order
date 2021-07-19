<?php

class IphoCellClient extends TRecord
{
    const TABLENAME = 'iphocell_client';
    const PRIMARYKEY= 'ipc_client_id';
    const IDPOLICY =  'max'; // {max, serial}

    public function __construct($id = NULL)
    {
        parent::__construct($id);
        parent::addAttribute('ipc_client_name');
        parent::addAttribute('ipc_client_cpf');
        parent::addAttribute('ipc_client_birthday');
    }
}