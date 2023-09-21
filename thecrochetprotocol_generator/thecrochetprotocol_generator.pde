/*The Crochet Protocol V1
Generator for random crochet pattern instructions.
Julia Vollmer 2022-2023
*/

//stich count tracking
int stcount = 0;
int oldcount = 0;
int filenumber = 1;
int stitchmargin = 5;

int[] protocols ={};
int[] row = {};
String[] names = {};
String[] rownames = {};
boolean firstrow =true;
int rowsnb;


//crochet instructions broken down
int[] ch = {2, 3};
int[] slst = {1, 2, 3, 3};
int[] sc = {1, 2, 3, 2, 3, 3};
int[] hdc = {2, 1, 2, 3, 2, 3, 3, 3};
int[] dc = {2, 1, 2, 3, 2, 3, 3, 2, 3, 3};
int[] tr = {2, 2, 1, 2, 3, 2, 3, 3, 2, 3, 3, 2, 3, 3};
int[] sc2tog = {1, 2, 3, 4, 1, 2, 3, 2, 3, 3, 3};
int[] sc3tog = {1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 2, 3, 3, 3, 3};
int[] dc2tog = {2, 1, 2, 3, 2, 3, 3, 4, 2, 1, 2, 3, 2, 3, 3, 2, 3, 3, 3};
int[] dc3tog = {2, 1, 2, 3, 2, 3, 3, 4, 2, 1, 2, 3, 2, 3, 3, 4, 2, 1, 2, 3, 2, 3, 3, 2, 3, 3, 3, 3};
int[] dcc3 = {2, 1, 2, 3, 2, 3, 3, 4, 2, 1, 2, 3, 2, 3, 3, 4, 2, 1, 2, 3, 2, 3, 3, 2, 3, 3, 3, 3, 2, 3, 2, 3};
int[] puff = {2, 1, 2, 3, 2, 3, 3, 2, 1, 2, 3, 2, 3, 3, 2, 1, 2, 3, 2, 3, 3, 2, 3, 3, 3, 3};
int[] picot = {2, 3, 2, 3, 2, 3, 5, 5, 5, 1, 2, 3, 3};
int[] fpdc = {2, 6, 6, 1, 2, 3, 2, 3, 3, 2, 3, 3};
int[] bpdc = {2, 7, 7, 1, 2, 3, 2, 3, 3, 2, 3, 3};

String[] instructionname = {"pause", "insert", "loop", "pull through", "left", "right", "front", "back"};
String[] instructionsymbols = {"", "■", "○", "●", "←", "→", "↓", "↑"};

//2-5 times dc shell
int[] shell() {
  int ran = int(random(2, 6)); //size of the shell
  stcount = stcount + ran;
  int[] ns = new int[ran * 10];
  int[] pos = {2, 1, 2, 3, 2, 3, 3, 2, 3, 3};
  for (int i = 0; i < (ran * 10); i++) {
    ns[i] = pos[i % 10];
  };
  return ns;
};

//magic ring
int[] mr() {
  int ran = int(random(3, 9));
  stcount = ran*2;
  int[] nm = new int[ran * 6];
  int[] pos = {1, 2, 3, 2, 3, 3};
  for (int i = 0; i < (ran * 6); i++) {
    if (i < 5) {
      nm[i] = pos[i % 6];
    } else {
      nm[i] = pos[i+1 % 6];
    };
  };
  return nm;
};
//direction change
int[] dir() {
  int ran = int(random(4, 6)); //left or right
  int[] nd = {2, 3, ran};
  return nd;
};

int back = 6;
int front = 7;


void setup() {
  noLoop();
  protocol();
  filenumber++;
}
void draw() {
}

void protocol() {
  //start
  int chainlength = int(random(10, 15)); //define starting chain length
  rowsnb = int(random(5, 10)); //define max row number; can be adjusted
  stcount = chainlength;
  //starting chain
  for (int i=0; i <= chainlength; i++) {
    protocols = concat(protocols, ch);
    names = append(names, "ch");
  }
  
  while (rowsnb >=0) {
    oldcount = stcount;
    //create row style
    for (int j=0; j<= oldcount; j++) {
      int stitch = 1;
      if (random(1)<0.7 || firstrow) {
        stitch=int(random(1, 6));
      } else {
        stitch = int(random(16));
      }
      crochet(stitch);
      if (random(1)<0.9) { //move forward in the project
        row = append(row, 4);
        rownames = append(rownames, "left");
      }
    }
    if (random(1)<0.2) { //working in the back or front loop only
      if (random(1)<0.5) {
        row = append(row, 6);
        rownames = append(rownames, "front");
      } else {
        row = append(row, 7);
        rownames = append(rownames, "back");
      }
    }

    while (stcount <= oldcount-stitchmargin || stcount >= oldcount+stitchmargin) {

      if (stcount < oldcount) {
        crochet(1);
        stcount++;
      } else if (stcount > oldcount) {
        crochet(8);
      }
    }

      row = concat(row, dir());
      rownames = append(rownames, "turn");
    //add this row a random amount of time
    int rowscount = int(random(rowsnb))+1;
    
    
    for (int k=0; k<rowscount; k++) {
      protocols = concat(protocols, row);
      names = concat(names, rownames);
      firstrow = false;
    }
    rowsnb = rowsnb-rowscount;
  }
  //finish off
  
  protocols[protocols.length-1] = 3;
  names[names.length-1] = "pull through";
  
  String[] prot = str(protocols);
  String number = join(prot, " "); 
  String[] numbers = {number};
  saveStrings(str(filenumber)+".txt", numbers);
  
  String[] basic = {};
  String symbol = "";
  for (int i=0; i < protocols.length; i++){
      basic = append(basic, instructionname[protocols[i]]);
      symbol = symbol + instructionsymbols[protocols[i]] + " ";
  }
  String basicin = join(basic, " ");
  String[] basics = {basicin}; 
  saveStrings(str(filenumber)+"_t.txt", basics);
  
  String[] symbols = {symbol};
  saveStrings(str(filenumber)+"_s.txt", symbols);
  println("Saving done");
  
}

void crochet(int n) {
  switch(n) {
  case 0:
    row = concat(row, slst);
    rownames = append(rownames, "slst");
    break;
  case 1:
    row = concat(row, ch);
    rownames = append(rownames, "ch");
    break;

  case 2:
    row = concat(row, sc);
    rownames = append(rownames, "sc");
    break;
  case 3:
    row = concat(row, hdc);
    rownames = append(rownames, "hdc");
    break;
  case 4:
    row = concat(row, dc);
    rownames = append(rownames, "dc");
    break;
  case 5:
    row = concat(row, tr);
    rownames = append(rownames, "tr");
    break;
  case 6:
    row = concat(row, sc2tog);
    rownames = append(rownames, "sc2tog");
    stcount--;
    break;
  case 7:
    row = concat(row, sc3tog);
    rownames = append(rownames, "sc3tog");
    stcount = stcount-2;
    break;
  case 8:
    row = concat(row, dc2tog);
    rownames = append(rownames, "dc2tog");
    stcount--;
    break;
  case 9:
    row = concat(row, dc3tog);
    rownames = append(rownames, "dc3tog");
    stcount = stcount-2;
    break;
  case 10:
    row = concat(row, dcc3);
    rownames = append(rownames, "3-dc");
    break;
  case 11:
    row = concat(row, puff);
    rownames = append(rownames, "puff");
    break;
  case 12:
    row = concat(row, picot);
    rownames = append(rownames, "picot");
    break;
  case 13:
    row = concat(row, fpdc);
    rownames = append(rownames, "fpdc");
    break;
  case 14:
    row = concat(row, bpdc);
    rownames = append(rownames, "bpdc");
    break;
  case 15:
    row = concat(row, shell());
    rownames = append(rownames, "shell");
    break;
  };
}
