public class ConversorTemperatura {

    public static void main (String[] args) {
        System.out.println("Conversor de Celsius em Fahrenheit");
        System.out.println("=========================================================================================");
        System.out.println("");

 //Temperatura em Celsius x Fahrenheit
        double celsius = 32.4;
        double fahrenheit = (celsius * 1.8) + 32;

        String conversao = String.format("A temperatura de %f Celsius é equivalente a %f Fahrenheit",
                celsius, fahrenheit);
        System.out.println(conversao);

        int temperaturaEmFahrenheitInteira = (int) fahrenheit;
        System.out.println("A temperatura em Fahrenheit inteira é: " + temperaturaEmFahrenheitInteira);

    }
}
