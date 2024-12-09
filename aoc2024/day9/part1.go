package main

import (
	"bufio"
	"strconv"
	"strings"
)

func getLastFree(blocks []block, minPos int) (block, int) {
	for i := len(blocks) - 1; i >= 0; i-- {
		if i < minPos {
			return block{}, -1
		}
		if !blocks[i].free {
			return blocks[i], i
		}
	}

	return block{}, -1
}

func part1(scanner *bufio.Scanner) int {
	blocks := []block{}

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		for id, it := range items {
			int_it, _ := strconv.Atoi(it)
			for i := 0; i < int_it; i++ {
				var new_block block
				if id%2 == 0 {

					new_block = block{
						free: false,
						file: File{
							id:   id / 2,
							size: int_it,
						},
					}
				} else {
					new_block = block{
						free: true,
						file: File{id: -1, size: int_it},
					}
				}
				blocks = append(blocks, new_block)
			}
		}
	}

	res := 0

	for i, bl := range blocks {
		if bl.free {
			file, index := getLastFree(blocks, i)
			if index == -1 {
				continue
			}
			tmp_file := file
			tmp_bl := bl

			blocks[i] = tmp_file
			blocks[index] = tmp_bl
		} else {
			continue
		}

		if checkDone(blocks) {
			for pos, b := range blocks {
				if !b.free {
					res += pos * b.file.id
				}
			}
			break
		}
	}

	return res
}
