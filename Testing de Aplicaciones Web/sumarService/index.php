<?php 
	if(isset($_REQUEST['nro1']) && isset($_REQUEST['nro2']) && $_REQUEST['nro1']!=null && $_REQUEST['nro2']!=null){
		$nro1=$_REQUEST['nro1'];
		$nro2=$_REQUEST['nro2'];
		$resultado=$nro1+$nro2;
		echo $resultado;
	}else{
		echo 'Ingrese los valores a sumar!<br>';
	}
?>
