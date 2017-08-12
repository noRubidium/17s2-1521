#include <stdio.h>
#include <stdlib.h>

/*
FFFF
1111 1111 1111 1111
0000 0000 0000 0000
+ 1
-1

8000
1000 0000 0000 0000
0111 1111 1111 1111
 + 1
1000 0000 0000 0000
- (2 ** 15)
*/
/*
0 7bit
110x xxxx 10xx xxxx 110x xxxx
1110 xxxx 10xx xxxx 10xx xxxx
1111 0xxx 10xx xxxx 10xx xxxx 10xx xxxx
*/

typedef unsigned char uchar;

int unicodeNbytes(unsigned char *str);
int unicodeNsymbols(unsigned char *str);

void unicode2html(uchar *);

int main(int argc, char const *argv[]) {
  unsigned char unicodeStr[] = {'a', 'b', 'c', '\xE2', '\x86', '\xAB', 'd', 'e', 'f', '\0'};
  printf("String \"%s\" contains %d bytes\n", unicodeStr, unicodeNbytes(unicodeStr));
  printf("String \"%s\" contains %d unicode symbols\n", unicodeStr, unicodeNsymbols(unicodeStr));

  uchar s[10] = {'a','b','c','\xC2','\xA2','d','e','f','\0'};
  uchar t[10] = {'a','b','c','\xE2','\x86','\xAB','d','e','f','\0'};

  unicode2html(s); printf("\n");
  unicode2html(t); printf("\n");
  return 0;
}


int unicodeNbytes(unsigned char *str) {
  size_t len = 0;
  while (*str != '\0') {
    str = str + 1;
    len = len + 1;
  }
  return len;
}


#define ASCII 0b10000000
#define MASK_2 0b11000000
#define MASK_3 0b11100000
#define MASK_4 0b11110000

int unicodeNsymbols(unsigned char *str) {
  size_t len = 0;
  while (*str != '\0') {
    unsigned char c = *str;
    // 1110 XXXX
    if ((c & ASCII) == 0) {
      str = str + 1;
    } else if ((c & MASK_4) == MASK_4) {
      str = str + 4;
    } else if ((c & MASK_3) == MASK_3) {
      str = str + 3;
    } else if ((c & MASK_2) == MASK_2) {
      str = str + 2;
    } else {
      printf("SOMETHING WENT WRONG!\n");
    }
    len = len + 1;
  }
  return len;
}

#define LOW_3 0b00000111
#define LOW_4 0b00001111
#define LOW_5 0b00011111
#define MASK_X 0b00111111


void unicode2html(uchar *str) {
  while (*str != '\0') {
    unsigned char c = *str;
    unsigned char bytes[4] = {0};
    // 1110 XXXX
    if ((c & ASCII) == 0) {
      printf("%c", c);
      str = str + 1;
      continue;
    } else if ((c & MASK_4) == MASK_4) {
      bytes[0] = LOW_3 & (*str);
      str = str + 1;
      bytes[1] = MASK_X & (*str);
      str = str + 1;
      bytes[2] = MASK_X & (*str);
      str = str + 1;
      bytes[3] = MASK_X & (*str);
      str = str + 1;
    } else if ((c & MASK_3) == MASK_3) {
      bytes[1] = LOW_4 & (*str);
      str = str + 1;
      bytes[2] = MASK_X & (*str);
      str = str + 1;
      bytes[3] = MASK_X & (*str);
      str = str + 1;
    } else if ((c & MASK_2) == MASK_2) {
      bytes[2] = LOW_5 & (*str);
      str = str + 1;
      bytes[3] = MASK_X & (*str);
      str = str + 1;
    } else {
      printf("SOMETHING WENT WRONG!\n");
    }
    unsigned int x = 0;
    x = bytes[0] << 18;
    x |= bytes[1] << 12;
    x |= bytes[2] << 6;
    x |= bytes[3];
    printf("&#%04X;", x);
  }
}
