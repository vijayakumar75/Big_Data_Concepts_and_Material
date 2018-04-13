import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

public class problem8 {

	public static void main(String args[]) {

		String stringData = "";
		ArrayList<Integer> list = new ArrayList<Integer>();

		try {

			Scanner getInput = new Scanner(System.in);

			File file = new File("arrayFile.txt");
			Scanner scanner = new Scanner(file);
			while (scanner.hasNextLine()) {
				stringData += scanner.nextLine();
			}

			// loads the string per line(bit) into an array list
			for (int i = 0; i < stringData.length(); i++) {

				list.add((Integer.valueOf(stringData.substring(i, i + 1))));

				System.out.println(list.get(i));

			}
		} catch (Exception e) {
			System.out.println("File could not be accessed");
		}

		System.out.println(list.size());

		try {
			long newProd = 1;
			for (int z = 0; z < 1000; z++) {
				System.out.println(list.subList(z, z + 13));

				List<Integer> sublist = list.subList(z, z + 13);
				long prod = 1;
				for (int i : sublist)
					prod *= i;
				System.out.println(prod);

				if (prod >= newProd) {
					newProd = prod;
				}

				System.out.println("The new highest product is: " + newProd);

			}

		} catch (IndexOutOfBoundsException e) {
			// continue
			// System.out.println("Exception thrown  :" + e);
		}

	}
}