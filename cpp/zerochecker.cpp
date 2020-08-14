#include <iostream>
#include <fstream>

using namespace std;

int main(int argc, char *argv[]) {

  if (argc != 2) {
    cerr << "No filename specified" << endl;
    return 1;
  }

  char *filename=argv[1];

  ifstream thefile;
  char stream_buffer[4096];
  thefile.rdbuf()->pubsetbuf(stream_buffer, sizeof(stream_buffer));
  thefile.open(filename, ios::in | ios::binary);

  while (!thefile.eof()) {
    char thisbyte;
    thefile >> thisbyte;
    if (thisbyte != 0) {
      thefile.close();
      return 1;
    }
  }

  cout << filename << endl;
  thefile.close();
}
