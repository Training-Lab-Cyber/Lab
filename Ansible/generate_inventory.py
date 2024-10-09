import json
import sys

def generate_inventory(input_file, output_file):
    with open(input_file) as f:
        outputs = json.load(f)

    apache_ip = outputs['http_internal_ip']['value']

    with open(output_file, 'w') as inventory:
        inventory.write('[apache]\n')
        inventory.write(f'{apache_ip}\n')

if __name__ == "__main__":
    input_file = sys.argv[1] if len(sys.argv) > 1 else 'terraform_output.json'
    output_file = sys.argv[2] if len(sys.argv) > 2 else 'inventory.ini'
    generate_inventory(input_file, output_file)