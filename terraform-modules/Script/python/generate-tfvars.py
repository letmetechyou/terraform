##this was built to help create the needed tfvars
#file from a csv of subnet names and prefixes

import csv
import os


# Example usage
csv_file = "subnet.csv"
output_file = "subnet.tf"


def generate_terraform_config(csv_file, output_file):
    """Generates a Terraform configuration from a CSV file.

    Args:
        csv_file (str): Path to the CSV file.
        output_file (str): Path to the output Terraform file.
    """

    subnets = []
    with open(csv_file, 'r', encoding='utf-8-sig') as csvfile:
        reader = csv.DictReader(csvfile, delimiter=',')
        headers = reader.fieldnames
        print(f"CSV Headers: {headers}")  # Print headers for debugging
        for row in reader:
            try:
                subnets.append({
                    'name': row['SubnetName'].strip(),
                    'cidr': row['SubnetCIDR'].strip()
                })
            except KeyError as e:
                print(f"Error processing row: {e}")

    # Replace placeholders with actual values
    subscription_id = ""
    resource_group_name = ""
    virtual_network_name = ""

    with open(output_file, 'w') as tf_file:
        for subnet in subnets:
            tf_file.write(f"""
{subnet['name']} = {{
  name                = "{subnet['name']}"
  enabled             = true
  import              = true
  import_resource_id = "/subscriptions/{subscription_id}/resourceGroups/{resource_group_name}/providers/Microsoft.Network/virtualNetworks/{virtual_network_name}/subnets/{subnet['name']}"
  address_prefixes      = ["{subnet['cidr']}"]
  resource_group_name = "{resource_group_name}"
  virtual_network_name = "{virtual_network_name}"
}}
            """)

generate_terraform_config(csv_file, output_file)


