package main

import (
	"bufio"
	"strconv"
	"strings"
)

func count_occ(item int, items []int) int {
	occ := 0
	for _, it := range items {
		if it == item {
			occ += 1
		}
	}
	return occ
}

func part2(scanner *bufio.Scanner) int {
	ma := [][]int{}
	sim := 0

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "   ")
		int_items := []int{}
		for _, item := range items {
			int_item, _ := strconv.Atoi(item)
			int_items = append(int_items, int_item)
		}
		ma = append(ma, int_items)
	}

	ma = transpose(ma)

	for _, item := range ma[0] {
		occ := count_occ(item, ma[1])
		sim += occ * item
	}

	return sim
}
