#!/bin/bash

# Cross-platform script to update .copilot agents and skills
set -e

# Default mode
QUICK_MODE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -q|--quick)
            QUICK_MODE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  -q, --quick    Quick mode (minimal output)"
            echo "  -h, --help     Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    if [ "$QUICK_MODE" = false ]; then
        echo -e "${BLUE}[INFO]${NC} $1"
    fi
}

print_success() {
    if [ "$QUICK_MODE" = false ]; then
        echo -e "${GREEN}[SUCCESS]${NC} $1"
    fi
}

print_warning() {
    if [ "$QUICK_MODE" = false ]; then
        echo -e "${YELLOW}[WARNING]${NC} $1"
    fi
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_always() {
    echo -e "${GREEN}$1${NC}"
}

# Detect OS and set .copilot location
detect_copilot_location() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
        # Windows
        COPILOT_DIR="$USERPROFILE/.copilot"
    else
        # macOS/Linux
        COPILOT_DIR="$HOME/.copilot"
    fi
    
    print_status "Detected .copilot location: $COPILOT_DIR"
}

# Create directories if they don't exist
create_directories() {
    print_status "Creating directories if needed..."
    mkdir -p "$COPILOT_DIR/agents"
    mkdir -p "$COPILOT_DIR/skills"
    print_success "Directories created/verified"
}

# Update repository
update_repository() {
    print_status "Updating repository..."
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository. Please run this script from the agents repository."
        exit 1
    fi
    
    # Stash any local changes
    if ! git diff-index --quiet HEAD --; then
        print_warning "Local changes detected. Stashing..."
        git stash push -m "Auto-stash before update $(date)"
    fi
    
    # Pull latest changes
    git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || {
        print_error "Failed to pull changes. Please check your git configuration."
        exit 1
    }
    
    print_success "Repository updated"
}

# Copy agents
copy_agents() {
    print_status "Copying agents..."
    
    # Count agent files
    agent_count=$(find . -maxdepth 1 -name "*.agent.md" | wc -l)
    
    if [ "$agent_count" -eq 0 ]; then
        print_warning "No agent files (*.agent.md) found in current directory"
    else
        # Copy agent files
        find . -maxdepth 1 -name "*.agent.md" -exec cp {} "$COPILOT_DIR/agents/" \;
        print_success "Copied $agent_count agent(s) to $COPILOT_DIR/agents/"
        
        # List copied agents
        find . -maxdepth 1 -name "*.agent.md" -exec basename {} \; | while read -r agent; do
            print_status "  → $agent"
        done
    fi
}

# Copy skills
copy_skills() {
    print_status "Copying skills..."
    
    if [ ! -d "skills" ]; then
        print_warning "Skills directory not found"
        return
    fi
    
    # Count skill directories
    skill_count=$(find skills -maxdepth 1 -type d | tail -n +2 | wc -l)
    
    if [ "$skill_count" -eq 0 ]; then
        print_warning "No skill directories found in skills/"
    else
        # Copy skill directories
        find skills -maxdepth 1 -type d | tail -n +2 | while read -r skill_dir; do
            skill_name=$(basename "$skill_dir")
            print_status "  → Copying skill: $skill_name"
            cp -r "$skill_dir" "$COPILOT_DIR/skills/"
        done
        
        print_success "Copied $skill_count skill(s) to $COPILOT_DIR/skills/"
    fi
}

# Copy notes if they exist
copy_notes() {
    if [ -d "notes" ]; then
        print_status "Copying notes..."
        cp -r notes "$COPILOT_DIR/" 2>/dev/null || {
            mkdir -p "$COPILOT_DIR/notes"
            cp -r notes/* "$COPILOT_DIR/notes/" 2>/dev/null || true
        }
        print_success "Notes copied to $COPILOT_DIR/notes/"
    fi
}

# Verify installation
verify_installation() {
    print_status "Verifying installation..."
    
    echo
    print_status "Summary:"
    
    # Count agents
    if [ -d "$COPILOT_DIR/agents" ]; then
        agent_count=$(find "$COPILOT_DIR/agents" -name "*.agent.md" | wc -l)
        print_status "  Agents: $agent_count files in $COPILOT_DIR/agents/"
    fi
    
    # Count skills
    if [ -d "$COPILOT_DIR/skills" ]; then
        skill_count=$(find "$COPILOT_DIR/skills" -maxdepth 1 -type d | tail -n +2 | wc -l)
        print_status "  Skills: $skill_count directories in $COPILOT_DIR/skills/"
    fi
    
    # Check notes
    if [ -d "$COPILOT_DIR/notes" ]; then
        note_count=$(find "$COPILOT_DIR/notes" -name "*.md" | wc -l)
        print_status "  Notes: $note_count files in $COPILOT_DIR/notes/"
    fi
    
    echo
    print_success "Installation complete!"
    print_status "You may need to restart VS Code for changes to take effect."
}

# Main execution
main() {
    if [ "$QUICK_MODE" = false ]; then
        echo "🤖 Copilot Agents & Skills Updater"
        echo "=================================="
        echo
    fi
    
    detect_copilot_location
    create_directories
    update_repository
    copy_agents
    copy_skills
    copy_notes
    
    if [ "$QUICK_MODE" = true ]; then
        print_always "✅ Copilot agents and skills updated!"
    else
        verify_installation
    fi
}

# Run main function
main "$@"