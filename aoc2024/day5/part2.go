package main

import (
	"bufio"
	"fmt"
	"slices"
	"strconv"
	"strings"
)

func part2(scanner *bufio.Scanner) int {
	rules := [][]int{}

	result := []int{}

	for scanner.Scan() {
		line := scanner.Text()

		if strings.Contains(line, "|") {
			items := strings.Split(line, "|")
			x, _ := strconv.Atoi(items[0])
			y, _ := strconv.Atoi(items[1])
			list := []int{x, y}
			rules = append(rules, list)
		} else {
			items := strings.Split(line, ",")
			unsorted := toIntList(items)
			orig := make([]int, len(unsorted))
			_ = copy(orig, unsorted)

			for _, rule := range rules {
				unsorted = applyRule(rule, unsorted)
			}

			fmt.Println(unsorted, orig)
			if !slices.Equal(orig, unsorted) {
				elem := unsorted[len(unsorted)/2]
				result = append(result, elem)
			}
		}
	}

	sum := 0
	for _, item := range result {
		sum += item
	}

	return sum
}
