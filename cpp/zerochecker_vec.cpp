#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int main(int argc, char *argv[]) {

  if (argc != 2) {
    cerr << "No filename specified" << endl;
    return 1;
  }

  char *filename=argv[1];

  ifstream thefile(filename, ios::in | ios::binary);
  vector<char> contents((istreambuf_iterator<char>(thefile)), istreambuf_iterator<char>());

  for (char thisbyte: contents) {
    if (thisbyte != 0) {
      thefile.close();
      return 1;
    }
  }

  cout << filename << endl;
  thefile.close();
}
