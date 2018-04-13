package com.jigsaw;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Partitioner;

public class VowelPartitioner extends Partitioner<Text, IntWritable> {

	@Override
	public int getPartition(Text key, IntWritable value, int numOfPartitions) {
		// returns 1 or 0
		if (startsWithVowel(key)) {
			return numOfPartitions % 2;
		}
		return numOfPartitions % 2 + 1;

	}

	private boolean startsWithVowel(Text key) {

		if (key == null || key.toString().isEmpty())
			return false;

		char c = key.toString().toUpperCase().charAt(0);

		if ((c == 'A') || (c == 'E') || (c == 'I') || (c == 'O') || (c == 'U'))
			return true;

		return false;
	}

}
