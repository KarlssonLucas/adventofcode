package main

import (
	"bufio"
	"regexp"
	"strconv"
)

func part1(scanner *bufio.Scanner) int {
	sum := 0

	for scanner.Scan() {
		line := scanner.Text()
		regex := regexp.MustCompile(`(mul\((?P<X>\d+),(?P<Y>\d+)\))`)
		res := regex.FindAllStringSubmatch(line, 9999999)

		for _, item := range res {
			x := item[2]
			int_x, _ := strconv.Atoi(x)
			y := item[3]
			int_y, _ := strconv.Atoi(y)
			sum += int_x * int_y
		}
	}

	return sum
}
