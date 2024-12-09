package main

import (
	"bufio"
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

type equation struct {
	value   int
	numbers []int
}

func calc(val []int, calcs []int) []int {
	if len(val) == 0 {
		return calcs
	}

	new_calcs := []int{}

	curr := val[0]
	val = val[1:]

	if len(calcs) == 0 {
		new_calcs = append(new_calcs, curr)
		return calc(val, new_calcs)
	}

	for _, cal := range calcs {
		new_calcs = append(new_calcs, cal+curr)
		new_calcs = append(new_calcs, cal*curr)
	}

	return calc(val, new_calcs)
}

func part1(scanner *bufio.Scanner) int {

	equations := []equation{}
	sum := 0

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, ":")

		value, _ := strconv.Atoi(items[0])

		nos := strings.Split(items[1], " ")
		int_nos := toIntList(nos[1:])
		equations = append(equations, equation{value: value, numbers: int_nos})
	}

	for _, eq := range equations {
		calcs := calc(eq.numbers, []int{})
		for _, c := range calcs {
			if c == eq.value {
				sum += eq.value
				break
			}
		}
	}

	return sum
}
