package com.jigsaw;

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.conf.*;
import org.apache.hadoop.fs.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.lib.input.*;
import org.apache.hadoop.mapreduce.lib.output.*;
import org.apache.hadoop.util.*;



public class MapReduceTemplate extends Configured implements Tool {

	public static class MapperClass
			extends
			Mapper<MapInputKeyType, MapInputValueType, MapOutputKeyType, MapOutputValueType> {
		/* Delarations, if any */
		protected void setup(Context context) throws IOException,
				InterruptedException {

			/*
			 * pre-mapper configuration like configuring Hbase table or get
			 * properties configured of passed from command line
			 */

		}

		public void map(MapInputKeyType key, MapInnputValueType value,
				Context context) throws IOException, InterruptedException {

			/* Map Function Logic */
			/* Write output key value pairs */
			/* context.write(key, value); */
		}

		protected void cleanup(Context context) throws IOException,
				InterruptedException {

			/*
			 * Post mapper run clean up if requried like closing a Hbase table
			 * connection
			 */
		}

	}

	public static class ReducerClass
			extends
			Reducer<ReduceInputKeyType, ReduceInputValueType, ReduceOutputKeyType, ReduceOutputValueType> {
		/* Declartions, if any */

		protected void setup(Context context) throws IOException,
				InterruptedException {
			/*
			 * Pre-reducer configurations like configuring Hbase table or get
			 * properties configured or passed from a commmand line
			 */

		}

		public static void reduce(ReduceInputKeyType key,
				Iterable<ReduceInputValueType> values, Context context)
				throws IOException, InterruptedException {
			/* Reduce function logic */
			/*
			 * iterate through each value and process them one by one. for(Text
			 * value : values){ process individual value }
			 */
			/* Wrie Reduce Output Key value pairs */
			/* context.write(key, value); */
		}

	}

	public static void main(String[] args) throws Exception {
		/*
		 * Trigger the driver progress. Just need to change the name of the name
		 * of the class to the outermost class name
		 */
		System.exit(ToolRunner.run(new Configuration(),
				new MapReduceTemplate(), args));
	}

	public int run(String[] args) throws Exception {

		/* Driver Program */
		/* Create Configuration Object */
		Configuration conf = new Configuration();
		/*
		 * Access argumemnt passed when the MapREduce job is triggered from
		 * command line
		 */

		String[] otherArgs = new GenericOptionsParser(conf, args)
				.getRemainingArgs();

		if (otherArgs.length != 2) {
			System.exit(2);
		}
		
		
		
		
		
		/*set additional properties if required.*/
		/*conf.set("property_name","value");*/
		
		
		Job job = new Job(conf," Name of MapReduce Job");
		/*set the required class names. This need to be changed to the names of the mapper and reducer classes */
		job.setJarByClass(MapReduceTemplate.class);
		job.setMapperClass(MapperClass.class);
		job.setReducerClass(ReducerClass.class);
		/*Set the number of reduce tasks*/
		job.setNumReduceTasks(1);

		/*set the map output key and value types*/
		job.setMapOutputKeyClass(NullWritable.class);
		job.setMapOutputValueClass(Text.class);	
		
		/*set the reducer output key and value types*/
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		
		
		/*set the input and output formats and also the input and output paths*/
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));

		/*run the job wait for compleion*/
		return (job.waitForCompletion(true) ? 0 : 1);	

	}
}
