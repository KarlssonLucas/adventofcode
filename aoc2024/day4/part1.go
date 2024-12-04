package main

import (
	"bufio"
	"strings"
)

func xmasFinder(i int, k int, matrix [][]string) int {
	left := [][]int{{i, k - 1}, {i, k - 2}, {i, k - 3}}
	leftup := [][]int{{i - 1, k - 1}, {i - 2, k - 2}, {i - 3, k - 3}}
	up := [][]int{{i - 1, k}, {i - 2, k}, {i - 3, k}}
	rightup := [][]int{{i - 1, k + 1}, {i - 2, k + 2}, {i - 3, k + 3}}
	right := [][]int{{i, k + 1}, {i, k + 2}, {i, k + 3}}
	rightdown := [][]int{{i + 1, k + 1}, {i + 2, k + 2}, {i + 3, k + 3}}
	down := [][]int{{i + 1, k}, {i + 2, k}, {i + 3, k}}
	leftdown := [][]int{{i + 1, k - 1}, {i + 2, k - 2}, {i + 3, k - 3}}

	dirs := [][][]int{left, leftup, up, rightup, right, rightdown, down, leftdown}
	xmass := 0

	for _, dir := range dirs {
		if dir[0][0] < 0 || dir[0][0] >= len(matrix[0]) || dir[0][0] >= len(matrix) ||
			dir[0][1] < 0 || dir[0][1] >= len(matrix[0]) || dir[0][1] >= len(matrix) ||
			dir[1][0] < 0 || dir[1][0] >= len(matrix[0]) || dir[1][0] >= len(matrix) ||
			dir[1][1] < 0 || dir[1][1] >= len(matrix[0]) || dir[1][1] >= len(matrix) ||
			dir[2][0] < 0 || dir[2][0] >= len(matrix[0]) || dir[2][0] >= len(matrix) ||
			dir[2][1] < 0 || dir[2][1] >= len(matrix[0]) || dir[2][1] >= len(matrix) {
			continue
		}

		m := matrix[dir[0][0]][dir[0][1]]
		a := matrix[dir[1][0]][dir[1][1]]
		s := matrix[dir[2][0]][dir[2][1]]

		if m == "M" && a == "A" && s == "S" {
			xmass += 1
		}
	}
	return xmass
}

func part1(scanner *bufio.Scanner) int {
	matrix := [][]string{}

	xmasCount := 0

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		matrix = append(matrix, items)
	}

	for i, line := range matrix {
		for k, item := range line {
			if item == "X" {
				xmasCount += xmasFinder(i, k, matrix)
			}
		}
	}

	return xmasCount
}
