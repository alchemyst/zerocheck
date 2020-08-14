use std::env;
use std::fs;

// Maybe consider using std::io::bufreader?

fn main() {
    let args: Vec<String> = env::args().collect();

    let filename = &args[1];

    // println!("Reading {}", filename);

    let contents = fs::read(filename);

    let mut allzeros = true;

    for byte in contents.unwrap() {
        if byte != b'\0' {
            allzeros = false;
            break;
        }
    }

    if allzeros {
        println!("{}", filename);
    }
}
 
