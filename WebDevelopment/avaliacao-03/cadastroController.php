<?php

require_once './dbconfig.php';

$usuario = R::dispense('usuario');

$usuario->email = 'user_umidentificadordemailmuitomaislongodoqueoconvencional@servidorremoto.mail.com';
$usuario->senha = 'abcdefghijklmnopqrstuvwxyz0123456789';
$usuario->administrador = random_int(0, 1);

R::store($usuario);

require_once './resultado.php';