

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

public class myThread extends Thread{
	

	private File file;
	private int charLimit;
	private String fileDir;
	
	//constructor called from with these 3 parameters
	public myThread(File file, int charLimit, String fileDir){
		this.file = file;
		this.charLimit = charLimit;
		this.fileDir = fileDir;
	}
	
	
	
	
	//run method per each file each thread excutes the run method
	public void run(){

		Scanner input = null;
		try {
			input = new Scanner((file));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		//data structures used to store words
		List<String> list = new ArrayList<String>();
		HashMap<String, List<Integer>> map = new HashMap<String, List<Integer>>();

		//each word is read in and added to a list
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

		// prints to the file using print writer and along with appending _output postfix to each output file
		try {

			File fileTwo = new File(fileDir +"/"
					+ fn);
			FileOutputStream fos = new FileOutputStream(fileTwo);
			PrintWriter pw = new PrintWriter(fos);

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
		
	}
	

	
	

