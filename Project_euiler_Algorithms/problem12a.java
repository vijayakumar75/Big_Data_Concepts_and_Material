public class problem12a {

	public static void main(String args[]) {

		TriangleNumber();

	}

	public static void TriangleNumber() {
		long sum = 0;
		long Num = 100000;
		for (long i = 1; i <= Num; i++) {

			sum += i;
			long divisor = 0;

			for (long num1 = sum; num1 > 0; num1--) {

				if (sum % num1 == 0) {
					divisor++;
				}

			}

			System.out.println(sum + ":" + divisor);
			if (divisor > 49) {
				System.out.println("Found number:" + sum);

				break;
			}
		}
	}
}