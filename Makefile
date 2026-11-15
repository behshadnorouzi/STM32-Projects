# Command-line build for every project in this repository.
# Requires the Arm GNU toolchain (arm-none-eabi-gcc) on PATH.
#
#   make                  build all projects into build/
#   make 03-i2c-scanner   build a single project
#   make clean

# Every folder with a Core/ directory is a CubeIDE project.
PROJECTS := $(patsubst %/Core,%,$(wildcard */Core))

.PHONY: all clean $(PROJECTS)

all: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -f project.mk PROJECT=$@

clean:
	rm -rf build
