package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	file, ferr := os.Open("input")
	if ferr != nil {
		panic(ferr)
	}

	file2, ferr := os.Open("input")
	if ferr != nil {
		panic(ferr)
	}

	scanner := bufio.NewScanner(file)
	scanner2 := bufio.NewScanner(file2)

	part1_answer := part1(scanner)
	fmt.Printf("Part1 answer: %s\n", strconv.Itoa(part1_answer))

	part2_answer := part2(scanner2)
	fmt.Printf("Part2 answer: %s\n", strconv.Itoa(part2_answer))
}
