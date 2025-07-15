#!/bin/bash

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Prompt the user for the API address
echo -e "${BLUE}Enter the API address:${NC}"
read -r API_ADDRESS

# Check if the API address is empty
if [ -z "$API_ADDRESS" ]; then
  echo -e "${RED}Error: No API address provided. Please enter a valid API address.${NC}"
  exit 1
fi

# Path to the env.dart file
ENV_FILE_PATH="./lib/core/utils/env.dart"
# Path to the config.toml file
TOML_FILE_PATH="./supabase/config.toml"
# Path to the .env.local file
ENV_LOCAL_FILE_PATH="./.env.local"

# Function to resolve absolute path
resolve_path() {
  local path="$1"
  realpath "$path" 2>/dev/null || echo "$(pwd)/$path" | sed 's|/\./|/|g'
}

# Resolve absolute paths
ENV_FILE_PATH=$(resolve_path "$ENV_FILE_PATH")
TOML_FILE_PATH=$(resolve_path "$TOML_FILE_PATH")
ENV_LOCAL_FILE_PATH=$(resolve_path "$ENV_LOCAL_FILE_PATH")

# Check if env.dart file exists
if [ ! -f "$ENV_FILE_PATH" ]; then
  echo -e "${RED}Error: File $ENV_FILE_PATH not found!${NC}"
  exit 1
fi

# Check if config.toml file exists
if [ ! -f "$TOML_FILE_PATH" ]; then
  echo -e "${RED}Error: File $TOML_FILE_PATH not found!${NC}"
  exit 1
fi

# Check if .env.local file exists
if [ ! -f "$ENV_LOCAL_FILE_PATH" ]; then
  echo -e "${RED}Error: File $ENV_LOCAL_FILE_PATH not found!${NC}"
  exit 1
fi

echo -e "${BLUE}Using API address: $API_ADDRESS${NC}"
echo -e "${BLUE}Checking file: $ENV_FILE_PATH${NC}"
# Check if debugApiIpAddress is set to the desired API_ADDRESS in env.dart
if grep -q "debugApiIpAddress = '$API_ADDRESS'" "$ENV_FILE_PATH"; then
  echo -e "${GREEN}debugApiIpAddress is already set to '$API_ADDRESS'.${NC}"
else
  echo -e "${BLUE}Updating debugApiIpAddress to '$API_ADDRESS'...${NC}"
  # Replace the debugApiIpAddress line
  sed -i '' "s/static const String debugApiIpAddress = '[^']*'/static const String debugApiIpAddress = '$API_ADDRESS'/" "$ENV_FILE_PATH"
  # Verify the change
  if grep -q "debugApiIpAddress = '$API_ADDRESS'" "$ENV_FILE_PATH"; then
    echo -e "${GREEN}Successfully updated debugApiIpAddress to '$API_ADDRESS'.${NC}"
  else
    echo -e "${RED}Error: Failed to update debugApiIpAddress!${NC}"
    exit 1
  fi
fi

echo -e "${BLUE}Checking file: $TOML_FILE_PATH${NC}"
# Check if site_url is set to the desired http://API_ADDRESS:8080 in config.toml
if grep -q "site_url = \"http://$API_ADDRESS:8080\"" "$TOML_FILE_PATH"; then
  echo -e "${GREEN}site_url is already set to 'http://$API_ADDRESS:8080'.${NC}"
else
  echo -e "${BLUE}Updating site_url to 'http://$API_ADDRESS:8080'...${NC}"
  # Replace the site_url line
  sed -i '' "s|site_url = \"[^\"]*\"|site_url = \"http://$API_ADDRESS:8080\"|" "$TOML_FILE_PATH"
  # Verify the change
  if grep -q "site_url = \"http://$API_ADDRESS:8080\"" "$TOML_FILE_PATH"; then
    echo -e "${GREEN}Successfully updated site_url to 'http://$API_ADDRESS:8080'.${NC}"
  else
    echo -e "${RED}Error: Failed to update site_url!${NC}"
    exit 1
  fi
fi

# Check if api_url is set to the desired http://API_ADDRESS in config.toml
if grep -q "api_url = \"http://$API_ADDRESS\"" "$TOML_FILE_PATH"; then
  echo -e "${GREEN}api_url is already set to 'http://$API_ADDRESS'.${NC}"
else
  echo -e "${BLUE}Updating api_url to 'http://$API_ADDRESS'...${NC}"
  # Replace the api_url line
  sed -i '' "s|api_url = \"[^\"]*\"|api_url = \"http://$API_ADDRESS\"|" "$TOML_FILE_PATH"
  # Verify the change
  if grep -q "api_url = \"http://$API_ADDRESS\"" "$TOML_FILE_PATH"; then
    echo -e "${GREEN}Successfully updated api_url to 'http://$API_ADDRESS'.${NC}"
  else
    echo -e "${RED}Error: Failed to update api_url!${NC}"
    exit 1
  fi
fi

# Check if additional_redirect_urls Web (External device) is set to the desired http://API_ADDRESS:8080
echo -e "${BLUE}Checking additional_redirect_urls in: $TOML_FILE_PATH${NC}"
# Look for the comment and check if the next line has the correct value
if grep -A 1 "# Web (External device)" "$TOML_FILE_PATH" | grep -q "\"http://$API_ADDRESS:8080\""; then
  echo -e "${GREEN}additional_redirect_urls Web (External device) is already set to 'http://$API_ADDRESS:8080'.${NC}"
else
  echo -e "${BLUE}Updating additional_redirect_urls Web (External device) to 'http://$API_ADDRESS:8080'...${NC}"
  # Replace the line following the comment # Web (External device)
  sed -i '' "/# Web (External device)/{n;s|\"[^\"]*\"|\"http://$API_ADDRESS:8080\"|;}" "$TOML_FILE_PATH"
  # Verify the change
  if grep -A 1 "# Web (External device)" "$TOML_FILE_PATH" | grep -q "\"http://$API_ADDRESS:8080\""; then
    echo -e "${GREEN}Successfully updated additional_redirect_urls Web (External device) to 'http://$API_ADDRESS:8080'.${NC}"
  else
    echo -e "${RED}Error: Failed to update additional_redirect_urls Web (External device)!${NC}"
    exit 1
  fi
fi

# Check if additional_redirect_urls Web (External device) with ?invite-verified is set to the desired http://API_ADDRESS:8080?invite-verified
echo -e "${BLUE}Checking additional_redirect_urls Web (External device) with ?invite-verified in: $TOML_FILE_PATH${NC}"
# Look for the comment and check if the second next line has the correct value
if grep -A 2 "# Web (External device)" "$TOML_FILE_PATH" | grep -q "\"http://$API_ADDRESS:8080?invite-verified\""; then
  echo -e "${GREEN}additional_redirect_urls Web (External device) with ?invite-verified is already set to 'http://$API_ADDRESS:8080?invite-verified'.${NC}"
else
  echo -e "${BLUE}Updating additional_redirect_urls Web (External device) with ?invite-verified to 'http://$API_ADDRESS:8080?invite-verified'...${NC}"
  # Replace the line two lines after the comment # Web (External device)
  sed -i '' "/# Web (External device)/{n;n;s|\"[^\"]*\"|\"http://$API_ADDRESS:8080?invite-verified\"|;}" "$TOML_FILE_PATH"
  # Verify the change
  if grep -A 2 "# Web (External device)" "$TOML_FILE_PATH" | grep -q "\"http://$API_ADDRESS:8080?invite-verified\""; then
    echo -e "${GREEN}Successfully updated additional_redirect_urls Web (External device) with ?invite-verified to 'http://$API_ADDRESS:8080?invite-verified'.${NC}"
  else
    echo -e "${RED}Error: Failed to update additional_redirect_urls Web (External device) with ?invite-verified!${NC}"
    exit 1
  fi
fi

echo -e "${BLUE}Checking file: $ENV_LOCAL_FILE_PATH${NC}"
# Check if SUPABASE_URL is set to the desired http://API_ADDRESS:54321 in .env.local
if grep -q "SUPABASE_URL=http://$API_ADDRESS:54321" "$ENV_LOCAL_FILE_PATH"; then
  echo -e "${GREEN}SUPABASE_URL is already set to 'http://$API_ADDRESS:54321'.${NC}"
else
  echo -e "${BLUE}Updating SUPABASE_URL to 'http://$API_ADDRESS:54321'...${NC}"
  # Replace the SUPABASE_URL line
  sed -i '' "s|SUPABASE_URL=.*|SUPABASE_URL=http://$API_ADDRESS:54321|" "$ENV_LOCAL_FILE_PATH"
  # Verify the change
  if grep -q "SUPABASE_URL=http://$API_ADDRESS:54321" "$ENV_LOCAL_FILE_PATH"; then
    echo -e "${GREEN}Successfully updated SUPABASE_URL to 'http://$API_ADDRESS:54321'.${NC}"
  else
    echo -e "${RED}Error: Failed to update SUPABASE_URL!${NC}"
    exit 1
  fi
fi