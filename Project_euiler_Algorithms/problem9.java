public class problem9 {

	public static void main(String args[]) {

int a ,b,c;
		
		for(  a = 1; a < 1000; a++){
			
			for( b = a +1; b < 1000; b++){
				
				for (c = b +1; c < 1000; c++){
				
				if( Math.pow(a,2)+ Math.pow(b, 2) == Math.pow(c,2) && a + b + c == 1000){
						System.out.println("a = :" + a + "b = :" + b +"c = :" + c);
					}
					
				}

			}
		}
	}
}
		
		
		