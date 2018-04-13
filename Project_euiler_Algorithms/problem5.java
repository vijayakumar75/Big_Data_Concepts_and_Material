public class problem5 {

	public static void main(String args[]) {
		int x = 1;
		int y = 1;

		while (y != 20) {
			if (x % y == 0) {
				y++;
			} else {
				x++;
				y = 1;
			}

		}
		System.out.println(x);

	}

}
