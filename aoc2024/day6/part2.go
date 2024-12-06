package main

import (
	"bufio"
	"strings"
)

func part2(scanner *bufio.Scanner) int {
	mapped := [][]string{}

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		mapped = append(mapped, items)
	}

	test := 0

	for i, row := range mapped {
		for j, col := range row {
			copy_mapped := make([][]string, len(mapped))
			for k := range mapped {
				copy_mapped[k] = append([]string{}, mapped[k]...)
			}

			if col == "." {
				copy_mapped[i][j] = "#"
				_, err := traverseMap(copy_mapped)
				if err != nil {
					test += 1
				}
			}
		}
	}

	return test
}
