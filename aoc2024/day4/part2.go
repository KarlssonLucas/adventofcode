package main

import (
	"bufio"
	"strings"
)

func checkDir(dir [][]int, matrix [][]string) bool {
	m := matrix[dir[0][0]][dir[0][1]]
	a := matrix[dir[1][0]][dir[1][1]]
	s := matrix[dir[2][0]][dir[2][1]]

	if m == "M" && a == "A" && s == "S" {
		return true
	}
	return false
}

func getDirs(i int, k int) [][][]int {
	rightup := [][]int{{i + 2, k}, {i + 1, k + 1}, {i, k + 2}}
	rightdown := [][]int{{i, k}, {i + 1, k + 1}, {i + 2, k + 2}}
	leftdown := [][]int{{i, k + 2}, {i + 1, k + 1}, {i + 2, k}}
	leftup := [][]int{{i + 2, k + 2}, {i + 1, k + 1}, {i, k}}

	dirs := [][][]int{rightup, rightdown, leftdown, leftup}
	return dirs
}

func masfinder(i int, k int, matrix [][]string) int {
	dirs := getDirs(i, k)

	count := 0
	for _, dir := range dirs {
		if checkDir(dir, matrix) {
			count += 1
		}
	}

	if count >= 2 {
		return 1
	}
	return 0
}

func part2(scanner *bufio.Scanner) int {
	matrix := [][]string{}

	xmasCount := 0

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		matrix = append(matrix, items)
	}

	for i, line := range matrix {
		if i < len(matrix)-2 {
			for k, _ := range line {
				if k < len(line)-2 {
					xmasCount += masfinder(i, k, matrix)
				}
			}
		}
	}

	return xmasCount
}
