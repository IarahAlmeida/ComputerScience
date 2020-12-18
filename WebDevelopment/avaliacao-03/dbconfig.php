<?php
date_default_timezone_set('America/Fortaleza');

require_once './R.class.php';

/* AwardSpace */

const DSN = 'mysql:host=127.0.0.1; dbname=webdev';
const REMOTE_USER_NAME = 'root';
const REMOTE_PASSWORD_STRING = '';

R::setup(DSN, REMOTE_USER_NAME, REMOTE_PASSWORD_STRING);

// Contagem de acessos

$acesso = R::dispense('acesso');
$acesso->datahora = new DateTime();
$acesso->ip = $_SERVER['REMOTE_ADDR'];
$acesso->pagina = $_SERVER['PHP_SELF'];
R::store($acesso);


function gerarTabelaUsuarios($usuarios) {

    $saida = '<table>'
            . '<thead>'
            . '<tr>'
            . '<th>Id</th>'
            . '<th><i>Email</i></th>'
            . '<th>Senha</th>'
            . '<th>Admin</th>'
            . '</tr>'
            . '</thead>'
            . '<tbody>';

    foreach ($usuarios as $usuario) {

        $saida .= '<tr>';

        foreach ($usuario as $campo => $valor) {
            if($campo == 'administrador') {
                $saida .=  $valor 
                        ? '<td><i class="far fa-check-circle"></i></td>' 
                        : '<td><i class="far fa-circle"></i></td>';
                continue;
            } 
            $saida .= "<td>$valor</td>";
        }

    }

    $saida .= '</tbody></table >';

    return $saida;
}

function gerarTabelaAcessos($acessos) {

    $saida = '<table>'
            . '<thead>'
            . '<tr>'
                . '<th>Id</th>'
                . '<th><i>Acesso</i></th>'
                . '<th>IP</th>'
                . '<th>Página</th>'
            . '</tr>'
            . '</thead>'
            . '<tbody>';

    foreach ($acessos as $usuario) {

        $saida .= '<tr>';

        foreach ($usuario as $campo => $valor) {
            $saida .= "<td>$valor</td>";
        }

    }

    $saida .= '</tbody></table >';

    return $saida;
}