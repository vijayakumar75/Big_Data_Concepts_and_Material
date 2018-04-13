import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Scanner;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;

public class myRunner {


    private static String fileDir1;
	static List<LinkedHashMap<String, List<Integer>>> MapContainer = new ArrayList<LinkedHashMap<String, List<Integer>>>();
    static List<String> ListOfFilenames = new ArrayList<String>();
    static int count = 0;
    

    static LinkedHashMap<String, LinkedHashMap<String, List<Integer>>> kmap = new LinkedHashMap<String, LinkedHashMap<String, List<Integer>>>();
    
    public synchronized static void AddMapToList_ofMAP_(
            LinkedHashMap<String, List<Integer>> value, String key) {

        count++;
        MapContainer.add(value);
        ListOfFilenames.add(fileDir1 + "/" + key);

        kmap.put(key, value);
        
        
    }
        

     
        

    public static void main(String args[]) throws InterruptedException {
       // Scanner scan = new Scanner(System.in);
        //String fileDir = scan.nextLine();
       // int charLimit = scan.nextInt();

         String fileDir = args[0];
        int charLimit = Integer.parseInt(args[1]);        
        
        fileDir1 = fileDir;

        long start = System.currentTimeMillis();

        File folder = new File(fileDir);
        File[] listofFiles = folder.listFiles();
        List<File> ji = new ArrayList<File>();
        

        for (File file : listofFiles) {
            if (file.isFile()) {
                // System.out.println(file.getName());
                ji.add(file);
            }
        }
        
        
        
        //based on the size of the file dir, it initiates the number of threads needed       
        myThread[] theWorkers = new myThread[ji.size()];

        for (int i = 0; i < ji.size(); i++) {

            if (ji.get(i).isFile()) {
                
                System.out.println(ji.get(i).getName());
                theWorkers[i] = new myThread(ji.get(i), charLimit);
                theWorkers[i].start();
            }

        }
        // joins the threads one after another
        for (myThread mp : theWorkers) {
            if (mp.isAlive()) {
                mp.join();
            }
        }
        
        // the container where we keep all the word and hashmap
        TreeMap<String, LinkedHashMap<String, List<Integer>>> MasterMap = new TreeMap<String, LinkedHashMap<String, List<Integer>>>(kmap);
        
        Collections.sort(ListOfFilenames);
        // prints the size of map which represents the number of files
        System.out.println("Number of file(s) in directory: "+ MapContainer.size()); 
         
         // a sorted set of files
         SortedSet<String> setOfkeys = new TreeSet<String>();

         for (Entry<String, LinkedHashMap<String, List<Integer>>> entry : MasterMap.entrySet()) {
             for (Entry<String, List<Integer>> innerEntry : entry.getValue().entrySet()) {
                 String innerKey = innerEntry.getKey();
                 setOfkeys.add(innerKey);
             }
         }
         
        // System.out.println(setOfkeys);
             
             
             
             
         File fileTwo = new File(fileDir +"/"
                 + "output.txt");
         
		try {
			
			FileOutputStream fos = new FileOutputStream(fileTwo);
            PrintWriter pw = new PrintWriter(fos);

			  String word;
	             Iterator<String> iter = setOfkeys.iterator();
	             StringBuilder str;
                 //pw.println("Word, " + ListOfFilenames);
                 pw.println("Word, " + ListOfFilenames.toString().replaceAll("[\\[\\](){}]",""));

	             while (iter.hasNext()) {
	            	 str = new StringBuilder("");
	                 word = (String) iter.next();
	                 str.append(word + " ");
	                 
					 // This is to take each outter entry(per file), and the inner entry 
					 // which is (per list) gets each value if match we place the page number in each place
					 // holder per file i.e  word , ,[89,98], ,
	                 for (Entry<String, LinkedHashMap<String, List<Integer>>> entry_Out : MasterMap.entrySet()) {
	                     boolean hasValue = false;
	                     for (Entry<String, List<Integer>> Entry_in : entry_Out.getValue().entrySet()) {
	                         String innerKey = Entry_in.getKey();
	                         if (innerKey.equals(word)) {
	                        	 str.append(Entry_in.getValue().toString());
	                             hasValue = true;
	                         }
	                     }
	                     if (!hasValue) {
	                    	 str.append(", ,");
	                     }
	                 }
			
	                 pw.println(str);
			
	             }
	             
	             pw.flush();
	             pw.close();
	             
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
                 
             
               
          long end = System.currentTimeMillis();
          System.out.println(end - start + " milliseconds");
         
         
         
         
            
             
         
    }
}
