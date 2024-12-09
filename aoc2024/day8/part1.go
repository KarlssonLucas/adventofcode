package main

import (
	"bufio"
	"fmt"
	"math"
	"strconv"
	"strings"
)

type antennas [][]int

type pos []int

var m map[string]antennas

func getDist(pos1 pos, pos2 pos) float64 {
	return math.Sqrt(math.Pow(float64(pos1[0]-pos2[0]), float64(2)) + math.Pow(float64(pos1[1]-pos2[1]), float64(2)))
}

func GetLinePoints(x1, y1, x2, y2, leni, lenj int) []pos {
	var points []pos

	// Calculate differences
	dx := x1 - x2
	dy := y1 - y2

	for {
		// Append the current point
		points = append(points, pos{x1, y1})

		if x1 >= leni-int(math.Abs(float64(dx))) || x1 < int(math.Abs(float64(dx))) || y1 >= lenj-int(math.Abs(float64(dy))) || y1 < int(math.Abs(float64(dy))) {
			break
		}

		x1 = x1 + dx
		y1 = y1 + dy

	}

	return points
}

func getAntinodes(ant1 pos, ant2 pos, matrix [][]string) []pos {

	antinodes := []pos{}

	points1 := GetLinePoints(ant1[0], ant1[1], ant2[0], ant2[1], len(matrix), len(matrix[0]))
	points2 := GetLinePoints(ant2[0], ant2[1], ant1[0], ant1[1], len(matrix), len(matrix[0]))

	points1 = append(points1, points2...)

	for _, p := range points1 {
		//if (p[0] == ant1[0] && p[1] == ant1[1]) || (p[0] == ant2[0] && p[1] == ant2[1]) {
		//	continue
		//}

		//if (getDist(p, ant1)*2 == getDist(p, ant2)) || (getDist(p, ant1) == getDist(p, ant2)*2) {
		antinodes = append(antinodes, p)
		//}
	}

	return antinodes
}

func countUniqueRows(matrix []pos) int {
	// Map to store unique rows
	uniqueRows := make(map[string]struct{})

	// Iterate through the rows of the matrix
	for _, row := range matrix {
		// Convert row to a string (or another comparable form)
		rowStr := convertRowToString(row)

		// Add the string representation of the row to the map
		uniqueRows[rowStr] = struct{}{}
	}

	// The number of unique rows is the size of the map
	return len(uniqueRows)
}

// Helper function to convert a row to a string
func convertRowToString(row pos) string {
	var result string
	for _, val := range row {
		result += strconv.Itoa(val) + ","
	}
	return result
}

func part1(scanner *bufio.Scanner) string {
	m = make(map[string]antennas)

	antinodes := []pos{}

	matrix := [][]string{}

	i := 0
	for scanner.Scan() {
		line := scanner.Text()
		items := strings.Split(line, "")
		matrix = append(matrix, items)
		for j, it := range items {
			if it != "." {
				m[it] = append(m[it], pos{i, j})
			}
		}
		i += 1
	}

	for _, value := range m {
		for i := 0; i < len(value); i++ {
			for j := i + 1; j < len(value); j++ {
				antin := getAntinodes(value[i], value[j], matrix)
				antinodes = append(antinodes, antin...)
			}
		}
	}
	fmt.Println(len(antinodes))
	fmt.Println(countUniqueRows(antinodes))

	return ("part1")
}
