package com.jigsaw;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class NumericalSummarization extends Configured implements Tool{
	
	public static class NSMapper extends Mapper<Object, Text, Text, NSTuple> {
// Our output key and value Writables
		private Text outUserId = new Text();
		private NSTuple outTuple = new NSTuple();

// This object will format the creation date string into a Date object
		private final static SimpleDateFormat frmt = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");

		@Override
		public void map(Object key, Text value, Context context) throws IOException, InterruptedException {

	// Parse the input string into a nice map
			Map<String, String> parsed = MRUtils.transformXmlToMap(value.toString());

	// Grab the "CreationDate" field since it is what we are finding
	// the min and max value of
			String strDate = parsed.get("CreationDate");

	// Grab the �UserID� since it is what we are grouping by
			String userId = parsed.get("UserId");

	// .get will return null if the key is not there
			if (strDate == null || userId == null) {
		// skip this record
				return;
			}
			try {
		// Parse the string into a Date object
				Date creationDate = frmt.parse(strDate);

		// Set the minimum and maximum date values to the creationDate
				outTuple.setMin(creationDate);
				outTuple.setMax(creationDate);
		
				// Set the comment count to 1
				outTuple.setCount(1);
		
				// Set our user ID as the output key
				outUserId.set(userId);
		
				// Write out the user ID with min max dates and count
				context.write(outUserId, outTuple);
			} catch (ParseException e) {
		// An error occurred parsing the creation Date string
		// skip this record
			}
		}
	}

	public static class NSReducer extends Reducer<Text, NSTuple, Text, NSTuple> {
		private NSTuple result = new NSTuple();
	
		@Override
		public void reduce(Text key, Iterable<NSTuple> values,
				Context context) throws IOException, InterruptedException {
		
		// Initialize our result
			result.setMin(null);
			result.setMax(null);
			int sum = 0;
		
			// Iterate through all input values for this key
			for (NSTuple val : values) {
				// If the value's min is less than the result's min
				// Set the result's min to value's
				if (result.getMin() == null
						|| val.getMin().compareTo(result.getMin()) < 0) {
					result.setMin(val.getMin());
				}
		
				// If the value's max is less than the result's max
				// Set the result's max to value's
				if (result.getMax() == null
						|| val.getMax().compareTo(result.getMax()) > 0) {
					result.setMax(val.getMax());
				}
		
				// Add to our sum the count for val
				sum += val.getCount();
			}
		
			// Set our count to the number of input values
			result.setCount(sum);
			context.write(key, result);
		}
	}	
	
	public int run(String[] args) throws Exception {
		//Driver for the MapReduce job
		Configuration conf = getConf();
		Job job = new Job(conf);

		job.setJarByClass(NumericalSummarization.class);
		FileInputFormat.addInputPath(job, new Path(args[0]));
		
		
		job.setMapperClass(NSMapper.class);
		job.setReducerClass(NSReducer.class);

		FileOutputFormat.setOutputPath(job, new Path(args[1]));

		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(NSTuple.class);	
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(NSTuple.class);
		job.setNumReduceTasks(1);
		return (job.waitForCompletion(true) ? 0 : 1);	
	}
	
    public static void main(String[] args) throws Exception {
		System.exit(ToolRunner.run(new Configuration(), new NumericalSummarization(), args));
	}
    
	public static class NSTuple implements Writable {
		private Date min = new Date();
		private Date max = new Date();
		private long count = 0;

		private final static SimpleDateFormat frmt = new SimpleDateFormat(
				"yyyy-MM-dd'T'HH:mm:ss.SSS");

		public Date getMin() {
			return min;
		}

		public void setMin(Date min) {
			this.min = min;
		}

		public Date getMax() {
			return max;
		}

		public void setMax(Date max) {
			this.max = max;
		}

		public long getCount() {
			return count;
		}

		public void setCount(long count) {
			this.count = count;
		}

		@Override
		public void readFields(DataInput in) throws IOException {
			min = new Date(in.readLong());
			max = new Date(in.readLong());
			count = in.readLong();
		}

		@Override
		public void write(DataOutput out) throws IOException {
			out.writeLong(min.getTime());
			out.writeLong(max.getTime());
			out.writeLong(count);
		}

		@Override
		public String toString() {
			return frmt.format(min) + "\t" + frmt.format(max) + "\t" + count;
		}
	}
}