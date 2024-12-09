package main

import (
	"bufio"
	"strings"
	"sync"
	"sync/atomic"
)

func part2(scanner *bufio.Scanner) int64 {
	mapped := [][]string{}

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		mapped = append(mapped, items)
	}

	var test int64 = 0

	wg := sync.WaitGroup{}

	for i, row := range mapped {
		for j, col := range row {
			wg.Add(1)
			go func() {
				defer wg.Done()
				copy_mapped := make([][]string, len(mapped))
				for k := range mapped {
					copy_mapped[k] = append([]string{}, mapped[k]...)
				}

				if col == "." {
					copy_mapped[i][j] = "#"
					_, err := traverseMap(copy_mapped)
					if err != nil {
						_ = atomic.AddInt64(&test, 1) // increment atomically
					}
				}
			}()
		}
	}
	wg.Wait()

	return test
}
