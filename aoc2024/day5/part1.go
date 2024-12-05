package main

import (
	"bufio"
	"fmt"
	"slices"
	"strconv"
	"strings"
)

func toIntList(ss []string) []int {
	new_list := []int{}
	for _, s := range ss {
		int_s, _ := strconv.Atoi(s)
		new_list = append(new_list, int_s)
	}
	return new_list
}

func applyRule(rule []int, S []int) []int {
	for i := len(S); i > 0; i-- {
		for j := 1; j < i; j++ {
			if S[j-1] == rule[1] && S[j] == rule[0] {
				intermediate := S[j]
				S[j] = S[j-1]
				S[j-1] = intermediate
			}
		}
	}

	return S
}

func part1(scanner *bufio.Scanner) int {
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
			if slices.Equal(orig, unsorted) {
				elem := orig[len(orig)/2]
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
