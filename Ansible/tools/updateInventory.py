import yaml
import sys


def replace_gcp_project(inventory_path, new_project_id):
    with open(inventory_path, 'r') as file:
        inventory = yaml.safe_load(file)

    if 'projects' in inventory:
        inventory['projects'] = [new_project_id]
    else:
        print("Error: 'projects' key not found in the inventory file.")
        return

    with open(inventory_path, 'w') as file:
        yaml.dump(inventory, file, default_flow_style=False)

    print(
        f"'gcp_project' has been replaced with '{new_project_id}' in {inventory_path}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python replace_gcp_project.py <inventory_file_path> <new_project_id>")
        sys.exit(1)

    inventory_file_path = sys.argv[1]
    new_project_id = sys.argv[2]
    replace_gcp_project(inventory_file_path, new_project_id)
