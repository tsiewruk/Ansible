# Colors for messages
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RED    := $(shell tput -Txterm setaf 1)
RESET  := $(shell tput -Txterm sgr0)

# Default paths
YAML_PATH ?= .
PLAYBOOK_PATH ?= 

# Define phony targets (targets that don't represent files)
.PHONY: all test lint yamllint ansible-lint

# Default target - runs all tests
all: test

# Run all tests
test: lint
	@echo "${GREEN}All tests completed successfully${RESET}"

# Run all linting tests
lint: yamllint ansible-lint
	@echo "${GREEN}All lint tests completed successfully${RESET}"

# Run YAML lint checks
yamllint:
	@echo "${YELLOW}=== Running YAML lint tests... ===${RESET}"
	@if [ -f "$(YAML_PATH)" ]; then \
		echo "${YELLOW}Checking specific YAML file: $(YAML_PATH)${RESET}"; \
		yamllint "$(YAML_PATH)" && echo "${GREEN}YAML lint: OK${RESET}" || (echo "${RED}YAML lint: ERROR${RESET}" && exit 1); \
	else \
		echo "${YELLOW}Checking YAML files in directory: $(YAML_PATH)${RESET}"; \
		yamllint "$(YAML_PATH)" && echo "${GREEN}YAML lint: OK${RESET}" || (echo "${RED}YAML lint: ERROR${RESET}" && exit 1); \
	fi

# Run Ansible lint checks
ansible-lint:
	@echo "${YELLOW}=== Running Ansible lint tests... ===${RESET}"
	@if [ -f "$(PLAYBOOK_PATH)" ]; then \
		echo "${YELLOW}Checking specific playbook: $(PLAYBOOK_PATH)${RESET}"; \
		ansible-lint "$(PLAYBOOK_PATH)" && echo "${GREEN}Ansible lint: OK${RESET}" || (echo "${RED}Ansible lint: ERROR${RESET}" && exit 1); \
	else \
		echo "${YELLOW}Checking playbooks in directory: $(PLAYBOOK_PATH)${RESET}"; \
		ansible-lint && echo "${GREEN}Ansible lint: OK${RESET}" || (echo "${RED}Ansible lint: ERROR${RESET}" && exit 1); \
	fi

