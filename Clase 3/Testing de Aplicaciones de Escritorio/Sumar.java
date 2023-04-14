public class Sumar{
    public static void main(String[] args) {
        if(args.length<2){
            System.out.println("Ingrese dos números!");
        }else{
            System.out.println(
                Integer.parseInt(args[0])
                +
                Integer.parseInt(args[1])
            );
        }
    }
}