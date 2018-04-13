

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;
import java.util.SortedSet;
import java.util.TreeSet;

public class index {

	public static void main(String args[]) {
		
		// start of the time
		long start = System.currentTimeMillis();
		
		// arguments fileDirectory and charlimit 1st and 2nd parameter
		 String fileDir = args[0];
		 int charLimit = Integer.parseInt(args[1]);
		 
		// folder where the .txt files located
		File folder = new File(fileDir);
 		File[] listofFiles = folder.listFiles();
		
		
		//Loops through the files in the directory
		for (File file : listofFiles) {
			if (file.isFile()) {
				System.out.println(file.getName());
			}

			Scanner input = null;
			try {
				input = new Scanner((file));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}

			// list and map created to add words to file and put them in to map eventually
			List<String> list = new ArrayList<String>();
			HashMap<String, List<Integer>> map = new HashMap<String, List<Integer>>();

			String word = null;
			while (input.hasNext()) {
				word = input.next();
				list.add(word);
			}

			int totalSize = 0;
			int count = 1;

			// iterates through each word in the list
			for (String eachString : list) {

				totalSize = totalSize + eachString.length();
				// character limit is set here
				if (totalSize >= charLimit) {
					count++;
					totalSize = 0;

				} else {

					String s = eachString;
					
					//empty map is created if the words hasn't already been added 
					if (!map.containsKey(s)) {
						map.put(s, new ArrayList<Integer>());
					}

					List<Integer> q = map.get(s);
					if (!q.contains(count)) {
						// the duplicate indexes are dissmissed here
						q.add(count);
					}
				}

			}

			String filename = file.getName();

			String fn = filename.substring(0, filename.lastIndexOf('.'))
					+ "_output.txt";

			try {

				File fileTwo = new File(fileDir +"/"+
						 fn);
				FileOutputStream fos = new FileOutputStream(fileTwo);
				PrintWriter pw = new PrintWriter(fos);
				
				//sorted map keys to arrange by alphabetically orderded
				SortedSet<String> keys = new TreeSet<String>(map.keySet());
				for (String key : keys) {

					List<Integer> value = map.get(key);
					// System.out.println(key + " : " + value);
					// hmap.put(key, value);
					pw.println(key + " " + value.toString().replaceAll("[\\[\\](){}]",""));
				}

				pw.flush();
				pw.close();
				fos.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		// close and the time is calculated here
		long end = System.currentTimeMillis();
		System.out.println(end - start + " milliseconds");
		
	}
}