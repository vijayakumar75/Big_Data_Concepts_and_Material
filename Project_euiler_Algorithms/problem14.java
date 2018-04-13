public class problem14 {
 
 
 
       public static void main(String args[]) {
 
             int limit = 1000000;
 
            
            
            
             long num;
             long temp = 0;
             long maxnum = 0;
            
             for(long i = 13; i <= limit; i++){
                    System.out.println("The chain is :" + Collatz(i) + " long on number " + i);
                   
                    num = Collatz(i);
                   
                    if(num > temp){
                           maxnum = num;
                           temp = maxnum;
                          
                    }
                    System.out.println(maxnum);
                   
                   
                   
             }
            
            
            
            
            
       }
 
       public static int Collatz(long num) {
 
             boolean Switch = true;
             long newNum = 0;
 
             int counter = 1;
             while (Switch == true) {
 
                    if (num % 2 == 0) { // even numbers
                           newNum = num / 2;
                           num = newNum;
                    //       System.out.println(num);
                           if (num == 1) {
                                 Switch = false;
                           }
                    } else if (num % 2 != 0) { // odd numbers
                           newNum = (3 * num) + 1;
                           num = newNum;
                    //       System.out.println(num);
                           if (num == 1) {
                                 Switch = false;
                           }
 
                    }
                    counter++;
             }
 
             return counter;
 
       }
 
}