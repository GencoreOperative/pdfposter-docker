# Define the Docker image name
IMAGE_NAME := gencore/pdfposter

# Define the Git repository and default branch or commit
GIT_REPO := https://gitlab.com/pdftools/pdfposter.git
GIT_COMMIT ?= 7ebf6b59fdd

# Default target to build the Docker image
.PHONY: all
all: build

# Target to build the Docker image
.PHONY: build
build:
	docker build --build-arg GIT_COMMIT=$(GIT_COMMIT) \
	-t $(IMAGE_NAME):$(GIT_COMMIT) \
	-t $(IMAGE_NAME):latest \
	 .

# Target to clean up the Docker image
.PHONY: clean
clean:
	docker rmi -f $(IMAGE_NAME)

# Target to run the Docker container
.PHONY: run
run:
	-docker run -v $(pwd):/data --rm -it $(IMAGE_NAME)

# Print help message
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make [TARGET] [GIT_COMMIT=<commit>]"
	@echo ""
	@echo "Targets:"
	@echo "  all         - Build the Docker image (default)"
	@echo "  build       - Build the Docker image"
	@echo "  clean       - Remove the Docker image"
	@echo "  run         - Run the Docker container"
	@echo "  help        - Show this help message"
	@echo ""
	@echo "Variables:"
	@echo "  GIT_COMMIT  - Specify the Git commit (default: master)"
