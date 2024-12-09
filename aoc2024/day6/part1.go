package main

import (
	"bufio"
	"errors"
	"strings"
)

type Dir int

const (
	UP Dir = iota
	RIGHT
	DOWN
	LEFT
)

func getStartPosAndDir(mapped [][]string) (int, int, Dir) {
	for i, row := range mapped {
		for j, col := range row {
			if col == "^" {
				return i, j, Dir(UP)
			} else if col == ">" {
				return i, j, Dir(RIGHT)
			} else if col == "v" {
				return i, j, Dir(DOWN)
			} else if col == "<" {
				return i, j, Dir(LEFT)
			}
		}
	}
	return 0, 0, Dir(UP)
}

func NewPosAndDir(posy int, posx int, dir Dir, mapped [][]string) (int, int, Dir, error) {
	if dir == Dir(DOWN) {
		if posy+1 >= len(mapped) {
			return 0, 0, dir, errors.New("")
		}
		if mapped[posy+1][posx] == "#" {
			return posy, posx, Dir(LEFT), nil
		}
		return posy + 1, posx, Dir(DOWN), nil
	} else if dir == Dir(UP) {
		if posy-1 < 0 {
			return 0, 0, dir, errors.New("")
		}
		if mapped[posy-1][posx] == "#" {
			return posy, posx, Dir(RIGHT), nil
		}
		return posy - 1, posx, Dir(UP), nil
	} else if dir == Dir(RIGHT) {
		if posx+1 >= len(mapped[0]) {
			return 0, 0, dir, errors.New("")
		}
		if mapped[posy][posx+1] == "#" {
			return posy, posx, Dir(DOWN), nil
		}
		return posy, posx + 1, Dir(RIGHT), nil
	} else if dir == Dir(LEFT) {
		if posx-1 < 0 {
			return 0, 0, dir, errors.New("")
		}
		if mapped[posy][posx-1] == "#" {
			return posy, posx, Dir(UP), nil
		}
		return posy, posx - 1, Dir(LEFT), nil
	}

	return 0, 0, Dir(UP), nil
}

func traverseMap(mapped [][]string) (int, error) {
	visited := 0

	startposy, startposx, startdir := getStartPosAndDir(mapped)

	posx := startposx
	posy := startposy
	dir := startdir

	n := 0
	for n < 100000 {
		if mapped[posy][posx] != "X" {
			visited += 1
			mapped[posy][posx] = "X"
		}

		newposy, newposx, newdir, err := NewPosAndDir(posy, posx, dir, mapped)
		if err != nil {
			return visited, nil
		}

		posy = newposy
		posx = newposx
		dir = newdir

		n += 1
	}

	return visited, errors.New("")
}

func part1(scanner *bufio.Scanner) int {
	mapped := [][]string{}

	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		mapped = append(mapped, items)
	}

	vis, _ := traverseMap(mapped)
	return vis
}
