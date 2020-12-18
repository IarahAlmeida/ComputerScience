<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Usuários Cadastrados</title>
        <script src="https://kit.fontawesome.com/25b5970f89.js" crossorigin="anonymous"></script>
        <style>
            table {
                width: 95%;
                min-width: 300px;
                margin: 0 auto;
                border-collapse: collapse;
                border-top: solid 5px red;
                border-bottom: solid 5px red;
            }
            tr:hover {
                background-color: #777 !important;
            }
            tbody tr:nth-child(odd) {
                background-color: #DDD;
                border-top: solid thin #555;
                border-bottom: solid thin #555;
            }
            td {
                text-align: center;
                padding: .25em;
            }
        </style>
    </head>
    <body>
        <div>
            <main>
                <section>
                    <h1>Usuários Cadastrados</h1>
                    <?php
                    require_once './dbconfig.php';

                    $usuarios = R::findAll('usuario', ' ORDER BY id DESC LIMIT 50');

                    echo gerarTabelaUsuarios($usuarios);
                    ?>
                    <p><i>* São exibidos os últimos 50, no máximo.</i></p>
                </section>

                <section>
                    <h1>Acessos</h1>
                    <?php
                    require_once './dbconfig.php';

                    $acessos = R::findAll('acesso', ' ORDER BY id DESC LIMIT 100');

                    echo gerarTabelaAcessos($acessos);
                    ?>
                    <p><i>* São exibidos os últimos 100, no máximo.</i></p>
                </section>
            </main>
        </div>
    </body>
</html>