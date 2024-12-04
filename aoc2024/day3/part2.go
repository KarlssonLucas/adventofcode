package main

import (
	"bufio"
	"regexp"
	"strconv"
)

func part2(scanner *bufio.Scanner) int {
	sum := 0
	matches := [][]string{}
	for scanner.Scan() {
		line := scanner.Text()
		regex := regexp.MustCompile(`(mul\((?P<X>\d+),(?P<Y>\d+)\))|do\(\)|don\'t\(\)`)
		res := regex.FindAllStringSubmatch(line, 9999999)
		matches = append(matches, res...)
	}
	current := "do"
	for _, item := range matches {
		if item[0] == "do()" {
			current = "do"
		} else if item[0] == "don't()" {
			current = "dont"
		} else {
			if current == "do" {
				x := item[2]
				int_x, _ := strconv.Atoi(x)
				y := item[3]
				int_y, _ := strconv.Atoi(y)
				sum += int_x * int_y
			}
		}
	}

	return sum
}
