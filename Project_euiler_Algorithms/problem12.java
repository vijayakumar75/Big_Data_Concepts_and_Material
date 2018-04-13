public class problem12 {

	static Double myInf = Double.POSITIVE_INFINITY;

	public static void main(String args[]) {
		long divisor = 0;
		double NaturalNum = 7;

		long TriangleNum = TriangleNumber((long) NaturalNum);

		for (long num1 = TriangleNum; num1 > 0; num1--) {

			if (TriangleNum % num1 == 0) {
				divisor++;
				System.out.print(divisor);
			}

		}

		System.out.println("There are " + divisor + " in it");

	}

	public static long TriangleNumber(long Num) {
		long sum = 0;
		for (long i = 1; i <= Num; i++) {

			sum += i;
			System.out.println(sum);
		}
		System.out.println(sum);
		return sum;

	}

}