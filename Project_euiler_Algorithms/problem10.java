public class problem10 {

	public static void main(String args[]) {
		long primeTotal = 0;
		for (int z = 2; z < 2000000; z++) {
			if (isPrime(z)) {
				primeTotal = primeTotal + z;
			}
		}
		System.out.println(primeTotal);
	}
	static boolean isPrime(int n) {
		for (int i = 2; i <= Math.sqrt(n); i++) {
			if (n % i == 0) {
				return false;
			}
		}
		return true;
	}
}
