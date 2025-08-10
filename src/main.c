#include <stdio.h>
#include <stdlib.h>

int one() {
	puts("Starting one..");
	const char* fname = "aoc/2015/001/input.txt";
	int is_ok = EXIT_FAILURE;

	FILE* fp = fopen(fname, "r");
	if (!fp) {
		perror("Failed to open file");
		return is_ok;
	}

	int c;
	int floor = 0;
	while ((c = fgetc(fp)) != EOF) {
		if (c == '(') {
			floor++;
		} else if (c == ')') {
			floor--;
		}
	}

	printf("Santa is on floor: %d\n", floor);

	if (ferror(fp)) {
		puts("Failed to read");
	} else if (feof(fp)) {
		puts("Reached end of file");
		is_ok = EXIT_SUCCESS;
	}

	fclose(fp);
	printf("\n");
	return is_ok;
}

int two() {
	puts("Starting two..");
	const char* fname = "aoc/2015/001/input.txt";
	int is_ok = EXIT_FAILURE;

	FILE* fp = fopen(fname, "r");
	if (!fp) {
		perror("Failed to open file");
		return is_ok;
	}

	int c;
	int floor = 0;
	int index = 0;
	while ((c = fgetc(fp)) != EOF) {
		if (floor == -1) {
			break;
		}
		if (c == '(') {
			floor++;
			index++;
		} else if (c == ')') {
			floor--;
			index++;
		}
	}

	printf("Santa is on basement floor %d at position %d\n", floor, index);

	if (feof(fp)) {
		puts("Reached end of file");
		is_ok = EXIT_SUCCESS;
	} else if (ferror(fp)) {
		puts("Failed to read");
	} else {
		puts("Stopped early");
	}

	fclose(fp);
	return is_ok;
}

int main() {
	one();
	two();
	return 0;
}

