package main

import (
	"bufio"
	"strconv"
	"strings"
)

func checkRemovalSafe(int_items []int) bool {
	var combinations [][]int

	for i := 0; i < len(int_items); i++ {
		combination := append([]int{}, int_items[:i]...)
		combination = append(combination, int_items[i+1:]...)
		combinations = append(combinations, combination)
	}

	for _, comb := range combinations {
		if checkSafe(comb) {
			return true
		}
	}
	return false
}

func part2(scanner *bufio.Scanner) int {
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
		} else if checkRemovalSafe(int_items) {
			safe += 1
		}
	}

	return safe
}
