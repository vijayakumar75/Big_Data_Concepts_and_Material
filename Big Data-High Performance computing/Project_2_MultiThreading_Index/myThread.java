import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Scanner;

public class myThread extends Thread{
    

    private File file;
    private int charLimit;
    
    
    public myThread(File file, int charLimit){
        this.file = file;
        this.charLimit = charLimit;
    }
    
  
    public void run(){

        Scanner input = null;
        try {
            input = new Scanner((file));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        List<String> list = new ArrayList<String>();
        LinkedHashMap<String, List<Integer>> map = new LinkedHashMap<String, List<Integer>>();

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
        
        // adds the map of file's words via synchronized methods
    myRunner.AddMapToList_ofMAP_(map, file.getName());
    //System.out.println(map.size());


        
            
         


    }

     
    
    
}