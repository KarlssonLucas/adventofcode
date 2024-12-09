package main

import (
	"bufio"
	"strconv"
	"strings"
)

func calcnew(val []int, calcs []int) []int {
	if len(val) == 0 {
		return calcs
	}

	new_calcs := []int{}

	curr := val[0]
	val = val[1:]

	if len(calcs) == 0 {
		new_calcs = append(new_calcs, curr)
		return calcnew(val, new_calcs)
	}

	for _, cal := range calcs {
		new_calcs = append(new_calcs, cal+curr)
		new_calcs = append(new_calcs, cal*curr)

		str1 := strconv.Itoa(cal)
		str2 := strconv.Itoa(curr)
		value, _ := strconv.Atoi(str1 + str2)

		new_calcs = append(new_calcs, value)
	}

	return calcnew(val, new_calcs)
}

func part2(scanner *bufio.Scanner) int {

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
		calcs := calcnew(eq.numbers, []int{})
		for _, c := range calcs {
			if c == eq.value {
				sum += eq.value
				break
			}
		}
	}

	return sum
}
