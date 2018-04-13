

package com.jigsaw;

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

import com.jigsaw.MRUtils;

public class TopN extends Configured implements Tool {

	public static class TopNMapper extends Mapper<IntWritable, Text, NullWritable, Text> {
		private Integer FilterCount;
		
		protected void setup(Context context) throws IOException,InterruptedException {
			String strFilterCount = context.getConfiguration().get("filter_n_records");
			FilterCount = Integer.parseInt(strFilterCount);
		}
		
		private TreeMap<Integer, Text> TopNMap = new TreeMap<Integer, Text>();
		
		public void map(Object key, Text value, Context context)
			throws IOException, InterruptedException {
			Map<String, String> parsed = MRUtils.transformXmlToMap(value.toString());
			
			String reputation = parsed.get("Reputation");
			if (reputation == null){
				return;
			}
			TopNMap.put(Integer.parseInt(reputation), new Text(value));
			if (TopNMap.size() > FilterCount) {
				TopNMap.remove(TopNMap.firstKey());
			}
		}
		protected void cleanup(Context context) throws IOException, InterruptedException {
			for (Text t : TopNMap.values()) {
				context.write(NullWritable.get(), t);
			}
		}
	}

	public static class TopNReducer extends Reducer<NullWritable, Text, Text, IntWritable> {
		private Integer FilterCount;
		
		protected void setup(Context context) throws IOException, InterruptedException{
			String strFilterCount = context.getConfiguration().get("filter_n_records");
			FilterCount = Integer.parseInt(strFilterCount);
		}
	// Stores a map of user reputation to the record
	// Overloads the comparator to order the reputations in descending order
		private TreeMap<Integer, Text> TopNMap = new TreeMap<Integer, Text>();
		
		public void reduce(NullWritable key, Iterable<Text> values,Context context) throws IOException, InterruptedException {
			for (Text value : values) {
				Map<String, String> parsed = MRUtils.transformXmlToMap(value.toString());
				String reputation = parsed.get("Reputation");
				if (reputation == null){
					return;
				}
				TopNMap.put(Integer.parseInt(reputation),	new Text(parsed.get("DisplayName")));
				if (TopNMap.size() > FilterCount) {
					TopNMap.remove(TopNMap.firstKey());
				}
			}

			for(Integer keys : TopNMap.descendingMap().keySet() ){
				context.write(TopNMap.get(keys),new IntWritable(keys));
			}
		}
	}

	public int run(String[] args) throws Exception {
		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, args)
				.getRemainingArgs();
		if (otherArgs.length != 2) {
			System.exit(2);
		}
		conf.set("filter_n_records","10");
	
		@SuppressWarnings("deprecation")
		Job job = new Job(conf, "Top N");
		job.setJarByClass(TopN.class);
		job.setMapperClass(TopNMapper.class);
		job.setReducerClass(TopNReducer.class);
		job.setNumReduceTasks(1);
		
		job.setMapOutputKeyClass(NullWritable.class);
		job.setMapOutputValueClass(Text.class);
		
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
		FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
		return (job.waitForCompletion(true) ? 0 : 1);			
	}
	
	public static void main(String[] args) throws Exception {
		System.exit(ToolRunner.run(new Configuration(), new TopN(), args));
	}
}