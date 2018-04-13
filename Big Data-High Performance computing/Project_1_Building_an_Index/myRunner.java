
import java.io.File;
import java.util.Scanner;

public class myRunner {

	public static void main(String args[]) {

//		Scanner scan = new Scanner(System.in);
//		String fileDir = scan.nextLine();
//		int charLimit = scan.nextInt();

		long total = 0;
		long end;
		
		// reads in the parameters from the user filedirectorya and charLimit
		 String fileDir = args[0];
		 int charLimit = Integer.parseInt(args[1]);

		// File folder = new File("C:/Users/spoli/Desktop/sampleInput1/");
		long start = System.currentTimeMillis();

		File folder = new File(fileDir);
		File[] listofFiles = folder.listFiles();
		
		//prints the files in the directory
		for (File file : listofFiles) {
			if (file.isFile()) {
				System.out.println(file.getName());
			}
		}

			myThread[] theWorkers = new myThread[listofFiles.length];

			// Thread created for every file in the directory
			for (int i = 0; i < listofFiles.length; i++) {

				if (listofFiles[i].isFile()) {

					theWorkers[i] = new myThread(listofFiles[i], charLimit,
							fileDir);
					theWorkers[i].start();
				}
				
				
				// takes the time after each thread has finished
			 end = System.currentTimeMillis();
			total = total + end - start;

			}
			
			System.out.println((total) + " milliseconds");
		}
		
		

		

	}
	

