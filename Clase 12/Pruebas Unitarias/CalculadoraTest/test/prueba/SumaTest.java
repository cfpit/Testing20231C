/*
 Las anotaciones @BeforeClass, @AfterClass, @Before y @After son anotaciones de 
JUnit que se utilizan para configurar y realizar tareas específicas antes y 
después de los métodos de prueba en una clase de prueba. Aquí te explico 
brevemente cada una de ellas:

@BeforeClass: Esta anotación se utiliza para marcar un método que debe ejecutarse 
antes de que se inicie la ejecución de todos los métodos de prueba en una clase. 
Este método debe ser estático (static) y se ejecutará una sola vez en el inicio 
de la clase de prueba. Se utiliza principalmente para realizar tareas de 
configuración que se requieren una vez antes de que comiencen las pruebas. Por 
ejemplo, puede usarse para establecer una conexión a una base de datos o cargar 
datos iniciales.

@AfterClass: Esta anotación se utiliza para marcar un método que debe ejecutarse 
después de que se hayan completado todos los métodos de prueba en una clase. Al 
igual que @BeforeClass, este método también debe ser estático (static) y se ejecutará 
una sola vez al finalizar las pruebas. Se utiliza principalmente para realizar tareas 
de limpieza o liberación de recursos que se requieren después de que se completen 
todas las pruebas. Por ejemplo, puede usarse para cerrar una conexión a una base 
de datos o liberar memoria.

@Before: Esta anotación se utiliza para marcar un método que debe ejecutarse antes 
de cada método de prueba en una clase. Este método se ejecutará antes de cada prueba 
individual y se utiliza principalmente para realizar tareas de configuración 
específicas para cada prueba. Por ejemplo, puede usarse para inicializar objetos 
o establecer valores iniciales necesarios para la prueba.

@After: Esta anotación se utiliza para marcar un método que debe ejecutarse después 
de cada método de prueba en una clase. Este método se ejecutará después de cada 
prueba individual y se utiliza principalmente para realizar tareas de limpieza o 
liberación de recursos específicos de cada prueba. Por ejemplo, puede usarse para 
eliminar objetos creados durante la prueba o restablecer los valores modificados.

La anotación @Test es una de las anotaciones más importantes en JUnit y se 
utiliza para marcar un método como un método de prueba. Esta anotación indica 
que el método debe ser ejecutado como una prueba individual cuando se ejecuten 
las pruebas en una clase de prueba.

Al utilizar la anotación @Test, se espera que el método anotado contenga el 
código de prueba real, es decir, el conjunto de pasos y verificaciones que se 
desean probar. JUnit ejecutará cada método anotado con @Test de forma individual 
y generará un informe de resultados de la prueba.

Aquí hay algunas características clave de la anotación @Test:

Los métodos anotados con @Test no deben tener parámetros.
Los métodos anotados con @Test no deben devolver ningún valor.
Si un método anotado con @Test arroja una excepción, JUnit considerará que la 
prueba ha fallado.
Puedes usar múltiples anotaciones @Test en una clase de prueba para definir 
múltiples pruebas independientes.
Puedes usar métodos de aserción de JUnit, como assertEquals, assertTrue, etc., 
dentro de los métodos anotados con @Test para verificar los resultados esperados.
 */
package prueba;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author  - Jorge
 */
public class SumaTest {
    
    public SumaTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    @Test
    public void testSumar() {
        System.out.println("sumar");
        int a = 0;
        int b = 6;
        Suma instance = new Suma();
        int expResult = 6;
        int result = instance.sumar(a, b);
        assertEquals(expResult, result);
        
    }
    
    
    
}
