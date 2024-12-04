package main

import (
	"bufio"
	"slices"
	"strconv"
	"strings"
)

func Abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func transpose(slice [][]int) [][]int {
	xl := len(slice[0])
	yl := len(slice)
	result := make([][]int, xl)
	for i := range result {
		result[i] = make([]int, yl)
	}
	for i := 0; i < xl; i++ {
		for j := 0; j < yl; j++ {
			result[i][j] = slice[j][i]
		}
	}
	return result
}

func part1(scanner *bufio.Scanner) int {
	ma := [][]int{}
	dst := 0

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
	slices.Sort(ma[0])
	slices.Sort(ma[1])

	for i, item := range ma[0] {
		dst += Abs(item - ma[1][i])
	}

	return (dst)
}
