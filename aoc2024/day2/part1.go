package main

import (
	"bufio"
	"strconv"
	"strings"
)

func checkDir(first int, second int) int {
	dir := 0
	if 0 < (first-second) && (first-second) < 4 {
		dir = 1
	} else if (first-second) < 0 && (first-second) > -4 {
		dir = 0
	} else {
		return 2 //exit
	}
	return dir
}

func checkSafe(int_items []int) bool {
	dir := checkDir(int_items[0], int_items[1])

	for i := 0; i < len(int_items)-1; i++ {

		if checkDir(int_items[i], int_items[i+1]) == 2 {
			return false
		} else if checkDir(int_items[i], int_items[i+1]) != dir {
			return false
		}
	}
	return true
}

func part1(scanner *bufio.Scanner) int {
	safe := 0

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, " ")
		int_items := []int{}
		for _, item := range items {
			int_item, _ := strconv.Atoi(item)
			int_items = append(int_items, int_item)
		}

		if checkSafe(int_items) {
			safe += 1
		}
	}

	return safe
}
