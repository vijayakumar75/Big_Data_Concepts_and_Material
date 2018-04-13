import sys
import re


vowels = "aeiouyAEIOUY"
def main(argv):


        line = sys.stdin.readline()

        pattern = re.compile("[a-zA-Z0-9]+")
        #words = []


        while line:

            for word in pattern.findall(line):
                words = []
                #words.append(word.lower())

                for ch in word:
                    if(ch in vowels):
                        words.append(ch)

                words.sort()
                #print(words)

                wordBuild = ""
                for letter in words:
                    wordBuild = wordBuild + letter

                print(wordBuild + "\t" + str(len(words)))
            line = sys.stdin.readline()




if __name__ == "__main__":
    main(sys.argv)
