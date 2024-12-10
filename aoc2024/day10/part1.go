package main

import (
	"bufio"
	"strconv"
	"strings"
)

type pos []int

func toIntList(ss []string) []int {
	new_list := []int{}
	for _, s := range ss {
		int_s, _ := strconv.Atoi(s)
		new_list = append(new_list, int_s)
	}
	return new_list
}

func getAbove(row, col int, trails [][]int) (int, int, int) {
	if row-1 >= len(trails) || row-1 < 0 {
		return -1, -1, -1
	} else {
		return row - 1, col, trails[row-1][col]
	}
}

func getRight(row, col int, trails [][]int) (int, int, int) {
	if col+1 >= len(trails[0]) || col+1 < 0 {
		return -1, -1, -1
	} else {
		return row, col + 1, trails[row][col+1]
	}
}

func getBelow(row, col int, trails [][]int) (int, int, int) {
	if row+1 >= len(trails) || row+1 < 0 {
		return -1, -1, -1
	} else {
		return row + 1, col, trails[row+1][col]
	}
}

func getLeft(row, col int, trails [][]int) (int, int, int) {
	if col-1 >= len(trails) || col-1 < 0 {
		return -1, -1, -1
	} else {
		return row, col - 1, trails[row][col-1]
	}
}

func countTrails(trailTops []pos) int {
	uniqueTrails := map[string]bool{}
	for _, top := range trailTops {
		s := strconv.Itoa(top[0]) + strconv.Itoa(top[1])
		uniqueTrails[s] = true
	}
	return len(uniqueTrails)
}

func findTrailheads(trails [][]int, nextToSearch []pos) int {

	if len(nextToSearch) == 0 {
		return 0
	}

	curr := trails[nextToSearch[0][0]][nextToSearch[0][1]]

	if curr == 9 {
		return countTrails(nextToSearch)
	}

	newToSearch := []pos{}

	for _, elem := range nextToSearch {
		row := elem[0]
		col := elem[1]

		above_i, above_j, above := getAbove(row, col, trails)
		right_i, right_j, right := getRight(row, col, trails)
		below_i, below_j, below := getBelow(row, col, trails)
		left_i, left_j, left := getLeft(row, col, trails)

		if above == curr+1 {
			newToSearch = append(newToSearch, pos{above_i, above_j})
		}
		if right == curr+1 {
			newToSearch = append(newToSearch, pos{right_i, right_j})

		}
		if below == curr+1 {
			newToSearch = append(newToSearch, pos{below_i, below_j})

		}
		if left == curr+1 {
			newToSearch = append(newToSearch, pos{left_i, left_j})

		}
	}

	return findTrailheads(trails, newToSearch)
}

func part1(scanner *bufio.Scanner) int {

	trails := [][]int{}

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		trails = append(trails, toIntList(items))
	}

	sum := 0

	for i, row := range trails {
		for j, col := range row {
			if col == 0 {
				trailheads := findTrailheads(trails, []pos{{i, j}})
				sum += trailheads
			}
		}
	}

	return sum
}
