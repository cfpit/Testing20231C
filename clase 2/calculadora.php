<!DOCTYPE html>
<html>
<head>
    <title>Calculadora Básica en PHP</title>
</head>
<body>
    <h1>Calculadora Básica en PHP</h1>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
        <label>Primer número:</label>
        <input type="text" name="num1"><br><br>
        <label>Segundo número:</label>
        <input type="text" name="num2"><br><br>
        <label>Operación:</label>
        <select name="operacion">
            <option value="sumar">Sumar</option>
            <option value="restar">Restar</option>
            <option value="multiplicar">Multiplicar</option>
            <option value="dividir">Dividir</option>
        </select><br><br>
        <input type="submit" name="submit" value="Calcular">
    </form>
    <?php
        if(isset($_POST['submit'])){
            $num1 = $_POST['num1'];
            $num2 = $_POST['num2'];
            $operacion = $_POST['operacion'];
            $resultado = 0;
            switch($operacion){
                case "sumar":
                    $resultado = $num1 + $num2;
                    break;
                case "restar":
                    $resultado = $num1 - $num2;
                    break;
                case "multiplicar":
                    $resultado = $num1 * $num2;
                    break;
                case "dividir":
                    if($num2 != 0){
                        $resultado = $num1 / $num2;
                    }else{
                        echo "<p style='color:red;'>Error: división entre cero.</p>";
                    }
                    break;
            }
            echo "<p>El resultado de la operación es: $resultado</p>";
        }
    ?>
</body>
</html>
