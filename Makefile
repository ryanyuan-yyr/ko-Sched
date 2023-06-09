TESTS := build/matrix_mul.so build/matrix_transpose.so build/sqrt_pow.so build/vec_add.so
# TESTS := build/matrix_transpose.so
CFLAGS := -Wall -Werror -O3 -g -fPIC
NVCC_FLAGS:= -Iinclude --compiler-options="$(CFLAGS)"
NVCC := nvcc
COMMON_DEPENDENCY := include/* build/utility.o

# runtests

run_tests:build_run_tests
	./bin/run_tests

build_run_tests: bin/run_tests

bin/run_tests: build/run_tests.o $(TESTS) $(COMMON_DEPENDENCY)
	$(NVCC) build/run_tests.o $(NVCC_FLAGS) $(TESTS) build/utility.o -o bin/run_tests

build/run_tests.o: src/run_tests.cu $(COMMON_DEPENDENCY)
	$(NVCC) -c src/run_tests.cu $(NVCC_FLAGS) -o build/run_tests.o


# eval_config

eval_config:build_eval_config
	./bin/eval_config

build_eval_config: bin/eval_config

bin/eval_config: build/eval_config.o $(TESTS) $(COMMON_DEPENDENCY)
	$(NVCC) build/eval_config.o $(NVCC_FLAGS) $(TESTS) build/utility.o -o bin/eval_config

build/eval_config.o: src/eval_config.cu $(COMMON_DEPENDENCY)
	$(NVCC) -c src/eval_config.cu $(NVCC_FLAGS) -o build/eval_config.o


# automatic_config

automatic_config:build_automatic_config
	./bin/automatic_config

build_automatic_config: bin/automatic_config

bin/automatic_config: build/automatic_config.o $(TESTS) $(COMMON_DEPENDENCY)
	$(NVCC) build/automatic_config.o $(NVCC_FLAGS) $(TESTS) build/utility.o -o bin/automatic_config

build/automatic_config.o: src/automatic_config.cu $(COMMON_DEPENDENCY)
	$(NVCC) -c src/automatic_config.cu $(NVCC_FLAGS) -o build/automatic_config.o


# tests

build/matrix_mul.so: tests/matrix_mul/matrix_mul.cu $(COMMON_DEPENDENCY)
	$(NVCC) --shared tests/matrix_mul/matrix_mul.cu $(NVCC_FLAGS) -o build/matrix_mul.so

build/matrix_transpose.so: tests/matrix_transpose/matrix_transpose.cu $(COMMON_DEPENDENCY)
	$(NVCC) --shared tests/matrix_transpose/matrix_transpose.cu $(NVCC_FLAGS) -o build/matrix_transpose.so

build/sqrt_pow.so: tests/sqrt_pow/sqrt_pow.cu $(COMMON_DEPENDENCY)
	$(NVCC) --shared tests/sqrt_pow/sqrt_pow.cu $(NVCC_FLAGS) -o build/sqrt_pow.so

build/vec_add.so: tests/vec_add/vec_add.cu $(COMMON_DEPENDENCY)
	$(NVCC) --shared tests/vec_add/vec_add.cu $(NVCC_FLAGS) -o build/vec_add.so

build/utility.o: src/utility/utility.cu include/utility.cuh
	$(NVCC) -c src/utility/utility.cu $(NVCC_FLAGS) -o build/utility.o

clean:
	rm -r build/*