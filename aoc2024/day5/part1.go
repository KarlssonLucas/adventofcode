package main

import (
	"bufio"
	"slices"
	"strconv"
	"strings"
  "sort"
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
  sort.SliceStable(S, func(i, j int) bool {
    if rule[0] == S[i] && rule[1] == S[j] {
      return i > j
    }
    return false
  })
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
