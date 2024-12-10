package main

import (
	"bufio"
	"strings"
)

func findTrailheadsPart2(trails [][]int, nextToSearch []pos) int {

	if len(nextToSearch) == 0 {
		return 0
	}

	curr := trails[nextToSearch[0][0]][nextToSearch[0][1]]

	if curr == 9 {
		return len(nextToSearch)
		//return countTrails(nextToSearch)
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

	return findTrailheadsPart2(trails, newToSearch)
}

func part2(scanner *bufio.Scanner) int {

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
				trailheads := findTrailheadsPart2(trails, []pos{{i, j}})
				sum += trailheads
			}
		}
	}

	return sum
}
