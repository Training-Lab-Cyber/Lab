import os
import json
import argparse
import requests
import re

# Define function to create agent policy


def create_agent_policy(agent_policy_data, kibana_url, kibana_username, kibana_password):
    url = f"{kibana_url}/api/fleet/agent_policies"
    headers = {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'kbn-xsrf': 'reporting'
    }

    response = requests.post(url, json=agent_policy_data, auth=(
        kibana_username, kibana_password), headers=headers)

    if response.status_code == 200:
        policy_id = response.json().get('item', {}).get('id')
        print(
            f"Agent Policy '{agent_policy_data['name']}' created successfully with ID: {policy_id}")
        return policy_id
    elif response.status_code == 409:
        # Handle the case where the Agent Policy already exists (409 Conflict)
        error_message = response.json().get('message')
        if error_message:
            # Use a regex to extract the existing policy ID from the error message
            match = re.search(
                r"Agent Policy '([a-f0-9-]+)' already exists", error_message)
            if match:
                existing_policy_id = match.group(1)
                print(
                    f"Agent Policy already exists with ID: {existing_policy_id}. Continuing with existing policy.")
                return existing_policy_id
            else:
                print(f"Error: Could not extract policy ID from error message.")
                return None
    else:
        print(
            f"Failed to create Agent Policy: {response.status_code}, {response.text}")
        return None

# Define function to create package policies


def create_package_policy(package_policy_data, kibana_url, kibana_username, kibana_password):
    url = f"{kibana_url}/api/fleet/package_policies"
    headers = {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'kbn-xsrf': 'reporting'
    }

    response = requests.post(url, json=package_policy_data, auth=(
        kibana_username, kibana_password), headers=headers)

    if response.status_code == 200:
        print(
            f"Package Policy '{package_policy_data['name']}' created successfully.")
    else:
        print(
            f"Failed to create Package Policy: {response.status_code}, {response.text}")


def get_enrollment_api_key(agent_policy_id, kibana_url, kibana_username, kibana_password):
    url = f"{kibana_url}/api/fleet/enrollment_api_keys"
    headers = {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'kbn-xsrf': 'reporting'
    }

    response = requests.get(url, auth=(
        kibana_username, kibana_password), headers=headers)

    if response.status_code == 200:
        enrollment_keys = response.json().get('list', [])
        for key in enrollment_keys:
            if key.get('policy_id') == agent_policy_id:
                print(
                    f"Enrollment API Key for Agent Policy ID {agent_policy_id}: {key.get('api_key')}")
                return key.get('api_key')
        print(
            f"No enrollment API key found for Agent Policy ID {agent_policy_id}.")
        return None
    else:
        print(
            f"Failed to retrieve enrollment API keys: {response.status_code}, {response.text}")
        return None


def save_enrollment_api_key_to_file(agent_policy_name, api_key):
    file_path = "/tmp/enrollment_tokens.txt"

    # Ensure the file exists and is a valid JSON object
    if not os.path.exists(file_path):
        with open(file_path, 'w') as f:
            json.dump({}, f)

    # Load existing data
    with open(file_path, 'r') as f:
        try:
            existing_data = json.load(f)
        except json.JSONDecodeError:
            existing_data = {}

    # Add or update the key-value pair
    existing_data[agent_policy_name] = api_key

    # Write updated data back to the file
    with open(file_path, 'w') as f:
        json.dump(existing_data, f, indent=4)

    print(
        f"Enrollment API key for '{agent_policy_name}' saved to {file_path}.")


# Parse command-line arguments
def parse_arguments():
    parser = argparse.ArgumentParser(
        description="Create Agent and Package Policies in Kibana")
    parser.add_argument('--path', required=True,
                        help="Path to the directory containing AgentPolicy.json and packagepolicies")
    return parser.parse_args()

# Main function to orchestrate policy creation


def main():
    args = parse_arguments()
    path_to_files = args.path

    # Read the AgentPolicy.json file
    agent_policy_path = os.path.join(path_to_files, 'AgentPolicy.json')
    if not os.path.exists(agent_policy_path):
        print(f"AgentPolicy.json not found at {agent_policy_path}")
        return

    with open(agent_policy_path, 'r') as f:
        agent_policy_data = json.load(f)

    # Get Kibana credentials and URL from environment variables
    kibana_url = os.getenv("KIBANA_URL")
    kibana_username = os.getenv("KIBANA_USERNAME")
    kibana_password = os.getenv("KIBANA_PASSWORD")

    # Create agent policy
    agent_policy_id = create_agent_policy(
        agent_policy_data, kibana_url, kibana_username, kibana_password)
    if not agent_policy_id:
        print("Error: Agent policy creation failed. Exiting...")
        return

    enrollment_api_key = get_enrollment_api_key(
        agent_policy_id, kibana_url, kibana_username, kibana_password)
    if not enrollment_api_key:
        print("Error: Could not retrieve enrollment API key. Exiting...")
        return

    # Save the enrollment API key to the file
    save_enrollment_api_key_to_file(
        agent_policy_data['name'], enrollment_api_key)

    # Process the package policies
    package_policies_dir = os.path.join(path_to_files, 'packagepolicies')
    if not os.path.exists(package_policies_dir):
        print(f"packagepolicies directory not found at {package_policies_dir}")
        return

    for package_file in os.listdir(package_policies_dir):
        package_file_path = os.path.join(package_policies_dir, package_file)
        if not package_file.endswith('.json'):
            continue

        with open(package_file_path, 'r') as f:
            package_policy_data = json.load(f)

        # Set the policy_id for package policies
        package_policy_data['policy_id'] = agent_policy_id

        # Create package policy
        create_package_policy(package_policy_data, kibana_url,
                              kibana_username, kibana_password)


if __name__ == '__main__':
    main()
