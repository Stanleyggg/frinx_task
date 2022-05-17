import psycopg2
import json
from create_tables import connect
CHANNEL_GROUP = "Cisco-IOS-XE-ethernet:channel-group"
OUTER_KEY = "frinx-uniconfig-topology:configuration"
INTERFACE_KEY = "Cisco-IOS-XE-native:native"
FILE_PATH = "configClear_v2.json"


def get_interface(outer_key, inner_key, file_name):
    with open(file_name, "r") as file:
        json_obj = json.load(file)
        interface = json_obj[outer_key][inner_key]["interface"]
        return interface

    return None


def get_port_channel_id(port_channel):
    conn = connect()
    cur = conn.cursor()
    
    query = f"""SELECT id FROM interfaces WHERE name = 'Port-channel{port_channel}'"""

    cur.execute(query)

    port_id = cur.fetchone()
    cur.close()
    conn.close()

    if port_id:
        return port_id[0]

    return None


def get_insert_query(info):
    port_channel_id = None
    if info["port-channel"]:
        port_channel_id = get_port_channel_id(info["port-channel"])

    if not port_channel_id:
        port_channel_id = "NULL"

    if not info['mtu']:
        info['mtu'] = "NULL"

    query = f"""INSERT INTO interfaces(name, description, config, port_channel_id, max_frame_size)
                VALUES('{info['name']}', '{info['desc']}', '{json.dumps(info['config'])}', {port_channel_id}, {info['mtu']})
             """

    return query


def write_to_db(conn, info):
    cur = conn.cursor()
    query = get_insert_query(info)
    cur.execute(query)
    cur.close()
    conn.commit()
    

def fill_db():
    interface = get_interface(OUTER_KEY, INTERFACE_KEY, FILE_PATH)
    conn = connect()
    if not interface:
        print("Something went wrong while loading file")
        conn.close()
        return

    for item_type in "Port-channel", "TenGigabitEthernet", "GigabitEthernet":
        for info in get_info(interface, item_type):
            write_to_db(conn, info)
    
    conn.close()

   
def get_info(interface, group):
    for item in interface[group]:
        mtu = None
        port_channel = None
        desc = None
        config = item
        name = group + str(item["name"])
        
        if "description" in item:
            desc = item["description"]
        if "mtu" in item:
            mtu = item["mtu"]
        if CHANNEL_GROUP in item:
            port_channel = item[CHANNEL_GROUP]["number"]
        
        yield {"name": name, "desc": desc, "config": config, "port-channel": port_channel, "mtu": mtu}


if __name__ == '__main__':
    fill_db()











          
