package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func zerofile(filename string) bool {
	data, error := ioutil.ReadFile(filename)
	check(error)
	for _, byte := range data {
		if byte != 0 {
			return false
		}
	}
	return true
}

func main() {
	filename := os.Args[1]
	if zerofile(filename) {
		fmt.Println(filename)
	}
}
