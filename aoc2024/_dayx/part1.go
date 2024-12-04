package main

import (
	"bufio"
	"fmt"
	"strings"
)

func part1(scanner *bufio.Scanner) string {

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, ",")
		fmt.Println(items)
	}

	return ("part1")
}
