import sys
import re


vowels = "aeiouyAEIOUY"
#returns the number of vowels in a given word
def vowelNum(word):
    vowelCountPerWord = []
    for letter in word:
        if letter in vowels:
            vowelCountPerWord.append(letter)
    return(len(vowelCountPerWord))


def main(argv):


        line = sys.stdin.readline()

        pattern = re.compile("[a-zA-Z0-9]+")
        words = []

        #while each line, we get grab a word and put each word in a custom method vowelNum that returns the lenght of the vowels
        while line:
            for word in pattern.findall(line):
                words.append(word.lower())
                print(word + "\t"  + str(vowelNum(word)))
            line = sys.stdin.readline()



if __name__ == "__main__":
    main(sys.argv)
