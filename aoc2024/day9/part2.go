package main

import (
	"bufio"
	"slices"
	"strconv"
	"strings"
)

type File struct {
	id   int
	size int
}

type block struct {
	free    bool
	file    File
	checked bool
}

func checkDone(blocks []block) bool {
	seenTrue := false

	for _, value := range blocks {
		if seenTrue && !value.free {
			return false
		}
		if value.free {
			seenTrue = true
		}
	}

	return true
}

func getFirstFreeBlock(blocks []block, maxPos int, size int) (block, int) {
	for i := 0; i < len(blocks); i++ {
		if i > maxPos {
			return block{}, -1
		}
		if blocks[i].free && blocks[i].file.size >= size {
			return blocks[i], i
		}
	}

	return block{}, -1
}

func getIndex(blocks []block, index int) int {
	res := 0
	for i := index; i >= 0; i-- {
		res += blocks[i].file.size
	}
	return res
}

func part2(scanner *bufio.Scanner) int {
	blocks := []block{}

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		for id, it := range items {
			int_it, _ := strconv.Atoi(it)
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

	res := 0

	for i := len(blocks) - 1; i >= 0; i-- {
		bl := blocks[i]

		if bl.checked {
			continue
		}

		if bl.free {
			continue
		}

		file, index := getFirstFreeBlock(blocks, i, bl.file.size)
		if index == -1 {
			continue
		}
		tmp_file := file
		tmp_bl := bl
		tmp_bl.checked = true

		blocks[i] = tmp_file
		blocks[index] = tmp_bl
		blocks[i].file.size = tmp_bl.file.size

		if tmp_file.file.size > bl.file.size {
			padding := block{
				free: true,
				file: File{
					id:   -1,
					size: tmp_file.file.size - bl.file.size,
				},
			}

			blocks = slices.Insert(blocks, index+1, padding)
		}
	}

	for pos, b := range blocks {
		if !b.free {
			calcindex := getIndex(blocks, pos)
			for i := 0; i < b.file.size; i++ {
				res += (calcindex - i - 1) * b.file.id
			}
		}
	}

	return res
}
